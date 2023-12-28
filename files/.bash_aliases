
RED="\e[31m"
END="\e[0m"
YELLOW="\[33m"

alias ifconfig='grc /usr/sbin/ifconfig'
alias dh='grc dh'
alias free='grc /usr/bin/free'
alias df='grc df -h'
alias nmap='grc nmap'
alias ping='grc ping'
if command -v grc &>/dev/null
then
    alias mount='/usr/bin/grc /usr/bin/mount'
    alias lsblk='/usr/bin/grc lsblk -o NAME,SIZE,TYPE,MOUNTPOINT,TRAN,LABEL'
fi

if  command -v lsd &> /dev/null
 then
   alias ls='lsd -lh --group-dirs=first'
else
   alias ls='ls -lh --color --group-directories-first'
 fi

if command -v bat &>/dev/null
then
    alias cat='/usr/bin/bat --style=plain'
fi

alias netstat='/usr/bin/grc /usr/bin/netstat'
alias grep='/usr/bin/grc /usr/bin/grep --color'
alias xcopy='xclip -sel clip'
alias untar='tar xvfz'
#alias top='gotop-cjbassi'
alias du='/usr/bin/grc /usr/bin/du'
export PATH="$PATH:/opt/impacket/examples:/home/daniel/.local/pipx/venvs/crackmapexec/bin/:/opt/johntools/"


alias www="python3 -m http.server"


#[[ ! -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] || source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

#[[ ! -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]] || source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh

#echo ${TERM}

# Fix Arrow Keys
if command -v bindkey &>/dev/null
then
case "${TERM}" in
  icons25*|linux) # plain BSD/Linux console
    bindkey '\e[H'    beginning-of-line   # home 
    bindkey '\e[F'    end-of-line         # end  
    bindkey '\e[5~'   delete-char         # delete
    bindkey '[D'      emacs-backward-word # esc left
    bindkey '[C'      emacs-forward-word  # esc right
    ;;
  *rxvt*) # rxvt derivatives
    bindkey '\e[3~'   delete-char         # delete
    bindkey '\eOc'    forward-word        # ctrl right
    bindkey '\eOd'    backward-word       # ctrl left
    # workaround for screen + urxvt
    bindkey '\e[7~'   beginning-of-line   # home
    bindkey '\e[8~'   end-of-line         # end
    bindkey '^[[1~'   beginning-of-line   # home
    bindkey '^[[4~'   end-of-line         # end
    ;;
  *xterm*) # xterm derivatives
#	  echo "xterm"
    bindkey '\e[H'    beginning-of-line   # home
    bindkey '\e[F'    end-of-line         # end
    bindkey '\e[3~'   delete-char         # delete
    bindkey '\e[1;5C' forward-word        # ctrl right
    bindkey '\e[1;5D' backward-word       # ctrl left
    # workaround for screen + xterm
    bindkey '\e[1~'   beginning-of-line   # home
    bindkey '\e[4~'   end-of-line         # end
    ;;
  screen)
#	  echo "screen"
    bindkey '^[[1~'   beginning-of-line   # home
    bindkey '^[[4~'   end-of-line         # end
    bindkey '\e[3~'   delete-char         # delete
    bindkey '\eOc'    forward-word        # ctrl right
    bindkey '\eOd'    backward-word       # ctrl left
    bindkey '^[[1;5C' forward-word        # ctrl right
    bindkey '^[[1;5D' backward-word       # ctrl left
    ;;
esac
fi
#bindkey '5D' backward-word
#bindkey '5C' forward-word

function rmk(){
  if command  -v scrub &>/dev/null; then
    scrub -p dod $1; shred -zun 10 -v $1
  else
    rm $1
  fi
}

function settarget(){
  if [ -f $1 ]; then
    echo "">$HOME/.config/.target
  else
    echo $1> $HOME/.config/.target
  fi

}

function help(){

    echo -e "\e[1;33m:join-pane -t <int>${END}: Move current tmux pane to new Window."
    echo -e "\e[1;33m^a d${END}: Detach tmux session."
    echo -e "\e[33mDetach tmux session and\e[1;33m tmux attach-session -t <session> -c <newpath> ${END}: Move current tmux pane to new Window."
    echo -e "\e[33mgetPorts <file>.nmap ${END}: Copy nmap scan ports to clipboard."
}

function mkt(){
	mkdir {content,nmap,scripts,smb,www}
}

function getPorts(){
	ports=$(cat $1 | grep -E "[0-9]{1,}/tcp" -o | tr -d '/tcp' | xargs | tr ' ' ',' )
	echo $ports | xclip -sel clip
	echo -e "\e[3;92m[+]\e[0m Ports \e[1;33m$ports \e[0mcopied to clipboard"
}

function setjdk11(){
  export PATH="/usr/lib/jvm/java-11-openjdk-amd64/bin:$PATH"
  java --version
}

# Set 'man' colors
if [ "$color_prompt" = yes ]; then
        man() {
        env \
        LESS_TERMCAP_mb=$'\e[01;31m' \
        LESS_TERMCAP_md=$'\e[01;31m' \
        LESS_TERMCAP_me=$'\e[0m' \
        LESS_TERMCAP_se=$'\e[0m' \
        LESS_TERMCAP_so=$'\e[01;44;33m' \
        LESS_TERMCAP_ue=$'\e[0m' \
        LESS_TERMCAP_us=$'\e[01;32m' \
        man "$@"
        }
fi


