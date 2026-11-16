# MCP, plugins y recursos

## MCP que uso

| MCP | Tipo | Instalación |
|---|---|---|
| playwright | stdio (local) | `claude mcp add playwright --scope user -- npx @playwright/mcp@latest` |
| Claude Data, Claude Docs, Meetings, Gmail | Conectores claude.ai (remotos) | Se activan en claude.ai → Settings → Connectors. Claude Code los sincroniza solo con la misma cuenta. |
| Claude in Chrome | Extensión de Chrome | Instalar la extensión "Claude in Chrome" desde la Chrome Web Store e iniciar sesión. |

Notas:
- `playwright` está hoy registrado solo en el proyecto `arcade-vault`; con `--scope user` queda global. Quitar `--scope user` para dejarlo por proyecto.
- Ver estado: `claude mcp list`. Quitar: `claude mcp remove <nombre>`.

## Plugins de Claude Code

| Plugin | Instalación |
|---|---|
| caveman | `/plugin install caveman@anthropic-plugin-directory` |
| warp | `/plugin marketplace add warpdotdev/claude-code-warp` y luego `/plugin install warp@claude-code-warp` |

Marketplace oficial (ya viene configurado): `anthropics/claude-plugins-official`.

## Páginas importantes

| Recurso | URL |
|---|---|
| skills.sh (directorio de skills) | https://skills.sh |
| CLI `skills` (vercel-labs) | https://github.com/vercel-labs/skills |
| Crear skills (formato y descubrimiento) | https://github.com/vercel-labs/skills/blob/main/docs/creating-skills.md |
| Referencia de comandos del CLI | https://github.com/vercel-labs/skills/blob/main/docs/commands.md |
| Agentes soportados por el CLI | https://github.com/vercel-labs/skills/blob/main/docs/agents.md |
| Skills oficiales de Anthropic | https://github.com/anthropics/skills |
| Plugins oficiales de Claude Code | https://github.com/anthropics/claude-plugins-official |
| Skills de Klerith (original de spec) | https://github.com/Klerith/fernando-skills |
| Caveman | https://github.com/juliusbrussee/caveman |
| Playwright MCP | https://github.com/microsoft/playwright-mcp |
| Docs de Claude Code (MCP, skills, plugins) | https://docs.claude.com/en/docs/claude-code |
| Registro de servidores MCP | https://github.com/modelcontextprotocol/servers |
