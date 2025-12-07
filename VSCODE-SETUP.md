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

### 3. Yank visual feedback
Highlight amarelo (200ms) quando você copia texto com `y`, `yf`, `yw`, etc.

### 4. Keymaps LazyVim → VSCode
**Total: 26 keymaps** mapeados do seu LazyVim para comandos equivalentes do VSCode

---

## 🎯 Referência Completa de Keymaps

### Flash Navigation → VSCode Search (8 keymaps)

| Keymap | LazyVim Action | VSCode Command | Descrição |
|--------|----------------|----------------|-----------|
| `s` | Flash jump | `actions.find` | Busca incremental (abre find) |
| `S` | Flash Treesitter | `workbench.action.gotoSymbol` | Navegação por símbolos/funções |
| `r` | Remote Flash | `workbench.action.quickOpen` | Quick Open (Cmd+P) |
| `R` | Treesitter Search | `workbench.action.showAllSymbols` | Símbolos no workspace |
| `f/t/F/T` | Flash char motions | *Native Vim* | **Agora usam motions nativos!** vf, vt, yf, yt funcionam |
| `e` | End of word | *Native Vim* | Motion nativo (já funciona) |
| `;` | Repeat f/t | `editor.action.nextMatchFindAction` | Próxima ocorrência |
| `,` | Repeat f/t reverse | `editor.action.previousMatchFindAction` | Ocorrência anterior |

✅ **MELHORIAS**:
- `f/t/F/T` agora são motions nativos do Vim - **`vf`, `vt`, `yf`, `yt` funcionam perfeitamente!**
- Yank feedback visual (highlight amarelo 200ms) em todas operações de cópia
- Use `s` para busca rápida no VSCode se precisar

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

### LSP Navigation → Code Navigation (2 keymaps)

| Keymap | LazyVim Action | VSCode Command | Descrição |
|--------|----------------|----------------|-----------|
| `gd` | Go to Definition | `editor.action.revealDefinition` | Ir para definição do símbolo |
| `gr` | Go to References | `editor.action.findReferences` | Ver referências em peek view inline (Shift+F12) |

### Git & Custom (2 keymaps)

| Keymap | LazyVim Action | VSCode Command | Descrição |
|--------|----------------|----------------|-----------|
| `<leader>gg` | Open LazyGit | `workbench.view.scm` | Abrir Git view |
| `<leader>cp` | Copy file path | Custom command | Copiar caminho completo do arquivo |

---

## ⚠️ Limitações

### Flash.nvim Labels Visuais

**O que mudou:**
- ✅ **`f/t/F/T` agora funcionam como motions nativos do Vim** (vf, vt, yf, yt, df, dt, etc.)
- ❌ **Sem labels visuais do Flash.nvim** (limitação da extensão VSCode Neovim)
- ✅ **Yank feedback visual** - Highlight amarelo (200ms) ao copiar texto

**Como usar agora:**
1. **Motions com f/t (funcionam!):**
   - `vf"` - seleciona até aspas (inclusive)
   - `vt"` - seleciona até aspas (exclusive)
   - `yf)` - copia até parêntese (com highlight feedback!)
   - `df,` - deleta até vírgula

2. **Busca rápida (sem motion):**
   - `s` - Abre VSCode find (use em vez de f/t para busca pura)
   - `S` - Go to Symbol (navegação semântica)
   - `Cmd+F` - Find nativo do VSCode

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
   - `gd` → Ir para definição do símbolo
   - `gr` → Ver referências do símbolo
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

Mudanças no comportamento:

| LazyVim (Flash) | VSCode Neovim | Como usar |
|-----------------|---------------|-----------|
| `s{char}{label}` | `s` abre find | Abre find, digite padrão de busca |
| `S` (Treesitter) | `S` | **Funciona igual!** Go to Symbol |
| `f{char}` (motion) | `f{char}` | **Funciona como motion nativo!** vf, yf, df, etc. |
| `t{char}` (motion) | `t{char}` | **Funciona como motion nativo!** vt, yt, dt, etc. |
| `/pattern` | `Cmd+F` ou `s` | Busca nativa VSCode ou `s` |

---

Criado por Claude Code 🤖
