# Preset de iTerm2 — Solarized Osaka (dark)

`solarized-osaka-dark.itermcolors` iguala los colores de iTerm2 al colorscheme
de Neovim (`craftzdog/solarized-osaka.nvim`, estilo dark).

## Importar

iTerm2 → Settings → Profiles → Colors → Color Presets… → Import…
y elegir el archivo. Después, en el mismo menú, seleccionar
**solarized-osaka-dark**.

Importar un preset solo cambia colores: la transparencia, el blur y la imagen
de fondo viven en Profiles → Window y no se tocan.

## De dónde salen los colores

Generado desde la paleta del propio tema. Los que importan para que peguen con
Neovim se toman de los highlights reales, no a ojo:

| iTerm2              | Origen                  |
| ------------------- | ----------------------- |
| Background          | `colors.bg`             |
| Foreground          | highlight `Normal` fg   |
| Cursor / Cursor Text| highlight `Cursor` bg/fg|
| Selection           | highlight `Visual` bg   |
| Cursor Guide        | highlight `CursorLine`  |
| ANSI 0-7            | acentos del tema        |
| ANSI 8              | highlight `Comment` fg  |
| ANSI 9-14           | tier `*400` (más claro) |
| ANSI 15             | `base1`                 |

El tema trae un generador de iTerm2 en `lua/solarized-osaka/extra/iterm.lua`,
pero está deshabilitado upstream (`-- BUG: not working`) y tiene tres problemas
que este preset corrige:

1. Crashea: la plantilla pide las claves `teal` y `black`, que la paleta no define.
2. Los brillantes 9-14 son idénticos a los normales 1-6.
3. `ANSI 8` es exactamente el color de fondo, así que el texto en bright-black
   queda invisible; y `ANSI 15` es más oscuro que `ANSI 7`.

## Regenerar

Si cambia la paleta del tema, volver a generar en vez de editar a mano. El
script vive fuera del repo; lo esencial es: sacar `require('solarized-osaka.colors')
.setup { transform = true }` más los highlights de la tabla de arriba, y escribir
el plist con esos valores.
