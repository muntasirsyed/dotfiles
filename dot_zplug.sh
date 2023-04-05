[ -d /usr/local/opt/zplug ] && export ZPLUG_HOME=/usr/local/opt/zplug
[ -d /opt/homebrew/opt/zplug ] && export ZPLUG_HOME=/opt/homebrew/opt/zplug

source $ZPLUG_HOME/init.zsh

zplug "plugins/nvm", from:oh-my-zsh
zplug "plugins/git", from:oh-my-zsh
zplug "plugins/autojump", from:oh-my-zsh

zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-autosuggestions", as:plugin, defer:2

zplug 'zsh-users/zsh-completions', depth:1

zplug load

if ! zplug check --verbose; then
    # install any missing plugins
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi