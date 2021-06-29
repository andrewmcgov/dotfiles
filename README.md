# dotfiles

Based on [this article](http://blog.smalleycreative.com/tutorials/using-git-and-github-to-manage-your-dotfiles/) on how to save dotfiles.

To set up these dotfiles on a new machine, run this:

```bash
git clone https://github.com/andrewmcgov/dotfiles

./makesymlinks.sh
```

You may need to make `makesymlinks.sh` executable by running `chmod +x makesymlinks.sh`.

After running this, all changes you make will be matched in the `~/dotfiles` folder and you can commit them to git as normal.
