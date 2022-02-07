# dotfiles
Dot files for VIM and TMUX - the foci are on 

 - minimized numbers of plug-ins (dependencies) with maximum performance.

 - software development

 - linters, syntax highlighting, and language servers (C, C++, Python, Markdown, PlantUML)

 - a good work flow

_Note that you can install configuration (and dependencies) easily only for either VIM or TMUX._

## TMUX

The main feature is showing following panel at the bottom:
```
 master                        1:vim*              cpu0  0% cpu1  0% cpu2  4% cpu3  0%  21/10 09:28:39
 ^                               ^                        ^
 |                               |                        |
 +-- GIT branch                  +-- window(s)            +-- CPU loads, date, time
```

## VIM

Main features - for the list of plug-ins see `.vimrc`:

 - Use of vim-clap for searching almost everything: buffers, files, regex in files, marks, etc.

 - Use of vim-ale: linter and language client (LSP client)

 - Improved C++ syntax highlighting

 - Support of `.editorconfig`

 - Optimized for work with GIT

 - Improved syntax highlighting in Markdown files (e.g. markdown fenced languages are enabled)

 - Improved searching in files

 - Use of RIPGREP

## BASH

Main features:

 - A single big history for all TMUX sessions. *Note* that `~/.bashrc` is not modified!

# Setup

 - Clone repository into `~`:
```sh
git clone git@github.com:wosrediinanatour/dotfiles.git
```

 - Remove `~/.vimrc` and `~/.tmux.conf`, if they exist.

 - Install dot files (you need GNU stow, .e.g. by `sudo dnf install stow`) separately by:

```sh
$ cd ~/dotfiles
$ stow -v VIM
  LINK: .vimrc => dotfiles/VIM/.vimrc
$ stow -v TMUX
  LINK: .tmux.conf => dotfiles/TMUX/.tmux.conf
  LINK: show_load_per_cpu => dotfiles/TMUX/show_load_per_cpu
$ sudo stow -v BASH --target=/etc/profile.d/
  LINK: bashrc.sh => ../../var/home/fxaver/dotfiles/BASH/bashrc.sh
```

## VIM

 - Install [VIM Plug](https://github.com/junegunn/vim-plug):
```sh
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

 - VIM `:PlugInstall` triggers the installation of plug-ins.

 - You may install all dependencies together by
 ```sh
 sudo dnf install -y ripgrep ccls pandoc plantuml clang-format
 ```

    - RIPGREP is a fast replacement of GREP.

    - For Language Client ALE (vim) you need a language server. For C++ CCLS is configured.
 
    - For markdown linting Pandoc and for C and C++ linting clang-format is used.

    - PlantUML installation is optional.

## TMUX

 - Install TMUX Plugin Manager by `git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm`

 - `mstat` of Package `sysstat`  and `jq` are used for displaying CPU load:

```sh
sudo dnf install sysstat jq
```

 - TMUX `CTRL+B SHIT+I` triggers the installation of plug-ins.

# Uninstall

```sh
$ stow -D VIM
$ stow -D TMUX
$ sudo stow -D BASH --target=/etc/profile.d/
```


