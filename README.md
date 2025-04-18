This directory contains the .dotfiles for my system.

## Requirements

Ensure you have the following installed on your system

### Git

```
pacman -S git
```

### Stow

```
pacman -S stow
```

## Installation

First, check out the .dotfiles repo in your $HOME directory using git

```
$ git clone git@github.com/dreamsofautonomy/dotfiles.git
$ cd .dotfiles
```

then use GNU stow to create symlinks

```
$ stow .
```

## References

### Stow has forever changed the way I manage my dotfiles

- https://www.youtube.com/watch?v=y6XCebnB9gs&t=154s

### ~/.dotfiles in 100 Seconds

- https://www.youtube.com/watch?v=r_MpUP6aKiQ&t=368s
