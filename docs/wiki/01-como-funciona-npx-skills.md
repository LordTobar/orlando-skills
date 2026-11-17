# 1. Cómo funciona `npx skills@latest add LordTobar/orlando-skills`

## Desarmando el comando

```
npx  skills@latest  add  LordTobar/orlando-skills
 │        │          │            │
 │        │          │            └─ fuente: repo GitHub  <owner>/<repo>
 │        │          └─ subcomando: agregar skills
 │        └─ paquete npm "skills" (CLI de vercel-labs), última versión
 └─ ejecuta un paquete npm sin instalarlo globalmente
```

- **`npx`**: viene con Node.js. Descarga el paquete `skills` a caché temporal y lo corre. Por eso **necesitas Node**.
- **`@latest`**: fuerza la última versión del CLI (evita una caché vieja).
- **`LordTobar/orlando-skills`**: atajo de GitHub (`owner/repo`). También acepta URL completa (`https://github.com/...`), otras fuentes (p. ej. `notion`) y rutas locales.

> El nombre `npm skills` no existe como tal: el comando correcto es `npx skills@latest ...`. El CLI es https://github.com/vercel-labs/skills

## Qué hace el CLI, paso a paso

1. **Resuelve la fuente**: `LordTobar/orlando-skills` → `https://github.com/LordTobar/orlando-skills.git`. Lee la rama por defecto (`main`).
2. **Clona/descarga** el repo a un directorio temporal.
3. **Descubre skills**: busca carpetas que contengan un archivo `SKILL.md`. En este repo: `skills/spec/` y `skills/spec-impl/`. Nada más hace falta: sin config, sin registro.
4. **Pregunta (o usa flags)**:
   - qué skills instalar (`--skill spec`, `--skill '*'`),
   - para qué agentes (`--agent claude-code`, `'*'`),
   - alcance: proyecto (carpeta actual) o global (`-g`, a nivel de usuario).
5. **Instala**: deja una copia canónica en `~/.agents/skills/<nombre>/` (global) y crea **symlinks** hacia la carpeta de cada agente (p. ej. `~/.claude/skills/`). Con `--copy` copia en vez de enlazar.
6. **Registra** en `~/.agents/.skill-lock.json`: fuente, ruta, hash de la carpeta, fechas. Sirve para `skills list`, `skills update`, `skills remove`.

## Flags útiles

| Flag | Efecto |
|---|---|
| `-l, --list` | Solo lista las skills que detecta, sin instalar. Ideal para probar tu repo |
| `-s, --skill <n>` | Instala solo esa(s) skill(s) |
| `-g, --global` | A nivel usuario en vez de proyecto |
| `-a, --agent <a>` | Agentes destino (`'*'` = todos) |
| `-y, --yes` | Sin preguntas (para scripts) |
| `--copy` | Copia archivos en vez de symlink |
| `--rename <nombre>` | Instala la skill con otro nombre (útil si choca con otra) |
| `--all` | Todo: `--skill '*' --agent '*' -y` |
| `--full-depth` | Busca en todas las subcarpetas aunque haya un `SKILL.md` en la raíz |

Otros subcomandos: `list`, `find`, `update`, `remove`, `init [nombre]` (crea un `SKILL.md` base). Referencia completa: https://github.com/vercel-labs/skills/blob/main/docs/commands.md

## Implicaciones para quien quiera hacer el suyo

- **No hay "publicar"**: tu repo público en GitHub *es* el paquete. Hacer `git push` = publicar.
- **Lo que instala el CLI es lo que está en `main`**, no tu carpeta local. Para probar cambios hay que hacer push antes (o usar una ruta local).
- El nombre de la skill lo da el campo `name` del frontmatter de `SKILL.md`; es el que usas en `--skill`.
- Skills de **terceros** no se copian a tu repo: se referencian por su `source` (ver [skills.json](02-scripts.md#skillsjson)).

## Ver qué detecta el CLI en este repo

```
npx -y skills@latest add LordTobar/orlando-skills --list
```

Instalar solo una:

```
npx skills@latest add LordTobar/orlando-skills --skill spec
```

Ver qué quedó instalado:

```
npx skills@latest list
```
