
RED="\e[31m"
END="\e[0m"
YELLOW="\[33m"

if command -v grc &> /dev/null; then
    alias ifconfig='grc /usr/sbin/ifconfig'
    alias dh='grc dh'
    alias free='grc /usr/bin/free'
    alias df='grc df -h'
    alias nmap='grc nmap'
    alias ping='grc ping'
    alias colourify='grc -es'
    alias grep='colourify grep'
    alias egrep='colourify egrep'
    alias ss='colourify ss'
    alias ip='colourify ip'
    alias fgrep='colourify fgrep'
    alias diff='colourify diff'
    alias tail='colourify tail'
    alias dig='colourify dig'
    alias du='colourify du'
    alias traceroute='colourify traceroute'
    alias netstat='colourify netstat'
    alias make='colourify make'
fi

if  command -v lsd &> /dev/null
 then
   alias ls='lsd -lh --group-dirs=first'
else
   alias ls='ls -lh --color --group-directories-first'
 fi
if  command -v batcat &> /dev/null
 then
   alias cat='/usr/bin/batcat'
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

function activateenv(){
  source .venv/bin/activate
}

function nxc() {

   local tiene_log=false
    local saltar_validacion=false
    local args_limpios=()

    # 1. Primera pasada: Detectar si viene --nolog y limpiar los argumentos
    for arg in "$@"; do
        if [ "$arg" = "--nolog" ]; then
            saltar_validacion=true
        else
            # Guardamos todos los argumentos que NO sean --nolog
            args_limpios+=("$arg")
        fi
    done

    # 2. Si NO se pasó --nolog, hacemos la validación habitual
    if [ "$saltar_validacion" = false ]; then
        for arg in "${args_limpios[@]}"; do
            if [ "$arg" = "--log" ] || [ "$arg" = "--help" ] || [ "$arg" = "-L" ]; then
                tiene_log=true
                break
            fi
        done

        # Si no se encontró ningún parámetro válido de log/help, bloqueamos
        if [ "$tiene_log" = false ]; then
            echo -e "\e[31m[-] Error: Es obligatorio incluir el parámetro --log <archivo> para guardar la auditoría.\e[0m"
            echo -e "Uso correcto: nxc smb 10.10.10.100 \e[32m--log mi_log.txt\e[0m [otras_opciones]"
            echo -e "O puedes saltar esta regla usando: nxc smb 10.10.10.100 \e[33m--nolog\e[0m"
            return 1
        fi
    fi

    # 3. Ejecutamos pasándole únicamente los argumentos limpios
    command nxc "${args_limpios[@]}"
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




export LS_COLORS="di=38;5;33:ow=01;31:st=01;31:fi=38;5;154:ln=38;5;14:ex=01;32"
