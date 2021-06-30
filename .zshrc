autoload -U compinit
compinit

PROMPT='%~ %# '

# fancy_dir () {
#   echo -en "%F{cyan}%-55<…<%~%<<%f"
#   return
# }

# autoload -Uz promptinit; 

# promptinit

# # PROMPT = '$(fancy_dir) $(git_dot)$(chevrons) '
# PROMPT = '$(fancy_dir) '


alias amend='git commit --amend --no-edit'

[ -f /opt/dev/dev.sh ] && source /opt/dev/dev.sh
if [ -e /Users/andrewmcgoveran/.nix-profile/etc/profile.d/nix.sh ]; then . /Users/andrewmcgoveran/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
