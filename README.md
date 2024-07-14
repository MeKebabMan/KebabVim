# KebabVim 🌯
Plugins bootstrapped onto a single init.lua file and randomly sent towards a repository for people to use!

### Features & Plugins:
- Autotag
- Autopairs
- nvim cmp
- nvim cmp lsp
- lua snip
- friendly snippets
- none ls
- none ls extras
- Neotree
- lualine
- nord theme
- Auto completion
- Lspconfig
- Mason
- Mason-lspconfig
- Language_servers
- Auto update feature

# Installation 💾

Just a reminder that this does require some dependencies to install but no worries we have a install dependencies script for that! **(BASH REQUIRED)**

### Steps to install:
- 1: Copy and paste the following script into your terminal

**WARNING: LINUX ONLY! USE WSL 2 UBUNTU OR DEBIAN FOR WINDOWS!!**

```sh
rm -rf ~/.config/nvim/ && mkdir -p ~/.config/nvim/ && git clone https://github.com/MeKebabMan/KebabVim.git ~/.config/nvim/ && \
 bash ~/.config/nvim/Install_dep.sh && nvim ~/.config/nvim/NVIM_README.txt
```

# Notes? 📝

- This project is under development
- This project is only meant for fun and learning!
- This proejct was created to make sure that I can easily get and use my neovim config!
- If you would like to use this then go ahead!

# Faster start up? 🚀

Because of KebabVim's Auto update feature the start up time may be slow **BUT** heres how you can fix it!

### Get faster start up speeds:
- open ~/.config/nvim/init.lua in your favourite code editor and disable the following local variables

```lua
-- SET THESE VARIABLES TO FALSE!!
local AUTO_UPDATE = false
```
