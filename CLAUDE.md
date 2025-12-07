# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Architecture

This is a **LazyVim-based Neovim configuration** with dual-environment support (Neovim + VSCode).

### Entry Points
- `init.lua` - Detects VSCode via `vim.g.vscode` and routes to appropriate config
  - Neovim mode → `lua/config/lazy.lua` (full LazyVim setup)
  - VSCode mode → `vscode-init.lua` (minimal surround-only config)

### Directory Structure
```
lua/
├── config/           # Core configuration
│   ├── lazy.lua     # Plugin manager bootstrap
│   ├── options.lua  # Vim options & diagnostics
│   ├── keymaps.lua  # Custom keybindings
│   └── autocmds.lua # Auto-save functionality
└── plugins/          # Custom plugin configurations
    ├── flash.lua    # Navigation with jump labels
    ├── surround.lua # Text surrounding operations
    ├── colorscheme.lua
    ├── lazy-git.lua
    └── universal-lint.lua
```

## Key Configuration Files

### Core Configuration
- **lazy.lua** - LazyVim bootstrap, sets `lazy = false` for custom plugins, disables built-in plugins (gzip, tar, tutor, zip)
- **options.lua** - Diagnostic display customization (no Info sign, custom virtual text with `●` prefix), `updatetime = 300ms`
- **keymaps.lua** - Custom `<leader>cp` (copy file path) and keymap reference documentation
- **autocmds.lua** - Auto-save on `InsertLeave`, `TextChanged`, `FocusLost`, `BufLeave`

### Plugin Configurations
- **flash.lua** - Keybindings: `s` (jump), `S` (treesitter), `r` (remote), `R` (treesitter search), `/` (search with labels)
- **surround.lua** - **Critical**: Uses `gs`/`gS` in visual mode (changed from default `S` to avoid Flash conflict)
- **vscode-init.lua** - VSCode-only config with nvim-surround and 30 keymaps mapped to VSCode commands

## Important Patterns

### Keymap Conflict Resolution
The config resolves a Flash/Surround conflict:
- Flash.nvim uses `S` for Treesitter navigation (lua/plugins/flash.lua:185)
- nvim-surround changed from `S` → `gs`/`gS` in visual mode (lua/plugins/surround.lua:16)
- **Always respect this convention when adding keymaps**

### Diagnostic Configuration
Located in lua/config/options.lua:6-30:
- Info diagnostics have no sign (empty string) for clean UI
- Virtual text uses `●` prefix with 4-space spacing
- Rounded borders on float windows
- Auto-display on `CursorHold` (300ms updatetime)

### VSCode Detection
When modifying configs, check VSCode mode:
```lua
if vim.g.vscode then
  -- VSCode-specific config
else
  -- Neovim config
end
```

### Plugin Loading Strategy
- Custom plugins: `lazy = false` (load at startup) in lua/config/lazy.lua:27
- LazyVim extras: 69 extras enabled via lazyvim.json (AI, coding, DAP, editor, formatting, languages, LSP, UI, utils)
- Version strategy: `version = false` (always use latest git commit)

## Common Operations

### Plugin Management
```vim
:Lazy                    " Open plugin manager UI
:Lazy sync              " Install/update/clean plugins
:Lazy clean             " Remove unused plugins
:Lazy profile           " Profile startup time
```

### Configuration Reload
- Restart Neovim (recommended)
- Or `:source $MYVIMRC` (may not reload all changes)

### Custom Commands
- `:CopyFilePath` - Copy full file path to clipboard (mapped to `<leader>cp`)

## LazyVim Reference

This config extends LazyVim. Key LazyVim defaults:
- Plugin specs in `lua/plugins/*.lua` are auto-loaded
- Default keymaps: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
- Default options: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua

## VSCode Integration

The `vscode-init.lua` provides a minimal config for VSCode Neovim extension:
- Only loads nvim-surround plugin
- Maps 30 LazyVim keybindings to VSCode commands
- Flash navigation keymaps (`s`, `f`, `t`) open VSCode's native find (no jump labels)
- See VSCODE-SETUP.md for complete keymap reference

## Important Notes

1. **Keymap conflicts are documented** - Check lua/config/keymaps.lua:14-37 for plugin keybinding reference
2. **Auto-save is enabled** - Files save automatically on buffer changes
3. **Custom plugins load immediately** - `lazy = false` means no lazy-loading for lua/plugins/*
4. **Diagnostic signs are customized** - Info level has no sign (lua/config/options.lua:26)
5. **VSCode mode uses minimal config** - Only surround plugin loads in VSCode to avoid conflicts
