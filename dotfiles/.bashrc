#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
# Aliases

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

alias _='sudo'
alias cdwn='cd Downloads'
alias moo='fortune | cowsay -f llama | lolcat'



# Run when you open terminal?
# fastfetch


# Colorful llama with a fortune
fortune | cowsay -f llama | lolcat


eval "$(starship init bash)"

# Paths (for real)

export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/go
export PATH=$PATH:$HOME/go/bin
export PATH=$PATH:$HOME/go/

export PATH="$HOME/bin:$PATH"
