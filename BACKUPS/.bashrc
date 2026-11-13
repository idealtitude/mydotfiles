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

#PS1='\w \$: '
#PS1='\[\e[38;5;227m\]\w\[\e[0m\] \[\e[38;5;158m\]\$\[\e[0m\]: '
PS1='\[\e[38;5;227m\]\w\[\e[0m\] \[\e[38;5;122m\]\$\[\e[0m\]: '

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

# Micro themes
export "MICRO_TRUECOLOR=1"

export GPG_TTY=$(tty)
. "$HOME/.cargo/env"

# Gemini CLI API key
export GEMINI_API_KEY=""

# translate-shell functions
trfh() {
    trans -b -p fr:he "$1" | fribidi
}

trhf() {
    trans -b -p he:fr "$1" | fribidi
}

treh() {
    trans -b -p en:he "$1" | fribidi
}

trhe() {
    trans -b -p he:en "$1" | fribidi
}

# Mode dictionnaire complet (Français -> Hébreu) avec gestion RTL
hedic() {
    TERM=dumb trans :he "$1" | fribidi
}

# Mode dictionnaire complet (Hébreu -> Français) avec gestion RTL
frdic() {
    TERM=dumb trans he:fr "$1" | fribidi
}

# cppreference local doc
cppdoc() {
    # 1. Chemin système POSIX pur (SANS 'file://')
    local doc_dir="/home/stephane/Dev/RES/DOCUMENTATIONS/CPP/cppreference/reference/en/cpp"

    # Vérification que le dossier existe bien
    if [ ! -d "$doc_dir" ]; then
        echo "Erreur : Le dossier $doc_dir n'existe pas."
        return 1
    fi

    # 2. Recherche du fichier HTML correspondant
    local file
    file=$(find "$doc_dir" -type f -name "*$1*.html" | head -n 1)

    # 3. Ouverture avec Lynx
    if [ -n "$file" ]; then
        lynx "$file"
    else
        echo "cppdoc : Aucune page trouvée pour $1"
    fi
}

cdoc() {
    # 1. Chemin système POSIX pur (SANS 'file://')
    local doc_dir="/home/stephane/Dev/RES/DOCUMENTATIONS/CPP/cppreference/reference/en/c"

    # Vérification que le dossier existe bien
    if [ ! -d "$doc_dir" ]; then
        echo "Erreur : Le dossier $doc_dir n'existe pas."
        return 1
    fi

    # 2. Recherche du fichier HTML correspondant
    local file
    file=$(find "$doc_dir" -type f -name "*$1*.html" | head -n 1)

    # 3. Ouverture avec Lynx
    if [ -n "$file" ]; then
        lynx "$file"
    else
        echo "cppdoc : Aucune page trouvée pour $1"
    fi
}


# source /home/stephane/.config/broot/launcher/bash/br

# Init ssh agent
init_ssh_agent() {
    eval "$(ssh-agent -s)"
    ssh-add ~/.ssh/id_ed25519
}

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
initialize_conda() {
    __conda_setup="$('/home/stephane/miniforge3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "/home/stephane/miniforge3/etc/profile.d/conda.sh" ]; then
            . "/home/stephane/miniforge3/etc/profile.d/conda.sh"
        else
            export PATH="/home/stephane/miniforge3/bin:$PATH"
        fi
    fi
    unset __conda_setup
    # <<< conda initialize <<<


    # >>> mamba initialize >>>
    # !! Contents within this block are managed by 'mamba shell init' !!
    export MAMBA_EXE='/home/stephane/miniforge3/bin/mamba';
    export MAMBA_ROOT_PREFIX='/home/stephane/miniforge3';
    __mamba_setup="$("$MAMBA_EXE" shell hook --shell bash --root-prefix "$MAMBA_ROOT_PREFIX" 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__mamba_setup"
    else
        alias mamba="$MAMBA_EXE"  # Fallback on help from mamba activate
    fi
    unset __mamba_setup
}
# <<< mamba initialize <<<
