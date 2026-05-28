# Todo
- [ ] config
- [ ] package manager
- [ ] nvim-treesitter (highlighting from syntax-tree)
- lsp
- [x] clipboard support

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
    - LSP runs as a separate background process. It handles project-wide intelligence, like finding definitions in other files, auto-importing, showing type errors, and refactoring across the whole codebase.

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

# Info

    ampresand (&) symbol is used to indicate build in options in Ex command mode.
    & is a 'read-only-pointer' 
    ```nvim
        :echo &runtimepath -- reading
    ```

    ```nvim
        :set runtimepath=/some/path -- no need for &
    ```
    - variables and options

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
