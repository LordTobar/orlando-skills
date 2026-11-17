# 5. Problemas comunes

| Síntoma | Causa | Solución |
|---|---|---|
| `--list` no muestra mi skill nueva | El CLI lee GitHub, no tu disco | `git push` primero |
| Skill no detectada | Falta `SKILL.md` o frontmatter inválido | Revisar `name`/`description`, YAML válido (comillas si hay `:`) |
| `install.sh`: `bad interpreter ... ^M` | Archivo con CRLF | `.gitattributes` con `*.sh text eol=lf`; re-checkout o `dos2unix install.sh` |
| `install.sh`: `jq: command not found` | Falta `jq` | `apt install jq` / `brew install jq` |
| `npx: command not found` | Falta Node.js | Instalar Node |
| `spec` choca con la de Klerith | Mismo `name` | No instalar ambas, o `--rename` |
| Windows: `irm ... \| iex` bloqueado | Política de ejecución | `Set-ExecutionPolicy -Scope CurrentUser RemoteSigned` |
| La skill no aparece en el agente | Agente no seleccionado o sesión abierta | Reiniciar el agente; reinstalar con `-a <agente>` |
| Cambié la skill y no se actualiza | Instalada una copia vieja | `npx skills@latest update` o reinstalar con `--force`/`add` |

## Comandos de diagnóstico

```
npx skills@latest list                      # qué está instalado
npx skills@latest update -g                 # actualizar globales
npx skills@latest remove <nombre>           # desinstalar
ls ~/.agents/skills                         # copias canónicas
cat ~/.agents/.skill-lock.json              # registro (fuente, hash, fechas)
```

## Ojo

- `install.ps1`/`install.sh` modifican tu instalación global. Pruébalos en una cuenta/VM si dudas.
- `curl | bash` / `irm | iex` ejecutan lo que haya en `main`: revisa el script antes de recomendarlo o usarlo, y protege tu rama `main`.
