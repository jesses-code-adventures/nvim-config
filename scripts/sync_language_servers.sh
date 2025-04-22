#!/bin/bash

# Go
go install golang.org/x/tools/gopls@latest

# JSON, YAML, TypeScript, Tailwind
npm i -g vscode-langservers-extracted yaml-language-server typescript-language-server @tailwindcss/language-server

# Lua 
brew install lua-language-server

# Python
npm i -g pyright

echo "All language servers installed/updated"
