{{- define "base-cluster.rbac.preexistingRoles" -}}
  {{- $preexistingRoles := list -}}
  {{- range $role := (lookup "rbac.authorization.k8s.io/v1" "ClusterRole" "" "").items -}}
    {{/* Only allow the default k8s ClusterRoles */}}
    {{- if eq (dig "metadata" "labels" "kubernetes.io/bootstrapping" "" $role) "rbac-defaults" -}}
      {{- $preexistingRoles = append $preexistingRoles $role.metadata.name -}}
    {{- end -}}
  {{- end -}}
  {{- toYaml $preexistingRoles -}}
{{- end -}}

{{- define "base-cluster.rbac.mergeSubjects" -}}
  {{- $subjects := dict -}}
  {{- range $accountName, $account := .accounts -}}
    {{- $subjects = set $subjects $accountName (dict "label" "account" "spec" $account "subject" (dict "kind" "User" "name" $accountName)) -}}
  {{- end -}}
  {{- range $groupName, $group := .groups -}}
    {{- if hasKey $subjects $groupName -}}
      {{- fail (printf "'%s' is used as both an account and a group" $groupName) -}}
    {{- end -}}
    {{- $subjects = set $subjects $groupName (dict "label" "group" "spec" $group "subject" (dict "kind" "Group" "name" $groupName)) -}}
  {{- end -}}
  {{- /* Legacy: ServiceAccounts with static tokens, keyed with a prefix as they can't collide with OIDC names */ -}}
  {{- range $serviceAccountName, $serviceAccount := .serviceAccounts -}}
    {{- $key := printf "serviceAccount/%s" $serviceAccountName -}}
    {{- $subjects = set $subjects $key (dict "label" "legacy serviceAccount" "spec" $serviceAccount "subject" (dict "kind" "ServiceAccount" "namespace" $.namespace "name" (printf "%s-%s" $.serviceAccountPrefix $serviceAccountName))) -}}
  {{- end -}}
  {{- toYaml $subjects -}}
{{- end -}}

{{- define "base-cluster.rbac.roles" -}}
  {{- $roles := dict -}}
  {{- $definedRoles := .roles -}}
  {{- $preexistingRoles := include "base-cluster.rbac.preexistingRoles" (dict) | fromYamlArray -}}
  {{- $definedNamespaces := .namespaces -}}
  {{- $subjects := include "base-cluster.rbac.mergeSubjects" (dict "accounts" .accounts "groups" .groups "serviceAccounts" .serviceAccounts "namespace" .namespace "serviceAccountPrefix" .serviceAccountPrefix) | fromYaml -}}
  {{- range $subjectKey, $subject := $subjects -}}
    {{- $subjectName := $subjectKey | trimPrefix "serviceAccount/" -}}
    {{- $label := $subject.label -}}
    {{- $spec := $subject.spec -}}
    {{- range $roleName, $namespaces := dig "roles" (dict) $spec -}}
      {{- if and (not (has $roleName $definedRoles)) (not (has $roleName $preexistingRoles)) -}}
        {{- fail (printf "Role '%s' doesn't exist, used in %s '%s'" $roleName $label $subjectName) -}}
      {{- end -}}

      {{- $existingRole := dig $roleName (dict) $roles -}}
      {{- $namespaceMapping := dig "namespaceMapping" (dict) $existingRole -}}
      {{- range $roleNamespace := $namespaces -}}
        {{- if not (has $roleNamespace $definedNamespaces) -}}
          {{- fail (printf "Role '%s' wants to be in the undefined namespace '%s'" $roleName $roleNamespace) -}}
        {{- end -}}

        {{- $existingNamespace := dig $roleNamespace (list) $namespaceMapping -}}
        {{- $existingNamespace = append $existingNamespace $subject.subject -}}
        {{- $namespaceMapping = set $namespaceMapping $roleNamespace $existingNamespace -}}
      {{- end -}}
      {{- $existingRole = set $existingRole "namespaceMapping" $namespaceMapping -}}
      {{- $roles = set $roles $roleName $existingRole -}}
    {{- end -}}
    {{- range $roleName := dig "clusterRoles" (list) $spec -}}
        {{- if and (not (has $roleName $definedRoles)) (not (has $roleName $preexistingRoles)) -}}
          {{- fail (printf "Role '%s' doesn't exist, used in %s '%s'" $roleName $label $subjectName ) -}}
        {{- end -}}

      {{- $existingRole := dig $roleName (dict) $roles -}}
      {{- $clusterMapping := dig "clusterMapping" (list) $existingRole -}}
      {{- $clusterMapping = append $clusterMapping $subject.subject -}}
      {{- $existingRole = set $existingRole "clusterMapping" $clusterMapping -}}
      {{- $roles = set $roles $roleName $existingRole -}}
    {{- end -}}
  {{- end -}}
  {{- toYaml $roles -}}
{{- end -}}
