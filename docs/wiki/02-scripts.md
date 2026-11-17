# 2. Los scripts, uno por uno

Hay dos mecanismos independientes (ver [README de la wiki](README.md)):

1. Skills propias en `skills/` → las instala el CLI directo desde GitHub.
2. `skills.json` + `install.ps1`/`install.sh` → instalan **todo mi set** (propias + terceros) con un solo comando.

## skills.json

El manifiesto. Lista de objetos `{ source, skills[] }`:

```json
[
  { "source": "LordTobar/orlando-skills", "skills": ["spec", "spec-impl"] },
  { "source": "juliusbrussee/caveman",    "skills": ["caveman"] },
  { "source": "vercel-labs/skills",       "skills": ["find-skills"] },
  { "source": "anthropics/skills",        "skills": ["frontend-design"] }
]
```

- `source`: repo GitHub de donde sale la skill (el mismo valor que irá a `npx skills add`).
- `skills`: nombres (frontmatter `name`) a instalar de ese repo.
- Mezcla skills mías y de terceros. Las de terceros **no se copian** al repo, solo se listan.

## install.ps1 (Windows / PowerShell)

```powershell
$ErrorActionPreference = "Stop"                       # (1) abortar ante cualquier error
$url = "https://raw.githubusercontent.com/LordTobar/orlando-skills/main/skills.json"
$list = if (Test-Path "$PSScriptRoot\skills.json") {  # (2) ¿hay skills.json al lado del script?
  Get-Content "$PSScriptRoot\skills.json" -Raw | ConvertFrom-Json   #     sí: léelo
} else { Invoke-RestMethod $url }                     #     no: descárgalo de GitHub
foreach ($e in $list) {                               # (3) por cada entrada...
  foreach ($s in $e.skills) {                         #     ...y cada skill
    Write-Host ">> $($e.source) :: $s"
    npx skills@latest add $e.source --skill $s -g -y  # (4) instalar global y sin preguntas
  }
}
```

1. **Stop on error**: si un `npx` falla, el script se detiene.
2. **Modo local vs. one-liner**: con el repo clonado usa el `skills.json` local (`$PSScriptRoot` = carpeta del script). Con `irm ... | iex` no hay archivo en disco (`$PSScriptRoot` vacío) → baja el manifiesto de `raw.githubusercontent.com`.
3. **Doble bucle**: una llamada de `npx` por skill.
4. **`-g -y`**: global (`~/.agents/skills`) y sin prompts.

Uso:
```powershell
irm https://raw.githubusercontent.com/LordTobar/orlando-skills/main/install.ps1 | iex   # one-liner
.\install.ps1                                                                            # desde el clon
```

## install.sh (Linux / macOS)

```bash
#!/usr/bin/env bash
set -e                                                    # (1) abortar ante error
URL="https://raw.githubusercontent.com/LordTobar/orlando-skills/main/skills.json"
DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" 2>/dev/null && pwd || true)"   # (2) carpeta del script
if [ -f "$DIR/skills.json" ]; then JSON=$(cat "$DIR/skills.json"); else JSON=$(curl -fsSL "$URL"); fi  # (3)
echo "$JSON" | jq -r '.[] | .source as $s | .skills[] | "\($s) \(.)"' | while read -r src skill; do   # (4)
  echo ">> $src :: $skill"
  npx skills@latest add "$src" --skill "$skill" -g -y     # (5)
done
```

1. `set -e`: igual que `Stop` en PowerShell.
2. `${BASH_SOURCE[0]:-$0}`: cuando se ejecuta como `curl ... | bash`, no hay archivo; el `|| true` evita que falle y `DIR` queda vacío.
3. Local si existe, si no `curl -fsSL` (falla en HTTP error, silencioso, sigue redirects).
4. **`jq`** aplana el JSON a líneas `"<source> <skill>"` (una por skill). Por eso `install.sh` **requiere `jq`**; el `.ps1` no, porque PowerShell parsea JSON nativo.
5. Misma instalación global y silenciosa.

Uso:
```bash
curl -fsSL https://raw.githubusercontent.com/LordTobar/orlando-skills/main/install.sh | bash
./install.sh
```

> Ambos scripts escriben en `~/.agents/skills` y `~/.agents/.skill-lock.json`. Son idempotentes en la práctica (reinstalan), pero evita correrlos sin necesidad.

## .gitattributes

```
*.sh   text eol=lf
*.json text eol=lf
```

Windows convierte a CRLF al hacer checkout. Un `install.sh` con CRLF falla en Linux (`bad interpreter: /usr/bin/env bash^M`). Esta regla fuerza LF en esos tipos. Al editar en Windows, configura tu editor para no reintroducir CRLF.

## Otros archivos

| Archivo | Rol |
|---|---|
| `skills/NOTICE.md` | Atribución a Klerith/fernando-skills (licencia MIT) por los clones de `spec`/`spec-impl` |
| `LICENSE` | Licencia del repo |
| `.gitignore` | Exclusiones de git |
| `CLAUDE.md` | Instrucciones para Claude Code al trabajar en este repo |
| `docs/mcp-y-recursos.md` | Lista de MCP, plugins y enlaces útiles |
