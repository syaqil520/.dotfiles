export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

if [[ -f "/opt/homebrew/bin/brew" ]] then
  # If you're using macOS, you'll want this enabled
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi
# init starship prompt
eval "$(starship init zsh)"

# setup zinit package manager
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

zi snippet OMZP::git
zi snippet OMZP::sudo

zi cdclear -q # <- forget completions provided up to this moment

# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

# alias
alias  cls='clear' # clear terminal
alias  l='eza -lh  --icons=auto' # long list
alias ls='eza -1   --icons=auto' # short list
alias la='eza -1a   --icons=auto' # short list
alias ll='eza -lha --icons=auto --sort=name --group-directories-first' # long list all
alias ld='eza -lhD --icons=auto' # long list dirs
alias lt='eza --icons=auto --tree' # list folder as tree
alias lgit='lazygit'
alias ldocker='lazydocker'
alias lsql='lazysql'
alias v="nvim"
alias sail='sh $([ -f sail ] && echo sail || echo vendor/bin/sail)' # Laravel sail
alias mkdir='mkdir -p' # Always mkdir a path (this doesn't inhibit functionality to make a single dir)

# Handy change dir shortcuts
alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'

# set emac mode in terminal
bindkey -e

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# shell integration
eval "$(zoxide init --cmd cd zsh)"
eval "$(fzf --zsh)"

# Custom Script
function flutter-watch(){
  tmux send-keys "flutter run $1 $2 $3 $4 --pid-file=/tmp/tf1.pid" Enter \;\
  split-window -v \;\
  send-keys 'npx -y nodemon -e dart -x "cat /tmp/tf1.pid | xargs kill -s USR1"' Enter \;\
  resize-pane -y 5 -t 1 \;\
  select-pane -t 0 \;
}

# custom config base on machine either mac or linux
OS="$(uname -s)"
if [ "$OS" = "Darwin" ]; then

  export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

else

  source /usr/share/nvm/init-nvm.sh
  # custom var
  # Java
  export JAVA_HOME=/usr/lib/jvm/java-17-openjdk/
  # Android
  unset ANDROID_SDK_ROOT
  export ANDROID_HOME=$HOME/Android/Sdk/
  export PATH=$PATH:$ANDROID_HOME/emulator
  export PATH=$PATH:$ANDROID_HOME/platform-tools
  export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin/
  export CHROME_EXECUTABLE=/usr/bin/google-chrome-stable
  # Created by `pipx` on 2024-10-10 14:55:01
  export PATH="$PATH:/home/qaizaa/.local/bin"

  # PAtH Variable
  PATH="$HOME/.config/composer/vendor/bin:$PATH"
  PATH="$PATH":"$HOME/.pub-cache/bin/"

fi
