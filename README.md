## What does this do?
### UI:
Adds support for vim-airline, delimitMate, vim-indentguides, coc.nvim and Plug.  
Uses a custom-made colorscheme based off Rainglow's 'darkside-contrast' for VSCode.  
Hides the trailing tildes and makes line numbers a e s t h e t i c.  

### Functional: 
Opens in Insert mode by default.  
Autocompletes parentheses so you don't have to.  
Supports code completion with Intellisense through coc.nvim  
Comes with a coderunner script and shortcut for one-tap code compilation;  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;F5 for C / C++ / Java / Python.  
Keyboard shortcuts for clipboard functions;  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Ctrl-C to Copy  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Ctrl-X to Cut Line  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Ctrl-P to Paste  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Ctrl-Z to Undo  
  
More to come!  
  

## Installation
Make sure you have git installed. If not, run ```sudo apt install git-core```  
#### coc.nvim Dependencies
Install npm when necessary. Run ```sudo apt install npm```  
This config uses clangd as the Language Server for the C family and is required. 
Run ```sudo apt install clang-8 clang-tools-8 && sudo update-alternatives --install /usr/bin/clangd clangd /usr/bin/clangd-8 100```  
  

1. Run this script in your terminal: ```wget -O - https://github.com/v15hv4/vimrc/raw/master/install.sh | sh```
2. ???
3. Profit!

## Uninstallation
Run this script in your terminal:  ```wget -O - https://github.com/v15hv4/vimrc/raw/master/uninstall.sh | sh``` 
