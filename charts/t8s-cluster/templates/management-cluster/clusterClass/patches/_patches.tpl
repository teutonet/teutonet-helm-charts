{{- define "t8s-cluster.patches.patchFile" -}}
  {{- $patchType := "" -}}
  {{- with .patchType -}}
    {{- $patchType = printf "+%v" . -}}
  {{- end -}}
  {{- $component := "" -}}
  {{- with .component -}}
    {{- $component = printf "-%v" . -}}
  {{- end -}}
  {{- $suffix := .suffix -}}
  {{- if typeIs "<nil>" $suffix -}}
    {{- $suffix = 10 -}}
  {{- end -}}
  {{- $extension := "yaml" -}}
  {{- if eq .patchType "json" -}}
    {{- $extension = "json" -}}
  {{- end -}}
  {{- with .extension -}}
    {{- $extension = . -}}
  {{- end -}}
  {{- $content := "" -}}
  {{- if eq $extension "json" -}}
    {{- $content = toJson .values -}}
  {{- else -}}
    {{- $content = toYaml .values -}}
  {{- end -}}
  {{- dict "content" $content "path" (printf "%v/%v-%v%v%v.%v" (include "t8s-cluster.patches.directory" (dict)) .target $suffix $component $patchType $extension) | toYaml -}}
{{- end -}}

{{- define "t8s-cluster.patches.directory" -}}
/etc/kubernetes/patches
{{- end -}}
