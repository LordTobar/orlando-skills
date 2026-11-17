# Wiki de orlando-skills

Guía para entender el repo y para que otros armen el suyo.

| Página | Para qué |
|---|---|
| [1. Cómo funciona `npx skills add`](01-como-funciona-npx-skills.md) | Qué pasa por dentro al ejecutar el comando |
| [2. Los scripts, uno por uno](02-scripts.md) | `install.ps1`, `install.sh`, `skills.json`, `.gitattributes` |
| [3. Anatomía de una skill](03-anatomia-de-una-skill.md) | `SKILL.md`, frontmatter, archivos de apoyo |
| [4. Crea tu propio repo](04-crea-tu-propio-repo.md) | Tutorial paso a paso para clonar esta idea |
| [5. Problemas comunes](05-problemas-comunes.md) | Choques de nombres, CRLF, `jq`, etc. |

## Resumen en 30 segundos

- El repo es solo **archivos**: no hay build ni tests.
- Una **skill** = carpeta con un `SKILL.md`. El CLI `skills` (de vercel-labs) la copia a las carpetas de cada agente (Claude Code, Cursor, Codex...).
- `npx skills@latest add LordTobar/orlando-skills` = "baja este repo de GitHub, busca carpetas con `SKILL.md`, instálalas".
- `skills.json` + `install.ps1`/`install.sh` = un instalador propio que repite ese comando para **varias fuentes** (mías y de terceros) de una vez.

## Mapa del repo

```
orlando-skills/
├── skills/                  # skills propias (las descubre el CLI)
│   ├── spec/SKILL.md (+ template.md)
│   ├── spec-impl/SKILL.md
│   └── NOTICE.md            # atribución/licencia de los clones (MIT)
├── skills.json              # manifiesto: {source, skills[]}
├── install.ps1              # instalador Windows
├── install.sh               # instalador Linux/mac (requiere jq)
├── .gitattributes           # fuerza LF en *.sh y *.json
├── docs/
│   ├── mcp-y-recursos.md    # MCP, plugins, enlaces
│   └── wiki/                # esta wiki
├── CLAUDE.md                # guía para Claude Code en este repo
└── README.md
```
