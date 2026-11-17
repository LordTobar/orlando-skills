# 4. Crea tu propio repo de skills

Receta para replicar este proyecto con tu nombre. Reemplaza `TU-USUARIO` y `mi-repo`.

## Requisitos

- Node.js (para `npx`), git, cuenta GitHub.
- Para `install.sh`: `jq`.

## Paso 1 — Crear el repo

```bash
mkdir mi-repo && cd mi-repo
git init -b main
```
Créalo en GitHub como **público** (el CLI lo clona sin credenciales) y conéctalo:
```bash
git remote add origin https://github.com/TU-USUARIO/mi-repo.git
```

## Paso 2 — Tu primera skill

```bash
mkdir -p skills/hola
```
`skills/hola/SKILL.md`:
```markdown
---
name: hola
description: Saluda al usuario. Úsala cuando pida un saludo.
---

# Hola

Responde con un saludo corto y amistoso.
```
(Atajo: `npx skills init hola` genera una plantilla.)

## Paso 3 — Publicar = push

```bash
git add . && git commit -m "Primera skill" && git push -u origin main
```

## Paso 4 — Verificar

```bash
npx -y skills@latest add TU-USUARIO/mi-repo --list     # debe aparecer "hola"
npx skills@latest add TU-USUARIO/mi-repo --skill hola   # instalar
```
Cualquiera puede ya instalar la tuya con ese mismo comando.

## Paso 5 (opcional) — Instalador de todo tu set

Para instalar tus skills **y** las de terceros de una vez:

1. Crea `skills.json`:
   ```json
   [
     { "source": "TU-USUARIO/mi-repo", "skills": ["hola"] },
     { "source": "vercel-labs/skills", "skills": ["find-skills"] }
   ]
   ```
2. Copia `install.ps1` / `install.sh` de este repo y **cambia la `URL`/`$url`** a `https://raw.githubusercontent.com/TU-USUARIO/mi-repo/main/skills.json`.
3. Copia `.gitattributes` (LF en `*.sh` y `*.json`).
4. Push. One-liners:
   ```powershell
   irm https://raw.githubusercontent.com/TU-USUARIO/mi-repo/main/install.ps1 | iex
   ```
   ```bash
   curl -fsSL https://raw.githubusercontent.com/TU-USUARIO/mi-repo/main/install.sh | bash
   ```

## Paso 6 — Documentar

- README con tabla de skills propias y de terceros.
- Si clonas una skill ajena: respeta su licencia, añade `NOTICE.md` y avisa en el README.

## Fork vs. referenciar

| Quiero... | Haz |
|---|---|
| Usar una skill ajena tal cual | Solo ponla en `skills.json` (referencia) |
| Modificarla | Cópiala a `skills/<nombre>/`, mantén licencia/NOTICE, y considera renombrarla |
| Evitar choque de nombres | `--rename <nuevo>` al instalar, o cambia `name` en el frontmatter |

## Checklist final

- [ ] Repo público, rama `main`
- [ ] Cada skill: `skills/<x>/SKILL.md` con `name` y `description`
- [ ] `--list` muestra todas tus skills
- [ ] `skills.json` + scripts apuntan a TU repo (no al de LordTobar)
- [ ] `.gitattributes` con LF
- [ ] Sin secretos, con LICENSE y NOTICE si aplica
