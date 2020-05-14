# The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle :compinstall filename '/home/mainuser/.zshrc'

#umask 077

#if [ -n "$DESKTOP_SESSION" ]; then
    #eval $(gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
    #export SSH_AUTH_SOCK
#fi

#export PATH="/usr/lib/ccache/bin:$PATH"
export PATH="$PATH:/home/mainuser/scripts:/home/jacek/.local/bin"
export LESS=-j.5R
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
[[ -n "\033[A" ]] && bindkey -- "\033[A" up-line-or-beginning-search
[[ -n "\033[B" ]] && bindkey -- "\033[B" down-line-or-beginning-search

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

bindkey "\033[H" beginning-of-line
bindkey "\033[F" end-of-line
bindkey "\033[3~" delete-char
bindkey "\033[1;5D" backward-word
bindkey "\033[1;5C" forward-word

source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
stty -ixon -ixoff

#TERMTITLE="<tt> </tt><span foreground='#ffe373'></span><tt> </tt>"
TERMTITLE="⌨️  "
autoload -U add-zsh-hook
add-zsh-hook -Uz chpwd (){ i3-msg -q title_format `pwd` }
add-zsh-hook -Uz preexec (){
    local TITLE="$TERMTITLE$(pwd) → $1"
    local TITLE_ESCAPED=$(echo $TITLE | sed 's/"/\\"/g')
    i3-msg -q 'title_format "'"$TITLE_ESCAPED"'"' 2>/dev/null
}
add-zsh-hook -Uz precmd (){
    #local WINDOWID=$(xdotool search --pid $PPID)
    #i3-msg -q '[id="'"$WINDOWID"'"] title_format "'"$TERMTITLE$(pwd)"'"' 2>/dev/null
    i3-msg -q 'title_format "'"$TERMTITLE$(pwd)"'"'

    eval "$PROMPT_COMMAND"
}
i3-msg -q title_format "$TERMTITLE`pwd`"

#for_window [class="(.*)Alacritty(.*)"] title_format "<tt> </tt><span foreground='#ffaa22'></span><tt> </tt>%title"

export EDITOR=/usr/bin/nvim

if [ -f $HOME/.aliases ]; then
    source $HOME/.aliases
fi

if [ -f $HOME/.functions ]; then
    source $HOME/.functions
fi
