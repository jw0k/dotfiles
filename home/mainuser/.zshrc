# The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle :compinstall filename '/home/mainuser/.zshrc'

#umask 077

#if [ -n "$DESKTOP_SESSION" ]; then
    #eval $(gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
    #export SSH_AUTH_SOCK
#fi

#export PATH="/usr/lib/ccache/bin:$PATH"
export PATH="$PATH:/home/mainuser/scripts:/home/jacek/.local/bin:/home/mainuser/pscripts"
export LESS=-j.5R-i
export PROMPT_COMMAND="pwd > /tmp/whereami"
[ -f /tmp/whereami ] && cd "$(cat /tmp/whereami)"

export FZF_DEFAULT_COMMAND='find .'
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

eval $(thefuck --alias)

autoload -Uz compinit
compinit
autoload -U promptinit
promptinit
prompt spaceship

autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
[[ -n "\033[A" ]] && bindkey -- "\033[A" up-line-or-beginning-search # up arrow
[[ -n "\033[B" ]] && bindkey -- "\033[B" down-line-or-beginning-search # down arrow
bindkey -- "^P" up-line-or-beginning-search # ctrl+p
bindkey -- "^N" down-line-or-beginning-search # ctrl+n

export SPACESHIP_PROMPT_SEPARATE_LINE=false
export SPACESHIP_EXEC_TIME_SHOW=false

# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000000
SAVEHIST=10000000
setopt EXTENDED_HISTORY
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
bindkey -e
# End of lines configured by zsh-newuser-install

# use `sed -n l` to find out ansi escape codes
bindkey "\033[H" beginning-of-line # home key
bindkey "\033[F" end-of-line # end key
bindkey "\033[3~" delete-char # delete key
bindkey "\033[1;5D" backward-word # ctrl+left
bindkey "\033[1;5C" forward-word # ctrl+right

source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
stty -ixon -ixoff

#TERMTITLE="<tt> </tt><span foreground='#ffe373'></span><tt> </tt>"
TERMTITLE="⌨️  "
WINDOWID=""
autoload -U add-zsh-hook
add-zsh-hook -Uz chpwd (){
    #i3-msg -q title_format `echo ${PWD/#$HOME/'~'}`
    xdotool set_window --name "$(echo ${PWD/#$HOME/'~'})" "$WINDOWID"
}
add-zsh-hook -Uz preexec (){
    local TITLE="$TERMTITLE$(echo ${PWD/#$HOME/'~'}) → $1"
    local TITLE_ESCAPED=$(echo $TITLE | sed 's/"/\\"/g')
    #i3-msg -q 'title_format "'"$TITLE_ESCAPED"'"' 2>/dev/null
    WINDOWID=$(xdotool getactivewindow)
    xdotool set_window --name "$TITLE" "$WINDOWID"
}
add-zsh-hook -Uz precmd (){
    #local WINDOWID=$(xdotool search --pid $PPID)
    #i3-msg -q '[id="'"$WINDOWID"'"] title_format "'"$TERMTITLE$(echo ${PWD/#$HOME/'~'})"'"' 2>/dev/null
    [ ! -z "$WINDOWID" ] && \
        xdotool set_window --name "$TERMTITLE$(echo ${PWD/#$HOME/'~'})" "$WINDOWID"
    #i3-msg -q 'title_format "'"$TERMTITLE$(pwd)"'"'

    eval "$PROMPT_COMMAND"
}
#i3-msg -q title_format "$TERMTITLE`echo ${PWD/#$HOME/'~'}`"
xdotool getactivewindow set_window --name "$TERMTITLE$(echo ${PWD/#$HOME/'~'})"

#for_window [class="(.*)Alacritty(.*)"] title_format "<tt> </tt><span foreground='#ffaa22'></span><tt> </tt>%title"

export EDITOR=/usr/bin/nvim

if [ -f $HOME/.aliases ]; then
    source $HOME/.aliases
fi

if [ -f $HOME/.functions ]; then
    source $HOME/.functions
fi

# Workaround for a bug in systemd 245 regarding tab-completion in zsh. Should be fixed in systemd 246.
# Remove this workaround when systemd 246 is released and available in Arch.
_systemctl_unit_state() {
  typeset -gA _sys_unit_state
  _sys_unit_state=( $(__systemctl list-unit-files "$PREFIX*" | awk '{print $1, $2}') )
}
