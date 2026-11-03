# Preset de iTerm2 — Solarized Osaka (dark)

`solarized-osaka-dark.itermcolors` iguala los colores de iTerm2 a los del
colorscheme de Neovim.

## Importar

iTerm2 → Settings → Profiles → Colors → Color Presets… → Import…
y elegir el archivo. Después, en el mismo menú, seleccionar
**solarized-osaka-dark**.

Importar un preset solo cambia colores: la transparencia, el blur y la imagen
de fondo viven en Profiles → Window y no se tocan.

## Regenerar

```sh
nvim --headless "+luafile iterm/generate.lua" +qa
```

Escribe `<colors_name>-<background>.itermcolors` en esta carpeta, así que sirve
igual si se cambia de tema. **No editar el `.itermcolors` a mano**: se
regenera.

## De dónde salen los colores

Los 16 ANSI salen de `vim.g.terminal_color_*`, que es exactamente lo que usa el
`:terminal` de Neovim. Eso no es casualidad: es para que un mismo programa
(lazygit, `ls`, un diff) se vea igual dentro y fuera del editor. El
colorscheme define esos valores (`terminal_colors = true`) y
`lua/custom/plugins/toggleterm.lua` les aplica las reparaciones de abajo.

Los colores de UI salen de los highlight groups reales, no de la paleta a ojo:

| iTerm2               | Origen                          |
| -------------------- | ------------------------------- |
| Background           | `Normal` bg (o ANSI 0 si es transparente) |
| Foreground           | `Normal` fg                     |
| Cursor / Cursor Text | `Cursor` bg / fg                |
| Selection            | `Visual` bg                     |
| Cursor Guide         | `CursorLine` bg, al 25%         |
| Bold                 | ANSI 15                         |
| Link                 | ANSI 4                          |

## Por qué no se usa el generador del tema

El tema trae `lua/solarized-osaka/extra/iterm.lua`, pero está deshabilitado
upstream (`-- BUG: not working`) y produce un preset inservible:

1. **Crashea**: la plantilla pide las claves `teal` y `black`, que la paleta no
   define (`attempt to index local 'hex' (a nil value)`).
2. Los brillantes 9-14 salen idénticos a los normales 1-6.
3. `ANSI 8` queda exactamente igual al fondo, así que el texto en bright-black
   —que es casi todo lo "tenue"— es invisible.
4. `ANSI 15` sale más oscuro que `ANSI 7`.

Los puntos 2 y 3 vienen del propio `theme.lua`, que asigna el mismo color al
normal y al brillante y usa `base04` (el fondo) para el 0 y el 8. Eso lo repara
`fix_terminal_colors()` en `lua/custom/plugins/toggleterm.lua`: el 8 pasa a usar
el color de `Comment` y los brillantes 9-15 se aclaran un 18% hacia blanco.
Como el preset se genera desde los mismos `terminal_color_*`, hereda las
reparaciones.

El `ANSI 0` sí se queda igual al fondo, a propósito: se usa casi siempre como
color de fondo y no de texto, y que coincidan es lo normal.
