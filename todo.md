# Todo
- [ ] config
- [x] package manager
    - i'll be using pack
- [ ] nvim-treesitter (highlighting from syntax-tree)
- [ ] lsp
- [x] clipboard support
- [ ] formating

# clipboard 
    Since windows binaries are in wsl path calling clip.exe is possible
    ```bash
        echo "copied" | clip.exe
    ```
## Ex command 
    ```neovim
       pressing : launches ex command mode
    ```
    ```neovim
        :call system('clip.exe', @") -- copy first register to system clipboard
    ```

## keymap

    ```neovim
        <leander>c -- copy first register to system clipboard
    ```

# todo neovim specific 
 - [ ] buffers 
 - [ ] window 
 - [ ] tabpage 
 - [ ] treesitter parser
    - structual code navigation and selection
 - tree-sitter vs LSP
    - tree-sitter lives locally inside your editor. It focuses entirely on the syntax structure of the active file for fast highlighting, motion, and text manipulation.
    - LSP runs as a separate background process. It handles project-wide intelligence, like finding definitions in other files, auto-importing, showing type errors, and refactoring across the entire codebase.

# command reminders
    
    ctrl+] -- jump to a tag
    ctrl+o -- go back
    ctrl+i -- go forward

    :Ex -- open file exploler
    :e <file_path> -- edit file
    :%s/^# \(.\{-\}\)??*$/- [ ] \1/ -- macro/command     
    :put _ -- inserts newline below the cursort without entering insert mode
    
    ## FZF
    :FzfLua <arg>

    mapping:
        - global keymaps
            no bind any global keyboard shortcuts
        - in-picker keymaps
           ```nvim
                ctrl+x open in horizontal split
                ctrl+v open in vertical split
                ctrl+t open in new tab
                shift-Up (Up-arrow) 
                shift-Down (Down-arrow) 
           ```
    # mini.completion
        <C-f> - scrolling info/signature window
        <C-b> - scrolling info/signature window
        <C-space> | <A-Space> - twostep/fallback completion 

    # nvim-treesitter
        A framework to 
            - generate a syntax tree
            - ask questions about the tree
        focus 
            - parsing 
            - incremental compilation
            - error recovery
            - queries
        
        used for
            - highlighting
            - indenting
            - structural editing
                - text objects
                - selections
                - move
            - folding
            - code
                - analysis
                - linter
                - context

        - parser generator
        - language-specific query

        update v12+

        build into neovim
            - vim.treesitter.start() -- syntax highlighting
            - vim.treesitter.foldexpr() -- tree-sitter folding
            - vim.treesitter - parser loading and runtime api
            - query execution - highlights, text objects

        nvim-treesitter 
            - indentation

# Neovim Info

    ampresand (&) symbol is used to indicate build in options in Ex command mode.
    & is a 'read-only-pointer' 
    ```nvim
        :echo &runtimepath -- reading
    ```

    ```nvim
        :set runtimepath=/some/path -- no need for &
    ```
    - variables and options

    formating
    - lps
        ```nvim
             vim.lsp.buf.format()
             vim.keymap.set('n', '<leander>f', vim.lsp.buf.format)
        ```


# Necessities

Programmer 
    - write, text, debug code

Editor
    - Syntax Highlighting 
    - Code Completion
    - Code Generation & Snippets
    - Go to Definition / Implementation
    - Find usages
    - File Hierarchy
    - Error Checking (Linters)
    - Debugging (Breakpoints, Variable Watching, Call Stack Inspection)
    - Git
    Diagnostics
        - Errors | not compile or run
        - Warnings | wrong, risky
        - Information/Hints | quality, performance, readability 
        - Lints | style and formating

# Linux fundamentals

ctrl+z | suspends a process and sends it to the backgournd
fg  | foreground bring the suspended process back, first in the queue
jobs | to see all background processes

# Ubuntu 

package managers
apt (application package tool)
dpkg (debian package)

from pre-compiled binaries:
system-wide manual installs ```bash ls -l /usr/local/bin```
user specific manual installs ```bash ls -l ~/.local/bin```
large self-contained packages ```bash ls -l /opt```

check your system
For a pre-compiled binary to run when you type its name in the terminal (without typing its full folder path), its location must be listed in your system's $PATH variable.
```bash echo $PATH | tr ':' '\n'```

search location
```bash which <program_name>```
```bash whereis <program_name>```

# Protocols

DAP (Debug Adapter Protocol)

# queue

1. nvim-treesitter
    - [x] [very good video watch when you return](https://www.youtube.com/watch?v=onaRTl-fWyI)
    - [ ] what are treesitter queries | use queries
    - [ ] text-objects in neovim and how nvim-treesitter extends them
        - vim has traditional text objects but nvim-treesitter-textobjects is more precise
2. - [ ] lsp
3. - [ ] FazzyFinding in the current buffer and more


# text motions

vis - select entire sentence

viw - select entire word
ciw - change entire word
diw - delete entire word
daw - delete entire word as well as surrounding space

vip - select entire paragraph
dip - delete entire paragraph as well as surrounding space

gUip - capitalize entire paragraph 

components
    a - a text object
    i - inside object

Why to do this? Well, there are a few reasons. When someone
writes something that you think is ridiculous, you might want to repeat it bacl
to them in this text style to mock them.

ci" - change inside a quote
vi( - select inside a quote

```lua
    function alt_case(str)
        local uppered = string.upper(str)
        local lowered  = string.lower(str)

        local substrs = {}

        for i=1, string.len(str) do
            local is_even = i % 2 == 0
            local source = is_even and uppered or lowered
            substrs[#substrs+1] = string.sub(source, i, i)
        end

        local result = table.concat(substrs)

        return result
    end

    extra = `???`
    local arg1 = "hello World!"
    result = alt_case(arg2, arg2)
``
vit -  select inside text

```html
    <div>TODO: add some text here...</div>
```

yiw	yank inner boundary of word
yaw	yank word and surrounding space
daw	delete a word and its surrounding space
daW	delete a Word (will include punctuation) and its surrounding space
vis	visually select inside a sentence
vas	visually select a sentence
dip	delete contents of a paragraph
dap	delete a paragraph and following linebreak
ci"	change inside a pair of double quotes
ca"	change a pair of double quotes
ci'	change inside a pair of single quotes
ca'	change a pair of single quotes
ci`	change inside a pair of backticks
ca`	change a pair of backticks
vib	visually select inside a pair of parens
vi(	visually select inside a pair of parens
vi[	visually select inside a pair of square brackets
vi{	visually select inside a pair of curly braces
vi<	visually select inside a pair of angle brackets
cit	change contents of an opening and closing tag
cat	change an opening and closing tag and its contents

# vim recap

actions
- v -- visually marking
- d -- deleting
- y -- yanking
- c -- changing

areas
- a -- around (@<object>.outer)
- i -- inside (@<object>.inner)

things
- w - words
- p - paragraphs
- s - sentences
- " - quotations

# Diagnostics

```nvim
:lua vim.diagnostics.config({ virtual_text = true }) -- show diagnostics messages next to the issue

:lua vim.diagnostics.setloclist() - modal window with all errors

:lua vim.diagnostics.open_float() -- opens floating window with diagnostics 

:lua vim.diagnostics.goto_next()
```
