
# load dev, but only if present and the shell is interactive
if [[ -f /opt/dev/dev.sh ]] && [[ $- == *i* ]]; then
  source /opt/dev/dev.sh
fi
alias config='/usr/bin/git --git-dir=/Users/andrewmcgoveran/.cfg/ --work-tree=/Users/andrewmcgoveran'
