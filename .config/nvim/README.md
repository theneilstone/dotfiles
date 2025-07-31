# 🚀 Modern Neovim Configuration

A clean, fast, and feature-rich Neovim configuration built with Lua and organized for maximum productivity.

## ✨ Features

- **🔧 Modular Architecture**: Well-organized configuration structure
- **⚡ Performance Optimized**: Fast startup with lazy loading
- **🎨 Beautiful UI**: Modern interface with TokyoNight theme
- **🔍 Powerful Search**: Telescope integration for fuzzy finding
- **🧠 Smart Completion**: Blink.cmp with AI assistance via Copilot
- **📝 Language Support**: LSP, formatting, and linting for multiple languages
- **🤖 AI Integration**: Code Companion and Copilot for enhanced coding
- **🔀 Git Integration**: Gitsigns and Fugitive for version control
- **📊 Diagnostics**: Trouble for error navigation
- **🎯 Quick Navigation**: Flash for rapid movement
- **📋 Enhanced Editing**: Auto-pairs, surround, and Parinfer support

## 📁 Structure

```
~/.config/nvim/
├── init.lua                 # Main entry point
├── lazy-lock.json          # Plugin lock file
├── lua/
│   ├── core/               # Core configuration
│   │   ├── bootstrap.lua   # Essential bootstrapping
│   │   ├── options.lua     # Editor options
│   │   ├── keymaps.lua     # Key mappings
│   │   ├── lazy.lua        # Plugin manager setup
│   │   └── colorscheme.lua # Theme configuration
│   └── plugins/            # Plugin configurations
│       ├── editor/         # Core editing plugins
│       │   ├── flash.nvim.lua
│       │   ├── indent-blankline.nvim.lua
│       │   ├── nvim-autopairs.lua
│       │   ├── nvim-parinfer.lua
│       │   ├── nvim-surround.lua
│       │   ├── nvim-treesitter.lua
│       │   ├── nvim-treesitter-context.lua
│       │   └── nvim-treesitter-textobjects.lua
│       ├── git/            # Git integration
│       │   ├── gitsigns.nvim.lua
│       │   └── vim-fugitive.lua
│       ├── lsp/            # Language server setup
│       │   ├── blink.cmp.lua
│       │   ├── code-companion.nvim.lua
│       │   ├── conform.nvim.lua
│       │   ├── copilot.lua
│       │   ├── mason-lspconfig.nvim.lua
│       │   ├── mason-nvim.lua
│       │   ├── nvim-lint.lua
│       │   └── nvim-lspconfig.lua
│       ├── tools/          # Utility tools
│       │   ├── faster.nvim.lua
│       │   ├── render-markdown.nvim.lua
│       │   ├── telescope.lua
│       │   ├── todo-comments.nvim.lua
│       │   ├── toggleterm.nvim.lua
│       │   └── trouble.nvim.lua
│       └── ui/             # UI enhancement plugins
│           ├── lualine.nvim.lua
│           ├── noice.nvim.lua
│           └── tokyonight.nvim.lua
└── README.md               # This file
```

## 🔧 Requirements

- **Neovim** >= 0.9.0
- **Git** for plugin management
- **Node.js** for some LSP servers and Copilot
- **Python** for some plugins
- **ripgrep** for telescope live grep
- **fd** (optional) for better file finding
- A **Nerd Font** for icons

## ⌨️ Key Mappings

### Leader Key: `<Space>`

#### File Operations
| Key | Description |
|-----|-------------|
| `<leader>w` | Save file |
| `<leader>q` | Quit |
| `<leader>x` | Save and quit |

#### File Finding (Telescope)
| Key | Description |
|-----|-------------|
| `<leader>ff` | Find files |
| `<leader>fg` | Find git files |
| `<leader>fb` | Find buffers |
| `<leader>flg` | Live grep |
| `<leader>fh` | Help tags |
| `<leader>fr` | Recent files |

#### Git
| Key | Description |
|-----|-------------|
| `<leader>gs` | Git status |
| `<leader>gc` | Git commit |
| `<leader>gp` | Git push |
| `<leader>gl` | Git pull |

#### LSP
| Key | Description |
|-----|-------------|
| `gd` | Go to definition |
| `gr` | Show references |
| `K` | Show hover documentation |
| `<leader>ca` | Code actions |
| `<leader>rn` | Rename symbol |
| `<leader>f` | Format document |

#### Navigation
| Key | Description |
|-----|-------------|
| `<C-h/j/k/l>` | Window navigation |
| `<S-h/l>` | Buffer navigation |
| `s` | Flash jump |
| `jk` or `kj` | Exit insert mode |

#### Diagnostics
| Key | Description |
|-----|-------------|
| `[d` / `]d` | Previous/Next diagnostic |
| `<leader>xx` | Toggle trouble |
| `<leader>xd` | Show diagnostics |

## 🎨 Customization

### Changing Theme
Edit `lua/core/colorscheme.lua`:
```lua
local colorscheme = "your-theme"
```

### Adding Plugins
Create new files in the appropriate `lua/plugins/` subdirectory:
```lua
-- lua/plugins/editor/new-plugin.lua
return {
  "author/plugin-name",
  config = function()
    -- Plugin configuration
  end,
}
```

### Custom Keymaps
Add to `lua/core/keymaps.lua`:
```lua
vim.keymap.set("n", "<leader>custom", ":YourCommand<CR>", { desc = "Description" })
```

## 🔌 Included Plugins

### Core
- **lazy.nvim** - Plugin manager
- **faster.nvim** - Performance optimization

### UI
- **tokyonight.nvim** - Color scheme
- **lualine.nvim** - Status line
- **noice.nvim** - Enhanced UI notifications
- **indent-blankline.nvim** - Indentation guides

### Editor
- **nvim-treesitter** - Syntax highlighting and parsing
- **nvim-treesitter-context** - Show context at top
- **nvim-treesitter-textobjects** - Smart text objects
- **flash.nvim** - Quick navigation and jumping
- **nvim-autopairs** - Auto-close brackets and quotes
- **nvim-surround** - Manipulate surrounding characters
- **nvim-parinfer** - Lisp-style parentheses editing

### Tools
- **telescope.nvim** - Fuzzy finder and picker
- **toggleterm.nvim** - Terminal integration
- **trouble.nvim** - Diagnostics and quickfix panel
- **todo-comments.nvim** - TODO highlighting and navigation
- **render-markdown.nvim** - Enhanced markdown rendering

### LSP & Completion
- **nvim-lspconfig** - LSP configuration
- **mason.nvim** - LSP server installer
- **mason-lspconfig.nvim** - Mason and lspconfig integration
- **blink.cmp** - Fast completion engine
- **copilot.lua** - GitHub Copilot integration
- **code-companion.nvim** - AI coding assistant
- **conform.nvim** - Code formatting
- **nvim-lint** - Asynchronous linting

### Git
- **gitsigns.nvim** - Git signs and hunks
- **vim-fugitive** - Git commands and interface

## 🚀 Performance

This configuration is optimized for fast startup and modern Neovim features:
- Lazy loading of plugins
- Disabled unnecessary built-in plugins
- Optimized autocommands
- Efficient plugin configurations
- **Updated to latest standards:**
  - ✅ Replaced deprecated `tsserver` with `ts_ls`
  - ✅ Removed obsolete `cmp-nvim-lsp` dependencies
  - ✅ Updated Copilot configuration
  - ✅ Modernized blink.cmp setup
  - ✅ Clean autopairs integration

---

**Happy coding! 🎉**
