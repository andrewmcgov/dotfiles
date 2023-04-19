###
# Functions
###

# These functions are mostly from https://github.com/adamhollett/dotfiles

# Show colorful chevrons according to what season it is.
chevrons () {
  local date=$(date)
  local chevrons="❯❯❯"

  case $date in
    # spring
    *Mar*|*Apr*|*May*)
      chevrons="%F{cyan}❯%F{green}❯%F{yellow}❯%f"
      ;;
    # summer
    *Jun*|*Jul*|*Aug*)
      chevrons="%F{green}❯%F{yellow}❯%F{red}❯%f"
      ;;
    # fall
    *Sep*|*Oct*|*Nov*)
      chevrons="%F{yellow}❯%F{red}❯%F{magenta}❯%f"
      ;;
    # winter
    *Dec*|*Jan*|*Feb*)
      chevrons="%F{magenta}❯%F{cyan}❯%F{green}❯%f"
      ;;
    *)
      ;;
  esac

  echo $chevrons
}

# Check if hostname includes 'spin' and return an emoji accordingly
function check_hostname() {
  if [[ `hostname` == *"spin"* ]]; then
    echo "🌀 "
  else
    echo ""
  fi
}

# Return the branch name if we're in a git repo, or nothing otherwise.
git_check () {
  local gitBranch=$(git branch 2> /dev/null | sed -e "/^[^*]/d" -e "s/* \(.*\)/\1/")
  if [[ $gitBranch ]]; then
    echo -en $gitBranch
    return
  fi
}

# Return the status of the current git repo.
git_status () {
  local gitBranch="$(git_check)"
  if [[ $gitBranch ]]; then
    local statusCheck=$(git status 2> /dev/null)
    if [[ $statusCheck =~ 'Your branch is ahead' ]]; then
      echo -en 'ahead'
    elif [[ $statusCheck =~ 'Changes to be committed' ]]; then
      echo -en 'staged'
    elif [[ $statusCheck =~ 'no changes added' ]]; then
      echo -en 'modified'
    elif [[ $statusCheck =~ 'working tree clean' ]]; then
      echo -en 'clean'
    fi
  fi
}

# Return a color based on the current git status.
git_status_color () {
  local gitStatus="$(git_status)"
  local statusText=''
  case $gitStatus in
    clean*)
      statusText="green"
      ;;
    modified*)
      statusText="magenta"
      ;;
    staged*)
      statusText="yellow"
      ;;
    ahead*)
      statusText="cyan"
      ;;
    *)
      statusText="white"
      ;;
  esac
  echo -en $statusText
}

# Print a label for the current git branch if it isn't master.
git_branch () {
  local gitBranch="$(git_check)"
  if [[ $gitBranch ]]; then
    echo -en "%F{"$(git_status_color)"}⌥ $gitBranch%f"
  fi
}

# Print a dot indicating the current git status.
git_dot () {
  local gitCheck="$(git_check)"
  if [[ $gitCheck ]]; then
    local gitStatus="$(git_status)"
    local gitStatusDot='●'
    if [[ $gitStatus == 'staged' ]]; then
      local gitStatusDot='◍'
    elif [[ $gitStatus == 'modified' ]]; then
      local gitStatusDot='○'
    fi
    if [[ $gitCheck && ! $gitCheck == 'master' && $COLUMNS -lt 80 ]]; then
      echo -en "%F{#616161}⌥%f"
    fi
    echo -en "%F{"$(git_status_color)"}$gitStatusDot%f"
  fi
}

# Get the current directory, truncate it, and make it blue
fancy_dir () {
  echo -en "%F{cyan}%2~%f"
  return
}

# Get the formatted prompt
get_prompt() {
  local currentGitBranch=$(git_branch)
  local currentDir="$(fancy_dir)"

  if [[ -z $currentGitBranch ]]; then
    echo "$(check_hostname)$currentDir $(chevrons) "
    return
  fi

  echo "$(check_hostname)$currentDir $(git_dot) $currentGitBranch$NEWLINE$(chevrons) "
}

NEWLINE='
'

###
# Set options
###
setopt AUTO_CD
setopt prompt_subst

# load compinit and promptinit
autoload -Uz compinit promptinit

# initialize advanced tab completion
compinit -i

# make tab completeion case-insensitive
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# highlight the selected suggestion when tabbing through tab completion options
zstyle ':completion:*' menu select

# initialize advanced prompt support
promptinit

# set the prompt
PS1='%B$(get_prompt)%b'


###
# Aliases
###
alias amend='git commit --amend --no-edit'

[ -f /opt/dev/dev.sh ] && source /opt/dev/dev.sh
if [ -e /Users/andrewmcgoveran/.nix-profile/etc/profile.d/nix.sh ]; then . /Users/andrewmcgoveran/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

[[ -f /opt/dev/sh/chruby/chruby.sh ]] && type chruby >/dev/null 2>&1 || chruby () { source /opt/dev/sh/chruby/chruby.sh; chruby "$@"; }

[[ -x /opt/homebrew/bin/brew ]] && eval $(/opt/homebrew/bin/brew shellenv)
