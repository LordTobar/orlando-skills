# orlando-skills

Mis skills y utilidades para agentes de código (Claude Code, Cursor, Codex...).

## Instalar todo

Windows (PowerShell):
```
irm https://raw.githubusercontent.com/LordTobar/orlando-skills/main/install.ps1 | iex
```
Linux/mac (requiere `jq`):
```
curl -fsSL https://raw.githubusercontent.com/LordTobar/orlando-skills/main/install.sh | bash
```

## Skills de terceros incluidas

| Skill | Autor | Comando |
|---|---|---|
| spec, spec-impl | Klerith | `npx skills@latest add Klerith/fernando-skills` |
| caveman | juliusbrussee | `npx skills@latest add juliusbrussee/caveman` |
| find-skills | vercel-labs | `npx skills@latest add vercel-labs/skills --skill find-skills` |
| frontend-design | anthropics | `npx skills@latest add anthropics/skills --skill frontend-design` |

La lista maestra está en [`skills.json`](skills.json).

## Skills propias

Van en `skills/<nombre>/SKILL.md`. Cuando haya al menos una:
```
npx skills@latest add LordTobar/orlando-skills
```

## Agregar una skill

1. Tercero: añadir entrada a `skills.json` y a la tabla.
2. Propia: crear `skills/<nombre>/SKILL.md` con frontmatter `name` y `description`.
