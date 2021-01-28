# dotfiles
Dot files for VIM and TMUX - the focus is on minimized numbers of plug-ins with maximum performance.

## TMUX

Main feature - iIt shows following panel:
```
 master                        1:vim*              cpu0  0% cpu1  0% cpu2  4% cpu3  0%  21/10 09:28:39
 ^                               ^                        ^
 |                               |                        |
 +-- GIT branch                  +-- window(s)            +-- CPU loads, date, time
```

## VIM

Main features - for the list of plug-ins see `.vimrc`:

 - Use of FZF for almost everything: buffers, searching for files, marks, etc.
 - Support of GIT


# Setup

 - Clone repository into `~`:
```
git clone https://github.com/wosrediinanatour/dotfiles.git
```

 - Remove `~/.vimrc` and `~/.tmux.conf`

 - Install dot files (you need GNU stow, .e.g. by `sudo dnf install stow`):

```
$ cd ~/dotfiles
$ stow -v VIM
  LINK: .vimrc => dotfiles/VIM/.vimrc
$ stow -v TMUX
  LINK: .tmux.conf => dotfiles/TMUX/.tmux.conf
  LINK: show_load_per_cpu => dotfiles/TMUX/show_load_per_cpu
```

## VIM

- Install VIM Plug: https://github.com/junegunn/vim-plug
 
```
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```


 - VIM `:PlugInstall` and in TMUX `CTRL+B CTRL+I` triggers the installation of plug-ins.

 - For Language Client ALE (vim) you need the language server ccls: `sudo dnf install ccls`

## TMUX

 - Install TMUX Plugin Manager by `git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm`

 - `mstat` of Package `sysstat`  and `jq` are used for displaying CPU load:

```
sudo dnf install sysstat jq
```

# Uninstall

```
$ stow -D VIM
$ stow -D TMUX
```


