# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Qué es

Repo de distribución de skills para agentes (`npx skills`, CLI de vercel-labs/skills). No hay build, lint ni tests. Publicado en https://github.com/LordTobar/orlando-skills (público, rama `main`).

## Arquitectura

Dos mecanismos independientes:

1. **Skills propias** en `skills/<nombre>/SKILL.md` (+ archivos de apoyo, p. ej. `skills/spec/template.md`). El CLI descubre cualquier carpeta con `SKILL.md`. Hoy: `spec` y `spec-impl`, clones de Klerith/fernando-skills (MIT, ver `skills/NOTICE.md`). Se instalan con `npx skills@latest add LordTobar/orlando-skills [--skill <nombre>]`.
2. **Manifiesto `skills.json`** + `install.ps1` / `install.sh`: lista `{source, skills[]}` y los scripts ejecutan `npx skills@latest add <source> --skill <x> -g -y` por cada una. Cubre tanto skills propias (`source: LordTobar/orlando-skills`) como de terceros (caveman, find-skills, frontend-design), que NO se copian al repo, solo se referencian.

Los scripts leen `skills.json` local si existe; si no, lo descargan de `raw.githubusercontent.com/.../main/skills.json` (modo one-liner `irm ... | iex` / `curl ... | bash`). `install.sh` requiere `jq`.

## Convenciones

- `docs/mcp-y-recursos.md` lista MCP, plugins y enlaces; actualizarlo al cambiar los MCP/plugins que uso (ver `claude mcp list` y `~/.claude/plugins/installed_plugins.json`).
- Al agregar una skill de terceros: entrada en `skills.json` + fila en la tabla del README. Al agregar una propia: carpeta en `skills/` + fila en la tabla "Skills propias" del README.
- Las skills `spec`/`spec-impl` tienen el mismo nombre que las de Klerith: no instalar ambas a la vez (chocan). Si se divergen mucho, considerar renombrarlas.
- `.gitattributes` fuerza LF en `*.sh` y `*.json` (CRLF rompe `install.sh` en Linux). Editar en Windows sin reintroducir CRLF.
- README y textos del repo en español; los SKILL.md clonados están en inglés (originales).
- Los commits llevan el trailer `Co-Authored-By` indicado por el sistema.

## Probar cambios

- Ver qué detecta el CLI: `npx -y skills@latest add LordTobar/orlando-skills --list` (lee desde GitHub: requiere push previo).
- `install.ps1` / `install.sh` instalan en `~/.agents/skills` (global) y actualizan `~/.agents/.skill-lock.json`; evitar ejecutarlos sin necesidad.
