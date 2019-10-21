# dotfiles
Dot files for VIM and TMUX - the focus is on minimized numbers of plug-ins with maximum performance.

## Setup

 - Clone repository into `~`:
```
git clone https://github.com/wosrediinanatour/dotfiles.git
```

 - Remove `~/.vimrc` and `~/.tmux.conf`

 - Install dot files:

```
$ stow -v VIM
LINK: .vimrc => dotfiles/VIM/.vimrc
$ stow -v TMUX
  LINK: .tmux.conf => dotfiles/TMUX/.tmux.conf
  LINK: show_load_per_cpu => dotfiles/TMUX/show_load_per_cpu
```

## Uninstall

```
$ stow -D VIM
$ stow -D TMUX
```

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

 - Use of FZF for almost everything
 - Support of GIT




