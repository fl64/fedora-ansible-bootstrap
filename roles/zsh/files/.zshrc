# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/user/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
#ZSH_THEME="agnoster"
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    git
    ansible
    docker
    direnv
    docker-compose
    helm
    vagrant
    zsh-syntax-highlighting
    zsh-autosuggestions
    zsh-kubectl-prompt
    kubectl
    istioctl
    )



POWERLEVEL9K_MODE="nerdfont-complete"
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir vcs )
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(kubecontext status time ssh)

POWERLEVEL9K_SHORTEN_DIR_LENGTH=1
POWERLEVEL9K_SHORTEN_DELIMITER=""
POWERLEVEL9K_SHORTEN_STRATEGY="truncate_from_right"

export PATH=$PATH:~/.local/bin


source $ZSH/oh-my-zsh.sh
#source ~/.zshrc_my
# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

setopt +o nomatch

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/mc mc
complete -o nospace -C /usr/local/bin/mc mc

alias cls="clear"
alias dcu="docker-compose up -d --build"
alias dcd="docker-compose down"
alias dcl="docker-compose logs"
alias ls="exa"
alias vd="vagrant destroy"
alias vdf="vagrant destroy -f"
alias vu="vagrant up --provision"
alias vs="vagrant ssh"
alias tfp="terraform plan -no-color | grep -E '(^.*[#~+-] .*|^[[:punct:]]|Plan)'"

ANSIBLE_VAULT_PASSWORD_FILE=~/.vault_pass.txt
function ssh () {/usr/bin/ssh -t $@ "tmux attach || tmux new";}

# generate QR code for input
function generateqr () { printf "$@" | curl -F-=\<- qrenco.de }

# get a list of files in the current folder and subfolders which contains the word “text”, the line number, and the line contact inside “less”
function ftext () { grep -iIHrn --color=always "$1" . | less -R -r }

export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH

# FL
eval $( keychain --eval -q )
/usr/bin/keychain --inherit any --confirm $HOME/.ssh/id_rsa
/usr/bin/keychain --inherit any --confirm $HOME/.ssh/tfadm-id-rsa

export PATH="${PATH}:/home/user/bin"
# FL

alias d8l="kubectl -n d8-system logs -f deployments/deckhouse | jq '. | select(.level | test(\"info|error|warn\")) | select(.msg | test(\".+deprecated.+\") | not ) | { level: .level, hook: .hook, msg: .msg}' -c"
alias d8le="kubectl -n d8-system logs --tail=100 -f deployments/deckhouse | jq '. | select(.level | test(\"error\")) | select(.msg | test(\".+deprecated.+\") | not ) | { level: .level, hook: .hook, msg: .msg}' -c"
alias d8lw="kubectl -n d8-system logs --tail=100 -f deployments/deckhouse | jq '. | select(.level | test(\"error|warn\")) | select(.msg | test(\".+deprecated.+\") | not ) | { level: .level, hook: .hook, msg: .msg}' -c"
alias d8e="kubectl -n d8-system edit cm deckhouse"
alias d8-ce="kubectl edit cm -n d8-cni-cilium cilium-config"
alias d8-cl="kubectl -n d8-cni-cilium logs daemonsets/agent -f"

. <(istioctl completion zsh)
