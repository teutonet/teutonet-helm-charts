{{/*
Return a resource request/limit object based on a given preset or provided resources.
{{ include "common.resources" (dict "resources" (dict) "resourcesPreset" "small") -}}
*/}}
{{- define "common.resources" -}}
  {{- $resources := dict -}}
  {{- if .resources -}}
    {{- $resources = .resources | mustMerge $resources -}}
  {{- end -}}
  {{- if and .resourcesPreset (ne .resourcesPreset "none") -}}
    {{- $resources = include "common.resources.preset" (dict "type" .resourcesPreset) | fromYaml | mustMerge $resources -}}
  {{- end -}}
  {{- toYaml $resources -}}
{{- end -}}

{{/*
Return a (dict resources resourcesPreset) for passing through to capable charts, e.g. bitnami
{{ include "common.resourcesWithPreset" (dict "resources" (dict) "resourcesPreset" "small") -}}
*/}}
{{- define "common.resourcesWithPreset" -}}
  {{- pick . "resources" "resourcesPreset" | toYaml -}}
{{- end -}}

{{- define "common.convert" -}}
  {{- $input := .value | toString | trim -}}
  {{- $toUnit := .to  -}}

  {{- /* Extract numeric part */ -}}
  {{- $number := regexFind "[0-9.]+" $input | float64 -}}

  {{- /* Extract unit part */ -}}
  {{- $fromUnit := regexFind "[a-zA-Z]+" $input  -}}

  {{- /* Define multipliers (binary base 1024) */ -}}
  {{- $units := dict
    ""  1
    "k" 1e3
    "M" 1e6
    "G" 1e9
    "T" 1e12
    "P" 1e15
    "E" 1e18
    "Ki" 1024
    "Mi" (mul 1024 1024)
    "Gi" (mul 1024 (mul 1024 1024))
    "Ti" (mul 1024 (mul 1024 (mul 1024 1024)))
    "Pi" (mul 1024 (mul 1024 (mul 1024 (mul 1024 1024))))
    "Ei" (mul 1024 (mul 1024 (mul 1024 (mul 1024 (mul 1024 1024)))))
  -}}

  {{- $fromFactor := index $units $fromUnit -}}
  {{- $toFactor := index $units $toUnit -}}

  {{- if not $fromFactor -}}
  {{- fail (printf "Unknown source unit: %s" $fromUnit) -}}
  {{- end -}}

  {{- if not $toFactor -}}
  {{- fail (printf "Unknown target unit: %s" $toUnit) -}}
  {{- end -}}

  {{- $bytes := mul $number $fromFactor -}}
  {{- $result := divf $bytes $toFactor -}}

  {{- printf "%f%s" $result $toUnit -}}
{{- end -}}
