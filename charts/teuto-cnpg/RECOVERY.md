# Check that a Barman backup restores

The `teuto-cnpg` chart creates a Barman Cloud `ObjectStore` when `backup` is set.
If `backup.schedule` is set, it also creates a plugin `ScheduledBackup`. Both
resources use the Helm release name, as does the PostgreSQL `Cluster`. A
completed `Backup` is a useful starting point; restoring it shows whether the
archive can start PostgreSQL and serve application data.

This procedure uses [cnpg-drill](https://github.com/danielgaskins/cnpg-drill/releases/tag/v0.1.2)
v0.1.2, which was [tested with a rendered `teuto-cnpg` chart](https://github.com/danielgaskins/cnpg-drill/blob/0f2f9d6c3303020a0f947b7e321d2c54057368c2/integration/local/README.md).
It applies to Barman Cloud plugin backups, not volume snapshots. Use a test
cluster before adding it to a production runbook.

1. Check the source resources and find a completed plugin backup:

   ```sh
   kubectl -n YOUR_NAMESPACE get cluster YOUR_RELEASE
   kubectl -n YOUR_NAMESPACE get objectstore YOUR_RELEASE
   kubectl -n YOUR_NAMESPACE get scheduledbackup YOUR_RELEASE
   kubectl -n YOUR_NAMESPACE get backups
   ```

2. Create a **separate** `ObjectStore` in the same namespace for recovery. Give
   it the same `destinationPath` and `endpointURL` as the chart's ObjectStore,
   but reference credentials that can list and read archive objects and cannot
   write or delete them. For example:

   ```yaml
   apiVersion: barmancloud.cnpg.io/v1
   kind: ObjectStore
   metadata:
     name: YOUR_RELEASE-recovery-readonly
     namespace: YOUR_NAMESPACE
   spec:
     configuration:
       destinationPath: s3://YOUR_BUCKET/YOUR_PATH
       endpointURL: https://YOUR_S3_ENDPOINT
       s3Credentials:
         accessKeyId:
           name: recovery-s3-creds
           key: ACCESS_KEY_ID
         secretAccessKey:
           name: recovery-s3-creds
           key: ACCESS_SECRET_KEY
   ```

   Check the object store's `destinationPath` and `endpointURL` before applying
   this example. Test the recovery identity's read access and rejected write
   access separately; cnpg-drill checks the paths but cannot prove what the
   credentials permit.

3. [Install cnpg-drill](https://github.com/danielgaskins/cnpg-drill/blob/v0.1.2/docs/FIRST-RUN.md)
   and save this as `drill.json`. Replace the namespace, release name, database,
   and table with values from your deployment:

   ```json
   {
     "namespace": "YOUR_NAMESPACE",
     "cluster": "YOUR_RELEASE",
     "recoveryObjectStore": "YOUR_RELEASE-recovery-readonly",
     "timeoutSeconds": 1800,
     "maxBackupAgeSeconds": 172800,
     "checks": [
       {"name": "postgres-ready", "query": "SELECT 1", "expected": "1"},
       {"name": "application-table", "database": "YOUR_DATABASE", "query": "SELECT to_regclass('public.YOUR_TABLE') IS NOT NULL", "expected": "t"}
     ]
   }
   ```

   Replace the table-existence check with an assertion on data your application
   needs if possible. Set `maxBackupAgeSeconds` to match the backup schedule and
   your recovery policy. `SELECT 1` only proves that the recovered server accepts
   a query.

4. Inspect the disposable Cluster manifest, then run the restore:

   ```sh
   cnpg-drill plan --config drill.json
   cnpg-drill run --config drill.json --report drill-result.json
   ```

   The tool selects the latest completed Barman plugin Backup, restores it into
   a single-instance Cluster, runs read-only SQL, writes a JSON result, and
   deletes the drill Cluster and PVCs. It exits nonzero for a failed recovery,
   assertion, or cleanup. Make room for one extra PostgreSQL data volume and
   check cloud volume deletion after the first run. The report hashes SQL output
   rather than recording query results.

For a point-in-time check, add an RFC3339 `targetTime` within the retained WAL
window to the JSON and run a separate drill. A latest-backup pass does not prove
that every point in the recovery window works. cnpg-drill currently refuses
source Clusters bootstrapped from recovery or using tablespaces.
