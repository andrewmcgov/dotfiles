# dotfiles

Based on [this article](https://www.atlassian.com/git/tutorials/dotfiles) on how to save dotfiles.

To start from scratch, run this:

```bash
git init --bare $HOME/.cfg
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
config config --local status.showUntrackedFiles no
echo "alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'" >> $HOME/.bashrc
```

This will alias `config` to run git in your dotfiles repo.
