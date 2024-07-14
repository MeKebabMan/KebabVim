#!/bin/bash 

test -d ~/.config/nvim/* && rm -rf ~/.config/nvim/* && \
	mkdir -p ~/.config/nvim/ && git clone https://github.com/MeKebabMan/KebabVim ~/.config/nvim/ && \
		nvim ~/.config/nvim/NVIM_README.txt
