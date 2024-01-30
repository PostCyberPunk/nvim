# 💤 LazyVim

A starter template for [LazyVim](https://github.com/LazyVim/LazyVim).
Refer to the [documentation](https://lazyvim.github.io/installation) to get started.

## Back up
### windows
```sh
Move-Item $env:LOCALAPPDATA\nvim $env:LOCALAPPDATA\nvim.lazy
Move-Item $env:LOCALAPPDATA\nvim-data $env:LOCALAPPDATA\nvim-data.lazy
```
### linux
```sh
# required
mv ~/.config/nvim{,.bak}

# optional but recommended
mv ~/.local/share/nvim{,.bak}
mv ~/.local/state/nvim{,.bak}
mv ~/.cache/nvim{,.bak}
```
## Installl
### windows
```sh
git clone https://github.com/postcypunk/LazyVim $env:LOCALAPPDATA\nvim
```
### linux
```sh
git clone https://github.com/postcypunk/LazyVim ~/.config/nvim
cp ~/.config/nvim/lua/pcp/extra ~/.config/nvim/lua/pcp/extra.lua
```
