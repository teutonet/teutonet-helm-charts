{{- define "base-cluster.backup.getProviderName" -}}
  {{- $providers := list "minio" -}}
  {{- $providerName := . | keys | first -}}
  {{- if has $providerName $providers -}}
    {{- $providerName -}}
  {{- else -}}
    {{- fail (printf "Provider '%s' not implemented" $providerName) -}}
  {{- end -}}
{{- end -}}

{{- define "base-cluster.backup.mapProviderName" -}}
  {{- $providerMap := dict "minio" "aws" -}}
  {{- get $providerMap . | required "Missing provider mapping" -}}
{{- end -}}

{{- define "base-cluster.backup.credential" -}}
  {{- $providerName := include "base-cluster.backup.getProviderName" . }}
  {{- $pluginName := include "base-cluster.backup.mapProviderName" $providerName -}}
  {{- $provider := get . $providerName }}
  {{- if eq $pluginName "aws" -}}
    {{- if hasKey $provider "accessKeyID" -}}
[default]
aw_access_key_id={{ get $provider "accessKeyID" }}
aw_access_key_id={{ get $provider "secretAccessKey" }}
    {{- end -}}
  {{- else -}}
    {{- fail (printf "Credentials for plugin '%s' not implemented" $pluginName) -}}
  {{- end -}}
{{- end -}}

{{- define "base-cluster.backup.credentialType" -}}
  {{- $providerName := include "base-cluster.backup.getProviderName" . }}
  {{- $pluginName := include "base-cluster.backup.mapProviderName" $providerName -}}
  {{- $provider := get . $providerName -}}
  {{- if hasKey $provider "existingSecret" -}}
existingSecret
  {{- else -}}
    {{- if eq $pluginName "aws" -}}
      {{- if hasKey $provider "accessKeyID" -}}
direct
      {{- end -}}
    {{- else -}}
      {{- fail (printf "Credentials for plugin '%s' not implemented" $pluginName) -}}
    {{- end -}}
  {{- end -}}
{{- end -}}
