# 3. Anatomía de una skill

Una skill es una carpeta con un `SKILL.md`. Puede tener archivos de apoyo.

```
skills/spec/
├── SKILL.md      # obligatorio: frontmatter + instrucciones
└── template.md   # opcional: la skill lo lee con "Read template.md"
```

## SKILL.md

Frontmatter YAML + cuerpo en Markdown. Ejemplo real (`skills/spec/SKILL.md`):

```markdown
---
name: spec
description: Designs and develops specs following the spec-driven method...
disable-model-invocation: true
argument-hint: 'short feature description or requirement'
allowed-tools: Read, Glob, Grep, Write, AskUserQuestion, Bash(ls:*), Bash(cat:*), Bash(date:*)
---

# /spec — Guided spec designer
...
```

| Campo | Qué hace |
|---|---|
| `name` | Identificador. Es lo que pasas a `--skill` y el nombre del comando `/spec` |
| `description` | Qué hace y cuándo usarla. El agente la lee para decidir si la activa |
| `disable-model-invocation` | `true` = solo se ejecuta cuando el usuario la invoca (`/spec`), el modelo no la dispara solo |
| `argument-hint` | Texto de ayuda del argumento al autocompletar |
| `allowed-tools` | Herramientas que la skill puede usar sin pedir permiso. `Bash(ls:*)` = solo `ls` |

`name` y `description` son lo mínimo. Los demás son extensiones de Claude Code; otros agentes pueden ignorarlos.

## Trucos usados en `spec` / `spec-impl`

- `!`comando`` en el cuerpo: Claude Code ejecuta el comando **antes** de enviar el prompt e inserta la salida. Ej.: `!`date +%F`` pone la fecha real; `!`ls specs/`` lista specs existentes.
- `$ARGUMENTS`: lo que el usuario escribe tras `/spec-impl`.
- Archivos de apoyo: se referencian por nombre relativo ("`template.md`, in the same directory as this skill").

## Las dos skills propias

| Skill | Flujo |
|---|---|
| `spec` | 4 fases: contexto → preguntas guiadas → escribir sección por sección → guardar en `specs/NN-nombre.md`. No escribe código |
| `spec-impl` | Valida que la spec esté "Aprobada", crea rama git con su nombre, implementa paso a paso con pausas para revisar diffs. Config opcional en `specs/.spec-config.yml` |

Son clones de https://github.com/Klerith/fernando-skills (MIT). Mantén `skills/NOTICE.md` si clonas.

## Buenas prácticas

- `description` clara con *cuándo* usarla: es el gatillo.
- Una skill, una responsabilidad.
- Instrucciones en el idioma que quieras; el cuerpo es solo texto para el modelo.
- Nada de secretos en el repo: es público.

Referencia oficial del formato: https://github.com/vercel-labs/skills/blob/main/docs/creating-skills.md
