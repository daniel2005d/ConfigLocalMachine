
export PATH=~/.local/bin:/snap/bin:/usr/sandbox/:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games:/usr/share/games:/usr/local/sbin:/usr/sbin:/sbin:$PATH

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	    color_prompt=yes
    else
	    color_prompt=
    fi
fi




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

unset color_prompt force_color_prompt



# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -lh'
alias la='ls -lha'
alias l='ls -CF'
alias em='emacs -nw'
alias dd='dd status=progress'
alias _='sudo'
alias _i='sudo -i'
alias ls='ls -lh --group-directories-first --color'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi


distro_icon() {
    local distro icon
    if [ -f /etc/os-release ]; then
        # Leer información de /etc/os-release
        . /etc/os-release
        
        name=$NAME
        case "$name" in
            Parrot*)
                distro="parrot"
                ;;
            *)
                distro=$ID
                ;;
        esac


        
    elif [ -f /etc/lsb-release ]; then
        . /etc/lsb-release
        distro=$DISTRIB_ID
    elif [ -f /etc/debian_version ]; then
        distro="debian"
    elif [ -f /etc/redhat-release ]; then
        distro="redhat"
    else
        distro="unknown"
    fi
    
    
    # Determinar el icono según la distribución
    case "$distro" in
        ubuntu)
            icon="󰕈"  # Icono para Ubuntu
            ;;
        debian)
            icon=""  # Icono para Debian
            ;;
        arch)
            icon="󰣇"  # Icono para Arch Linux
            ;;
        fedora)
            icon=""  # Icono para Fedora
            ;;
        centos)
            icon=""  # Icono para CentOS
            ;;
        redhat)
            icon=""  # Icono para Red Hat
            ;;
        opensuse)
            icon=""  # Icono para openSUSE
            ;;
        manjaro)
            icon=""  # Icono para Manjaro
            ;;
        kali)
            icon=""  # Icono para Kali Linux
            ;;
        parrot)
            icon=""
            ;;
        unknown)
            icon=""  # Icono para distribuciones desconocidas
            ;;
        *)
            icon=""  # Icono por defecto
            ;;
    esac

	echo -e "\[\e[93m\]$icon\[\e[0m\] "

}


# Store the last directory in a variable
export LAST_DIR="$PWD"

get_ip(){
  if command -v route &>/dev/null
  then
    iface=$(route -n  | grep -E "^0.0.0.0" | awk '{print $8}' | head -n 1)
    ip=$(/usr/sbin/ifconfig $iface 2>/dev/null| grep "inet " -m 1| awk '{print $2}') 2>/dev/null
    if [[ -n $ip ]]; then
      echo -e "$ip"
    fi
  fi

}


check_ssh(){
    

	if [[ -n "$SSH_CONNECTION" ]]; then
  	       PS1="\[\e[97m\][$(get_ip)] \[\e[38;5;39m\]\u\[\e[38;5;81m\]@\[\e[38;5;77m\]\h \[\e[38;5;226m\]\w \[\033[0m\]$ "
	else
            ip="$(get_ip)"
            icon="$(distro_icon)"
            PS1="\[\e[38;5;196m\]\u\[\e[38;5;202m\]@$ip \[\e[38;5;154m\]\w\n\342\224\224\342\224\200\342\224\200\342\225\274 $icon"
	fi

}


set_ps1(){
    case "$TERM" in
    xterm*|rxvt*)
	 #   PS1="\[\033[0;31m\]\342\224\214\342\224\200\$([[ \$? != 0 ]] && echo \"[\[\033[0;31m\]\342\234\227\[\033[0;37m\]]\342\224\200\")[$(if [[ ${EUID} == 0 ]]; then echo '\[\033[01;31m\]root\[\033[01;33m\]@\[\033[01;96m\]$(get_ip)'; else echo '\[\033[0;39m\]\u\[\033[01;33m\]󱌖 \[\033[01;96m\]$(get_ip)'; fi)\[\033[0;31m\]]\342\224\200$(check_ssh)[\[\033[0;32m\]\w\[\033[0;31m\]]\n\[\033[0;31m\]\342\224\224\342\224\200\342\224\200\342\225\274\[\033[0m\]\[\e[01;97m\] \[\e[0m\]"
        ;;
    *)
        ;;
    esac

}

telefonicabash(){
  export PS1=" \[\e[38;5;33m\]🌐 \[\033[0m\] "
}

resetbash(){
  check_ssh
}


check_ssh
#set_ps1



export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
 eval "$(pyenv init --path)"
fi


export LS_COLORS="di=38;5;33:ow=01;31:st=01;31:fi=38;5;154:ln=38;5;14:ex=01;32"


# Función para crear o retomar un "workspace"
addworkspace() {
    local wsname="$1"

    if [[ -z "$wsname" ]]; then
        echo "❌ Debes indicar un nombre de workspace"
        echo "Uso: addworkspace NOMBRE"
        return 1
    fi

    # Carpeta donde se guardarán los workspaces
    local wsdir="$PWD/.workspaces"
    mkdir -p "$wsdir"

    local logfile="$wsdir/${wsname}.log"
    local metafile="$wsdir/${wsname}.meta"

    if [[ -f "$logfile" ]]; then
        # Ya existe, recuperar metadata
        if [[ -f "$metafile" ]]; then
            local created_at
            created_at=$(cat "$metafile")
            echo "ℹ️ Workspace '$wsname' ya existe (creado el $created_at)."
        else
            echo "ℹ️ Workspace '$wsname' ya existe."
        fi
        echo "🔄 Continuando sesión, almacenando en: $logfile"
    else
        # Crear nuevo workspace
        date "+%Y-%m-%d %H:%M:%S" > "$metafile"
        echo "🆕 Workspace '$wsname' creado el $(cat "$metafile")"
        echo "📂 Guardando en: $logfile"
    fi

    # Ejecutar una subshell con registro
    script -a -f -q "$logfile"
}


# Función para listar los workspaces disponibles
listworkspaces() {
    local wsdir="$PWD/.workspaces"

    if [[ ! -d "$wsdir" ]]; then
        echo "❌ No hay ningún workspace creado todavía."
        return 1
    fi

    echo "📋 Lista de workspaces:"
    echo "--------------------------------------------"
    for metafile in "$wsdir"/*.meta; do
        # Si no hay ninguno, salir
        [[ -e "$metafile" ]] || { echo "⚠️ No se encontraron workspaces."; return 0; }

        local wsname
        wsname=$(basename "$metafile" .meta)
        local created_at
        created_at=$(cat "$metafile")
        local logfile="$wsdir/${wsname}.log"

        printf "📂 %-20s | Creado: %-20s | Log: %s\n" "$wsname" "$created_at" "$logfile"
    done
    echo "--------------------------------------------"
}


addworkspace_tmux() {
    local wsname="$1"

    if [[ -z "$wsname" ]]; then
        echo "❌ Debes indicar un nombre de workspace"
        echo "Uso: addworkspace_tmux NOMBRE"
        return 1
    fi

    # Carpeta donde se guardarán los workspaces
    local wsdir="$PWD/.workspaces"
    mkdir -p "$wsdir"

    local metafile="$wsdir/${wsname}.meta"

    if [[ -d "$wsdir/$wsname" ]]; then
        if [[ -f "$metafile" ]]; then
            local created_at
            created_at=$(cat "$metafile")
            echo "ℹ️ Workspace '$wsname' ya existe (creado el $created_at)."
        else
            echo "ℹ️ Workspace '$wsname' ya existe."
        fi
    else
        mkdir -p "$wsdir/$wsname"
        date "+%Y-%m-%d %H:%M:%S" > "$metafile"
        echo "🆕 Workspace '$wsname' creado el $(cat "$metafile")"
    fi

    echo "📂 Logs en: $wsdir/$wsname/"

    # Crear nueva sesión tmux si no existe
    if ! tmux has-session -t "$wsname" 2>/dev/null; then
        tmux new-session -d -s "$wsname"
    fi

    # Configurar logging de cada pane con timestamp
    for p in $(tmux list-panes -a -t "$wsname" -F "#{session_name}:#{window_index}.#{pane_index}"); do
        logfile="$wsdir/$wsname/${p}.out.log"
        tmux pipe-pane -o -t "$p" "ts '[%Y-%m-%d %H:%M:%S] ' >> $logfile"
        echo "   - Pane $p loggeado en $logfile"
    done

    # Configurar que cada bash dentro de tmux guarde comandos con timestamp
    # Esto se inyecta como variable de entorno al crear nuevos panes/ventanas
    tmux set-environment -t "$wsname" HISTFILE "$wsdir/$wsname/${wsname}.cmd.log"
    tmux set-environment -t "$wsname" HISTTIMEFORMAT "%F %T "
    tmux set-environment -t "$wsname" PROMPT_COMMAND "history -a; history -c; history -r; \$PROMPT_COMMAND"

    # Adjuntarse a la sesión
    tmux attach -t "$wsname"
}

