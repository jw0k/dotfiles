# The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle :compinstall filename '/home/mainuser/.zshrc'

umask 077

#if [ -n "$DESKTOP_SESSION" ]; then
    #eval $(gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
    #export SSH_AUTH_SOCK
#fi

#export PATH="/usr/lib/ccache/bin:$PATH"
export PATH="$PATH:/home/mainuser/scripts"
export LESS=-j.5R

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

TERMTITLE="<tt> </tt><span foreground='#ffe373'></span><tt> </tt>"
autoload -U add-zsh-hook
add-zsh-hook -Uz chpwd (){ i3-msg -q title_format `pwd` }
add-zsh-hook -Uz preexec (){
    local TITLE="$TERMTITLE$(pwd) → $1"
    local TITLE_ESCAPED=$(echo $TITLE | sed 's/"/\\"/g')
    i3-msg -q 'title_format "'"$TITLE_ESCAPED"'"' 2>/dev/null
}
add-zsh-hook -Uz precmd (){
    local WINDOWID=$(xdotool search --pid $PPID)
    i3-msg -q '[id="'"$WINDOWID"'"] title_format "'"$TERMTITLE$(pwd)"'"' 2>/dev/null
}
i3-msg -q title_format "$TERMTITLE`pwd`"

#for_window [class="(.*)Alacritty(.*)"] title_format "<tt> </tt><span foreground='#ffaa22'></span><tt> </tt>%title"

export EDITOR=/usr/bin/nvim

alias ls='ls --color=auto'
alias l='ls -alh'
alias ll='ls -lh'
alias sudo='sudo '
alias tstat='turbostat -q --interval 1 --show Core,CPU,Avg_MHz,Busy%,Bzy_MHz,TSC_MHz,CoreTmp,PkgTmp,GFXMHz,PkgWatt,CorWatt,GFXWatt,RAMWatt'
alias pacmy='comm -23 <(pacman -Qqett | sort) <(pacman -Qq -g base -g base-devel | sort | uniq)'
alias d='du --max-depth=0 -h'
alias i3c='$EDITOR ~/.config/i3/config'
alias nvmetemp='smartctl /dev/nvme0n1 -a | grep "Temperature Sensor"'
alias r='ranger'
alias sr='sudo -E ranger'
alias zshc='$EDITOR ~/.zshrc'
alias vimc='$EDITOR ~/.vimrc'
alias n='nvim'
alias sn='sudo -E nvim'
alias images_all='find "$(pwd)" -type f -exec file {} \; | awk -F: '\''{if ($2 ~/image/) print $1}'\'' | sxiv -i'
alias images_jpg='find "$(pwd)" -type f -iname '\''*.jpg'\'' | sxiv -i'
alias pf='sudo power_full.sh'
alias pn='sudo power_normal.sh'
alias dgit='git --git-dir=$HOME/.mydotfiles/ --work-tree=/'
alias sdgit='sudo -E git --git-dir=$HOME/.mydotfiles/ --work-tree=/'
alias not='nvim $HOME/notatki.txt'
alias x='echo $(fc -ln -1) | xclip -r -selection clipboard'
alias xo='$(fc -ln -1) | xclip -r -selection clipboard'
alias hiber='i3lock --image $HOME/lock_screen.png ; systemctl hibernate'
