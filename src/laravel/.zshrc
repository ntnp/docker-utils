export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=""

zstyle ':omz:update' mode auto      # update automatically without asking
plugins=(git zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

export LANG=en_US.UTF-8

# composer
export PATH="$PATH:$HOME/.composer/vendor/bin"

# theme
fpath+=($HOME/.zsh/pure)
autoload -U promptinit; promptinit
prompt pure

# aliases
alias art="php artisan"
