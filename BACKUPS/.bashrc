# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi

export PATH

# Does not work...
# if [[ $EUID -eq 0 ]]; then
    # export PS1='(\[\e[38;5;154m\]\w\[\e[0m\] \[\e[38;5;208m\]#\[\e[0m\]) \[\e[38;5;121m\]\t\n\[\e[0m\]% '
# else
    # export PS1='(\[\e[38;5;39m\]\W\[\e[0m\] \[\e[38;5;214m\]\$\[\e[0m\]) \[\e[38;5;212m\]\t\[\e[0m\]\n% '
# fi

# export PS1='(\[\e[38;5;39m\]\W\[\e[0m\] \[\e[38;5;214m\]\$\[\e[0m\]) \[\e[38;5;212m\]\t\[\e[0m\]\n% '
# export PS1='╭(\[\e[38;5;39m\]\w\[\e[0m\] [\[\e[38;5;226m\]\$\[\e[0m\]]) ─ \[\e[38;5;247m\]\t\n\[\e[0m\]╰> '

# Adding git infos o the prompt
# Fonction pour parser le statut Git
# parse_git_branch_and_status() {
  # # Vérifie si on est dans un dépôt Git
  # if git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
    # # Récupère le nom de la branche
    # local branch
    # branch=$(git symbolic-ref --short HEAD 2>/dev/null)
    # if [ -z "$branch" ]; then # Si HEAD est détaché (par exemple, après un checkout de tag ou de commit)
      # branch="detached@$(git rev-parse --short HEAD)"
    # fi
#
    # local status=""
    # local dirty=""
    # local ahead_behind=""
#
    # # Vérifie les modifications (fichiers modifiés, non indexés, etc.)
    # if ! git diff --quiet --ignore-submodules HEAD &>/dev/null; then
      # dirty="*"
    # fi
#
    # # Vérifie les fichiers "staged" (prêts pour le commit)
    # if ! git diff --cached --quiet --ignore-submodules HEAD &>/dev/null; then
      # dirty+="+"
    # fi
#
    # # Vérifie les fichiers non suivis
    # if [ -n "$(git ls-files --others --exclude-standard)" ]; then
      # dirty+="?"
    # fi
#
    # # Vérifie si la branche locale est en avance/retard par rapport à la branche distante
    # local remote_name
    # remote_name=$(git config branch.$branch.remote)
    # if [ -n "$remote_name" ]; then
        # local merge_name
        # merge_name=$(git config branch.$branch.merge)
        # if [ -n "$merge_name" ]; then
            # local ahead
            # ahead=$(git rev-list --left-right --count $remote_name/${branch}...HEAD | cut -f2)
            # local behind
            # behind=$(git rev-list --left-right --count $remote_name/${branch}...HEAD | cut -f1)
            # if [ "$ahead" -gt 0 ]; then
                # ahead_behind+="↑$ahead"
            # fi
            # if [ "$behind" -gt 0 ]; then
                # ahead_behind+="↓$behind"
            # fi
        # fi
    # fi
#
    # if [ -n "$dirty" ] || [ -n "$ahead_behind" ]; then
      # status=" ($branch$dirty$ahead_behind)"
    # else
      # status=" ($branch)"
    # fi
    # echo -e "\033[38;5;11m$status\033[0m"
  # else
    # echo ""
  # fi
# }

parse_git_branch_and_status() {
  if git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
    local branch
    local actual_local_branch_name
    local dirty
    local ahead_behind
    local status_text
    local color_code

    branch=$(git symbolic-ref --short HEAD 2>/dev/null)
    if [ -z "$branch" ]; then
      branch="detached@$(git rev-parse --short HEAD)"
      actual_local_branch_name=""
    else
      actual_local_branch_name="$branch"
    fi

    dirty=""
    ahead_behind=""

    if ! git diff --quiet --ignore-submodules=dirty HEAD &>/dev/null; then
      dirty="*"
    fi

    if ! git diff --cached --quiet --ignore-submodules HEAD &>/dev/null; then
      dirty+="+"
    fi

    if [ -n "$(git ls-files --others --exclude-standard)" ]; then
      dirty+="?"
    fi

    if [ -n "$actual_local_branch_name" ]; then
        local remote_name
        local merge_ref
        local remote_tracking_branch_name

        remote_name=$(git config branch.$actual_local_branch_name.remote)
        merge_ref=$(git config branch.$actual_local_branch_name.merge)

        if [ -n "$remote_name" ] && [ -n "$merge_ref" ]; then
            remote_tracking_branch_name=${merge_ref#refs/heads/}

            if git show-ref --verify --quiet "refs/remotes/$remote_name/$remote_tracking_branch_name"; then
                local ahead
                local behind

                ahead=$(git rev-list --left-right --count "$remote_name/$remote_tracking_branch_name...HEAD" | cut -f2)
                behind=$(git rev-list --left-right --count "$remote_name/$remote_tracking_branch_name...HEAD" | cut -f1)

                if [ "$ahead" -gt 0 ]; then
                    ahead_behind+="↑$ahead"
                fi
                if [ "$behind" -gt 0 ]; then
                    ahead_behind+="↓$behind"
                fi
            fi
        fi
    fi

    if [ -n "$dirty" ] || [ -n "$ahead_behind" ]; then
      status_text=" ($branch$dirty$ahead_behind)"
    else
      status_text=" ($branch)"
    fi

    if [[ "$dirty" == *"+"* ]]; then
      color_code="\033[38;5;202m"
    elif [[ -n "$dirty" ]]; then
      color_code="\033[38;5;220m"
    elif [[ -n "$ahead_behind" ]]; then
      color_code="\033[38;5;75m"
    else
      color_code="\033[38;5;76m"
    fi

    echo -e "${color_code}${status_text}\033[0m"
  else
    echo ""
  fi
}
export PS1='╭(\[\e[38;5;39m\]\w\[\e[0m\] \[\e[38;5;247m\][\[\e[38;5;226m\]\$\[\e[38;5;247m\]]\[\e[0m\]) \[\e[38;5;247m\]\t\[\e[0m\] \[$(parse_git_branch_and_status)\]\n╰% '

# My personnal logs path
export MYLOGS='/home/stephane/Utils/logs'

# HISTORY
export HISTTIMEFORMAT="%Y-%m-%d %H:%M:%S "
export HISTCONTROL=ignoredups:erasedups:ignorespace
export HISTSIZE=2000
export HISTFILESIZE=2000
shopt -s histappend

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
 ²           . "$rc"
        fi
    done
fi
unset rc

### zoxide + eza + fzf config
# eval "$(zoxide init bash)"
eval "$(zoxide init bash --cmd z)"

# export FZF_DEFAULT_OPTS="
# Define _ZO_FZF_OPTS as an array
_ZO_FZF_OPTS=(
  --height 100%
  --reverse
  --border
  --preview 'eza --tree --color=always --level=2 {} 2>/dev/null'
)

function zoxide_fzf() {
  local selected
  selected=$(zoxide query --list | fzf "${_ZO_FZF_OPTS[@]}") && cd "$selected"
}

# Alt+Z to launch zoxide + fzf
bind '"\ez":"zoxide_fzf\n"'

# Rust
#
# Set English as preferred language in the terminal, then French
export LANGUAGE=en_US.UTF-8:fr_FR.UTF-8

# Set path for node and npm
export PATH="$HOME/.npm-packages/bin:$PATH"
# Python uv autocompletion
eval "$(uv generate-shell-completion bash)"
# Rust Cargo
. "$HOME/.cargo/env"
