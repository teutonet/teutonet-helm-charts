{{- define "base-cluster.rbac.roles" -}}
{{- $roles := dict -}}
{{- $definedRoles := .roles -}}
{{- range $accountName, $account := .accounts -}}
  {{- range $roleName, $namespaces := dig "roles" (dict) $account -}}
    {{- if not (has $roleName $definedRoles) -}}
      {{- fail (printf "Role '%s' doesn't exist, used in account '%s'" $roleName $accountName ) -}}
    {{- end -}}

    {{- $existingRole := dig $roleName (dict) $roles -}}
    {{- $namespaceMapping := dig "namespaceMapping" (dict) $existingRole -}}
    {{- range $roleNamespace := $namespaces -}}
      {{- $existingNamespace := dig $roleNamespace (list) $namespaceMapping -}}
      {{- $existingNamespace = append $existingNamespace $accountName -}}
      {{- $namespaceMapping = set $namespaceMapping $roleNamespace $existingNamespace -}}
    {{- end -}}
    {{- $existingRole = set $existingRole "namespaceMapping" $namespaceMapping -}}
    {{- $roles = set $roles $roleName $existingRole -}}
  {{- end -}}
  {{- range $roleName := dig "clusterRoles" (list) $account -}}
      {{- if not (has $roleName $definedRoles) -}}
        {{- fail (printf "Role '%s' doesn't exist, used in account '%s'" $roleName $accountName ) -}}
      {{- end -}}

    {{- $existingRole := dig $roleName (dict) $roles -}}
    {{- $clusterMapping := dig "clusterMapping" (list) $existingRole -}}
    {{- $clusterMapping = append $clusterMapping $accountName -}}
    {{- $existingRole = set $existingRole "clusterMapping" $clusterMapping -}}
    {{- $roles = set $roles $roleName $existingRole -}}
  {{- end -}}
{{- end -}}
{{- $roles | toYaml -}}
{{- end -}}