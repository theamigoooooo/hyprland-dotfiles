# Neovim Configuration

A modern, fast, and feature-rich Neovim configuration based on `lazy.nvim`.

## Key Features

- **Indentation Management:** Centralized in `options.lua` and `.editorconfig` for project-wide consistency.
- **Modern Formatting:** Powered by `conform.nvim` for fast, asynchronous formatting on save.
- **Robust Linting:** Diagnostics provided by `nvim-lint`.
- **Optimized LSP:** Pre-configured for many languages with a focus on performance (e.g., `ruff` and `basedpyright` for Python).
- **Tool Management:** Automatic installation of LSPs, formatters, and linters via `mason.nvim`.
- **Rich UI:** Includes `neotree`, `lualine`, `bufferline`, and `telescope`.

## Configuration Structure

- `init.lua`: Main entry point and plugin management.
- `lua/core/`: Global settings and keymaps.
    - `options.lua`: Vim options (indentation, UI, etc.).
    - `keymaps.lua`: Global keybindings.
- `lua/plugins/`: Individual plugin configurations.
    - `lsp.lua`: LSP server setup and Mason tool installation.
    - `autoformatting.lua`: `conform.nvim` setup.
    - `linting.lua`: `nvim-lint` setup.
    - `treesitter.lua`: Syntax highlighting and text objects.

## ⌨️ Keymaps

This configuration uses `<Space>` as the leader key.

### 🏠 General
| Keymap | Action |
| --- | --- |
| `<C-s>` | Save file |
| `<leader>sn` | Save without autoformat |
| `<C-q>` | Quit |
| `<C-_>` (or `<C-/>`) | Toggle comment (Normal/Visual) |
| `jk` / `kj` | Exit insert mode |
| `x` | Delete character without copying to register |
| `n` / `N` | Find next/prev and center screen |
| `<leader>lw` | Toggle line wrapping |
| `<leader>y` / `<leader>Y` | Yank to system clipboard |
| `<leader>j` | Replace word under cursor |
| `<leader>do` | Toggle diagnostics |
| `[d` / `]d` | Previous / Next diagnostic message |
| `<leader>d` | Open floating diagnostic message |
| `<leader>q` | Open diagnostics list |
| `<leader>ss` / `<leader>sl` | Save / Load session |

### 🪟 Navigation & Window Management
| Keymap | Action |
| --- | --- |
| `<C-h/j/k/l>` | Navigate between splits |
| `<leader>v` | Split window vertically |
| `<leader>h` | Split window horizontally |
| `<leader>se` | Make splits of equal size |
| `<leader>xs` | Close current window |
| `Arrow Keys` | Resize current window |
| `<Tab>` / `<S-Tab>` | Next / Previous buffer |
| `<leader>x` | Close current buffer |
| `<leader>b` | New empty buffer |
| `<leader>to` | Open new tab |
| `<leader>tx` | Close current tab |
| `<leader>tn` / `<leader>tp` | Go to next / previous tab |
| `<A-j>` / `<A-k>` | Move selected text up / down (Visual mode) |

### 🔍 Telescope (Fuzzy Finder)
| Keymap | Action |
| --- | --- |
| `<leader>sf` | Search files |
| `<leader>sg` | Search by grep (live grep) |
| `<leader>sw` | Search current word |
| `<leader>sb` | Search open buffers |
| `<leader>sh` | Search help tags |
| `<leader>?` | Search recently opened files |
| `<leader>/` | Fuzzy search in current buffer |
| `<leader>sd` | Search diagnostics |
| `<leader>gf` | Search git files |
| `<leader>gs` | Search git status (diff view) |
| `<leader>sds` | Search LSP document symbols |

### 🌳 File Explorers (Neo-tree & Oil)
| Keymap | Action |
| --- | --- |
| `<leader>e` | Toggle Left File Explorer (Neo-tree) |
| `<leader>w` | Toggle Floating File Explorer (Neo-tree) |
| `\` | Reveal current file in Neo-tree |
| `<leader>o` | Open Oil file explorer |
| `<leader>O` | Open Oil in current file's directory |

### 🛠️ LSP (Language Server Protocol)
*These are active when an LSP is attached to the buffer.*

| Keymap | Action |
| --- | --- |
| `gd` | Go to definition |
| `gr` | Go to references |
| `K` | Hover documentation |
| `<leader>rn` | Rename symbol |
| `<leader>ca` | Code action |
| `<leader>f` | Format buffer |
| `gD` | Go to declaration |
| `gI` | Go to implementation |
| `<leader>D` | Type definition |
| `<leader>th` | Toggle inlay hints |

### 🤖 AI Assistant (CodeCompanion)
| Keymap | Action |
| --- | --- |
| `<leader>ac` | Toggle AI Chat |
| `<leader>aa` | Open AI Assistant |
| `<leader>ai` | AI Inline Assistant |
| `ga` | Add selected text to Chat (Visual) |

> [!TIP]
> The AI chat opens as a Markdown buffer. **Type your question and press `<C-s>` to send it.**
> Inside the chat buffer, press **`ga`** to switch between adapters (Ollama/Gemini) and **`?`** to see all chat keymaps.

### 🐞 DAP (Debugger)
| Keymap | Action |
| --- | --- |
| `<F5>` | Start / Continue debugging |
| `<F10>` | Step over |
| `<F11>` | Step into |
| `<F12>` | Step out |
| `<leader>b` | Toggle breakpoint |
| `<leader>B` | Set conditional breakpoint |
| `<leader>dr` | Open DAP REPL |
| `<leader>du` | Toggle DAP UI |

## Adding New Tools

To add a new language server, linter, or formatter:
1.  Open `lua/plugins/lsp.lua`.
2.  Add the server to the `servers` table if it's an LSP.
3.  Add the tool name to the `ensure_installed` list in `lsp.lua` (this ensures Mason installs it).
4.  Configure formatting in `lua/plugins/autoformatting.lua` or linting in `lua/plugins/linting.lua` if necessary.
