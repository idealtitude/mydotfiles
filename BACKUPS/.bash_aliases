# Personnel UpdateDB
alias plocup='updatedb -l 0 -o /home/stephane/.hlocate/hlocate.db -U /home/stephane'
# Personnel Locate
alias ploc='locate -d /home/stephane/.hlocate/hlocate.db'

alias sul='su -l'

# Clear screen (short version)
alias c='clear'
# Reset screen
alias r='reset'

# Calendar, first day of the week is sunday
alias cal='cal -s'

# exa commande
alias l="eza -g --group-directories-first"
alias ll="eza -lg --group-directories-first"
alias la="eza -ag --group-directories-first"
alias lla="eza -lag --group-directories-first"
# eza full (quite)
alias lf="eza -lghumUaob --color-scale all --color-scale-mode gradient --icons=always --group-directories-first"

# Copy/Paste
alias cxsel='xsel -b -i'
alias pxsel='xsel -b -o'

# stat shortcuts
alias stata='stat -c "%a"'
alias stataa='stat -c "%A %a %n"'
alias stataz='stat -c "%a %C"'

## DEV
# micro
alias mi="micro"
# Wasm
alias init-emsdk="source /home/stephane/Dev/emsdk/emsdk_env.sh"

# Git aliases
alias gits='git status'
alias gita='git add .'
alias gitco='git commit -m'
alias gitt='git tag'
alias gitl='git log --oneline'
# Git session cache
alias gitcache="git config --global credential.helper 'cache --timeout=3600'"

# Random wallpapers
# alias chwp='feh --recursive --bg-max --randomize ~/Images/WALLPAPERS_00/'

# Make a screenshot
alias screenshot='maim --select -s'

# Date now YYYY-MM-DD HH:MM:SS
alias dnow='date +"%Y-%m-%d %H:%M:%S"'

# Put cwd in clipboard
alias gcwd='printf "%s" "$(pwd)" | xsel -b -i'

# Ranger, cd on exit (requires file “~/.rangerdir”)
alias rr='ranger'
alias rrr='ranger --choosedir=$HOME/.rangerdir; LASTDIR=`cat $HOME/.rangerdir`; cd "$LASTDIR"'

# Play medias
alias play="ffplay -nodisp -autoexit"
alias dplay="ffplay -hide_banner --showmode 2 -autoexit"

# Radio
alias radio-shalom='mpv Music/Playlist/radio_shalom.m3u'

# ed setup
alias edp='ed -p"% "'

# Quick python server
alias pyserv="python -m http.server 8000"
# Quick php server
alias phpserv="php -S localhost:8000"

# Jupyter Notebook
alias jupynb='jupyter notebook'

# Restrict Wacom to monitor 2
alias xsw='xsetwacom set "Wacom Intuos S Pen stylus" MapToOutput HDMI-1'
