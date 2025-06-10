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

# Git indicator for PS1, branch + status
# parse_git_branch_and_status() {
  # if git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
    # local branch
    # local actual_local_branch_name
    # local dirty
    # local ahead_behind
    # local status_text
    # local color_code
#
    # branch=$(git symbolic-ref --short HEAD 2>/dev/null)
    # if [ -z "$branch" ]; then
      # branch="detached@$(git rev-parse --short HEAD)"
      # actual_local_branch_name=""
    # else
      # actual_local_branch_name="$branch"
    # fi
#
    # dirty=""
    # ahead_behind=""
#
    # if ! git diff --quiet --ignore-submodules=dirty HEAD &>/dev/null; then
      # dirty="*"
    # fi
#
    # if ! git diff --cached --quiet --ignore-submodules HEAD &>/dev/null; then
      # dirty+="+"
    # fi
#
    # if [ -n "$(git ls-files --others --exclude-standard)" ]; then
      # dirty+="?"
    # fi
#
    # if [ -n "$actual_local_branch_name" ]; then
        # local remote_name
        # local merge_ref
        # local remote_tracking_branch_name
#
        # remote_name=$(git config branch.$actual_local_branch_name.remote)
        # merge_ref=$(git config branch.$actual_local_branch_name.merge)
#
        # if [ -n "$remote_name" ] && [ -n "$merge_ref" ]; then
            # remote_tracking_branch_name=${merge_ref#refs/heads/}
#
            # if git show-ref --verify --quiet "refs/remotes/$remote_name/$remote_tracking_branch_name"; then
                # local ahead
                # local behind
#
                # ahead=$(git rev-list --left-right --count "$remote_name/$remote_tracking_branch_name...HEAD" | cut -f2)
                # behind=$(git rev-list --left-right --count "$remote_name/$remote_tracking_branch_name...HEAD" | cut -f1)
#
                # if [ "$ahead" -gt 0 ]; then
                    # ahead_behind+="↑$ahead"
                # fi
                # if [ "$behind" -gt 0 ]; then
                    # ahead_behind+="↓$behind"
                # fi
            # fi
        # fi
    # fi
#
    # if [ -n "$dirty" ] || [ -n "$ahead_behind" ]; then
      # status_text=" ($branch$dirty$ahead_behind)"
    # else
      # status_text=" ($branch)"
    # fi
#
    # if [[ "$dirty" == *"+"* ]]; then
      # color_code="\033[38;5;202m"
    # elif [[ -n "$dirty" ]]; then
      # color_code="\033[38;5;220m"
    # elif [[ -n "$ahead_behind" ]]; then
      # color_code="\033[38;5;75m"
    # else
      # color_code="\033[38;5;76m"
    # fi
#
    # echo -e "${color_code}${status_text}\033[0m"
  # else
    # echo ""
  # fi
# }
#
function is_subshell(){
    # test_forest=$(ps --forest | wc -l)
    getdepth=$(pstree -s $$ | sed -r 's/-+/\n/g' | grep -Ec '(bash|sh)')
    depth=$(( "$getdepth" - 2 ))

    # if [[ "$test_forest" -gt 4 && "$depth" -gt 1 ]]; then
    if [[ "$depth" -gt 1 ]]; then
        subsh="subshell"
    else
        subsh=''
    fi

    [[ -n "$subsh" ]] && printf "\e[38;5;119m(%s)\e[0m " "$subsh"
}

# # Virtual env custom prompt
# function virtualenv_info(){
    # # Get Virtual Env
    # if [[ -n "$VIRTUAL_ENV" ]]; then
        # # Strip out the path and just leave the env name
        # venv="${VIRTUAL_ENV##*/}"
    # else
        # venv=''
    # fi
    # [[ -n "$venv" ]] && printf "\e[38;5;214m(%s)\e[0m " "$venv"
# }
# # disable the default virtualenv prompt change
# export VIRTUAL_ENV_DISABLE_PROMPT=1

# My PS1
# export PS1='╭($(virtualenv_info)$(is_subshell)\[\e[38;5;39m\]\w\[\e[0m\] \[\e[38;5;247m\][\[\e[38;5;226m\]\$\[\e[38;5;247m\]]\[\e[0m\]) \[\e[38;5;247m\]\t\[\e[0m\]\[$(parse_git_branch_and_status)\]\n╰% '
export PS1='╭($(is_subshell)\[\e[38;5;39m\]\w\[\e[0m\] \[\e[38;5;247m\][\[\e[38;5;226m\]\$\[\e[38;5;247m\]]\[\e[0m\]) \[\e[38;5;247m\]\t\[\e[0m\]\n╰% '

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

# Set English as preferred language in the terminal, then French
export LANGUAGE=en_US.UTF-8:fr_FR.UTF-8

# Set path for node and npm
export PATH="$HOME/.npm-packages/bin:$PATH"

# Python uv autocompletion
eval "$(uv generate-shell-completion bash)"

# Rust Cargo
. "$HOME/.cargo/env"

# Micro themes
export "MICRO_TRUECOLOR=1"

export GPG_TTY=$(tty)
