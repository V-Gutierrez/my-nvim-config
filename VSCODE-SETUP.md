# VSCode Neovim Setup - Instruções Completas

Este arquivo documenta a configuração minimalista do Neovim para VSCode com **todos os keybindings** do LazyVim mapeados para comandos equivalentes.

## 📁 Arquivos Criados

- `vscode-init.lua` - Configuração exclusiva para VSCode
- `init.lua` - Detecta VSCode automaticamente e carrega o arquivo correto

## ✅ O que está incluído

### 1. nvim-surround
Todos os keymaps funcionando:
- `ys{motion}{char}` - adicionar surround (ex: `ysiw"` = aspas na palavra)
- `ds{char}` - deletar surround (ex: `ds"` = remover aspas)
- `cs{old}{new}` - mudar surround (ex: `cs"'` = aspas duplas → simples)
- `gs` (visual mode) - adicionar surround no texto selecionado
- Surrounds custom: aspas, HTML tags, markdown code blocks, parênteses com espaços

### 2. Diagnostic styling
Ícones e cores de LSP diagnostics configurados

### 3. Keymaps LazyVim → VSCode
**Total: 28 keymaps** mapeados do seu LazyVim para comandos equivalentes do VSCode

---

## 🎯 Referência Completa de Keymaps

### Flash Navigation → VSCode Search (12 keymaps)

| Keymap | LazyVim Action | VSCode Command | Descrição |
|--------|----------------|----------------|-----------|
| `s` | Flash jump | `actions.find` | Busca incremental (abre find) |
| `S` | Flash Treesitter | `workbench.action.gotoSymbol` | Navegação por símbolos/funções |
| `r` | Remote Flash | `workbench.action.quickOpen` | Quick Open (Cmd+P) |
| `R` | Treesitter Search | `workbench.action.showAllSymbols` | Símbolos no workspace |
| `f` | Flash char | `actions.find` | Busca forward (abre find) |
| `F` | Flash char backward | `actions.findWithSelection` | Busca backward |
| `t` | Flash till | `actions.find` | Busca till (abre find) |
| `T` | Flash till backward | `actions.findWithSelection` | Busca till backward |
| `e` | End of word | *Native Vim* | Motion nativo (já funciona) |
| `;` | Repeat f/t | `editor.action.nextMatchFindAction` | Próxima ocorrência |
| `,` | Repeat f/t reverse | `editor.action.previousMatchFindAction` | Ocorrência anterior |

⚠️ **IMPORTANTE**: Os bindings `s`, `f`, `t` **não têm labels visuais** do Flash.nvim. Eles abrirão a busca nativa do VSCode (`Cmd+F`) em vez de mostrar labels interativas.

### Window Navigation → Editor Groups (6 keymaps)

| Keymap | LazyVim Action | VSCode Command | Descrição |
|--------|----------------|----------------|-----------|
| `<C-h>` | Navigate left | `workbench.action.navigateLeft` | Foco editor à esquerda |
| `<C-j>` | Navigate down | `workbench.action.navigateDown` | Foco editor abaixo |
| `<C-k>` | Navigate up | `workbench.action.navigateUp` | Foco editor acima |
| `<C-l>` | Navigate right | `workbench.action.navigateRight` | Foco editor à direita |
| `<leader>ww` | Other window | `workbench.action.focusNextGroup` | Trocar foco de grupo |
| `<leader>wd` | Delete window | `workbench.action.closeActiveEditor` | Fechar editor |

### Buffer Navigation → Tabs (4 keymaps)

| Keymap | LazyVim Action | VSCode Command | Descrição |
|--------|----------------|----------------|-----------|
| `<leader>bn` | Next buffer | `workbench.action.nextEditor` | Próximo editor/tab |
| `<leader>bp` | Previous buffer | `workbench.action.previousEditor` | Editor/tab anterior |
| `<leader>bb` | Buffer picker | `workbench.action.quickOpen` | Picker de arquivos |
| `<leader>bd` | Delete buffer | `workbench.action.closeActiveEditor` | Fechar editor |

### LSP Diagnostics → VSCode Problems (4 keymaps)

| Keymap | LazyVim Action | VSCode Command | Descrição |
|--------|----------------|----------------|-----------|
| `]d` | Next diagnostic | `editor.action.marker.nextInFiles` | Próximo diagnostic |
| `[d` | Previous diagnostic | `editor.action.marker.prevInFiles` | Diagnostic anterior |
| `]e` | Next error | `editor.action.marker.nextInFiles` | Próximo erro |
| `[e` | Previous error | `editor.action.marker.prevInFiles` | Erro anterior |

### Git & Custom (2 keymaps)

| Keymap | LazyVim Action | VSCode Command | Descrição |
|--------|----------------|----------------|-----------|
| `<leader>gg` | Open LazyGit | `workbench.view.scm` | Abrir Git view |
| `<leader>cp` | Copy file path | Custom command | Copiar caminho completo do arquivo |

---

## ⚠️ Limitações

### Flash.nvim Labels Visuais

**O que você tinha no LazyVim:**
- Apertar `f` → Labels aparecem em todos os caracteres visíveis (`a`, `b`, `c`, etc.)
- Digitar o label → Cursor pula instantaneamente

**O que você tem agora no VSCode:**
- Apertar `f` → Abre busca nativa do VSCode (`Cmd+F`)
- Digitar caractere → Busca incremental (sem labels)
- `Enter` ou `Esc` → Sai da busca

**Alternativas sugeridas:**
1. **Usar VSCode native shortcuts diretamente** - Pode ser mais rápido:
   - `Cmd+F` - Find
   - `Cmd+P` - Quick Open
   - `Cmd+Shift+O` - Go to Symbol
   - `Cmd+T` - Go to Symbol in Workspace

2. **Treinar muscle memory** - Usar comandos VSCode em vez de Vim motions no contexto do VSCode

### Navegação de Janelas

VSCode usa "Editor Groups" (diferente de windows do Vim). Os keymaps `<C-h/j/k/l>` funcionam, mas pode haver pequenas diferenças no comportamento.

---

## 🧪 Testar a Configuração

1. **Recarregar VSCode**
   ```
   Cmd+Shift+P → "Reload Window"
   ```

2. **Verificar que o config carregou**
   - Você deve ver: "VSCode Neovim config loaded" (notificação)

3. **Testar keymaps principais**:
   - `s` → Deve abrir busca (Find)
   - `S` → Deve abrir Go to Symbol
   - `ysiw"` → Deve adicionar aspas na palavra
   - `<C-h/j/k/l>` → Deve navegar entre editor groups
   - `<leader>bn` → Próximo editor

---

## ❌ O que NÃO está incluído

- Flash.nvim (incompatível com vscode-neovim)
- Todos os outros plugins LazyVim (UI, animações, etc.)
- Auto-save autocmd (evita conflito)
- UI plugins que causam bugs de rolamento

---

## 🔧 Troubleshooting

### Keymaps não funcionam

**Verifique se o config carregou:**
```vim
:messages
```

Deve aparecer "VSCode Neovim config loaded".

**Verifique se está no VSCode:**
```vim
:echo vim.g.vscode
```

Deve retornar `v:true` ou `1`.

### Surround não funciona

**Verifique se lazy.nvim instalou o plugin:**
```vim
:Lazy
```

Deve aparecer `nvim-surround` na lista.

### `f` ou `t` ainda funcionam como Vim nativo

Isso significa que o VSCode não está reconhecendo os keymaps. Possíveis causas:

1. **VSCode Neovim extension não habilitada** - Verifique se `asvetliakov.vscode-neovim` está instalada
2. **Config não carregou** - Recarregue o VSCode
3. **Erro no vscode-init.lua** - Execute `:messages` para ver erros

### Performance ruim

A configuração é extremamente leve (apenas 1 plugin). Se estiver lento:

1. **Verificar se outros plugins LazyVim estão carregando**:
   ```vim
   :Lazy
   ```
   Deve mostrar APENAS `lazy.nvim` e `nvim-surround`.

2. **Verificar extensions pesadas do VSCode** - Desabilite temporariamente outras extensões

3. **Diagnosticar**:
   ```vim
   :checkhealth
   ```

---

## 📝 Comandos Úteis do VSCode

Além dos keymaps Vim mapeados, esses comandos nativos do VSCode são úteis:

| Comando VSCode | Keymap | Equivalente LazyVim |
|----------------|--------|---------------------|
| Command Palette | `Cmd+Shift+P` | `:Telescope commands` |
| Quick Open | `Cmd+P` | `<leader>ff` |
| Go to Line | `Ctrl+G` | `:{number}` |
| Toggle Sidebar | `Cmd+B` | `<leader>e` |
| Toggle Terminal | `` Ctrl+` `` | `<leader>ft` |
| Format Document | `Shift+Alt+F` | `<leader>cf` |

---

## 🎓 Dicas de Uso

### Workflow Sugerido

1. **Navegação de arquivos**: Use `Cmd+P` (Quick Open) - mais rápido que `r`
2. **Navegação dentro do arquivo**: Use `S` (Go to Symbol) - funciona muito bem
3. **Busca de texto**: Use `s` ou `Cmd+F` diretamente
4. **Navegação entre editores**: Use `<C-h/j/k/l>` - muscle memory do Vim
5. **Surround**: Funciona perfeitamente - use normalmente

### Muscle Memory LazyVim → VSCode

Se você usa muito Flash no LazyVim, considere treinar esses equivalentes:

| LazyVim (Flash) | VSCode Equivalent | Como usar |
|-----------------|-------------------|-----------|
| `s{char}{label}` | `s` depois digite | Abre find, digite caractere |
| `S` (Treesitter) | `S` | **Funciona igual!** Go to Symbol |
| `f{char}` | `f` depois digite | Abre find, digite caractere |
| `/pattern` | `Cmd+F` | Busca nativa - use diretamente |

---

Criado por Claude Code 🤖
