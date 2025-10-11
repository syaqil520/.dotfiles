# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

if [[ -f "/opt/homebrew/bin/brew" ]] then
  # If you're using macOS, you'll want this enabled
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# setup zinit package manager
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# Add in zsh plugins
zinit light Aloxaf/fzf-tab
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
zi ice depth=1; zi light romkatv/powerlevel10k

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
bindkey '^[[1;3C' forward-word
bindkey '^[[1;3D' backward-word

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

# FZF Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'
zstyle ':completion:*:git-checkout:*' sort false
zstyle ':fzf-tab:*' use-fzf-default-opts yes
export FZF_DEFAULT_OPTS=" \
  --color=bg+:#313244,bg:#1E1E2E,spinner:#F5E0DC,hl:#F38BA8 \
  --color=fg:#CDD6F4,header:#F38BA8,info:#CBA6F7,pointer:#F5E0DC \
  --color=marker:#B4BEFE,fg+:#CDD6F4,prompt:#CBA6F7,hl+:#F38BA8 \
  --color=selected-bg:#45475A \
  --color=border:#313244,label:#CDD6F4 \
--border 
--color border: #313244"

# shell integration
eval "$(zoxide init --cmd cd zsh)"
eval "$(fzf --zsh)"

# Custom Script

# custom config base on machine either mac or linux
OS="$(uname -s)"
if [ "$OS" = "Darwin" ]; then

  export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

  eval "$(rbenv init - --no-rehash zsh)"
  local rustuppath=$(brew --prefix rustup)/bin
  export PATH="$PATH:/Users/syaqilaizat/.local/bin:$rustuppath"

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

  alias un='paru -Rns' # uninstall package
  alias up='paru -Syu' # update system/package/aur
  alias pl='paru -Qs' # list installed package
  alias pa='paru -Ss' # list available package
  alias pc='paru -Sc' # remove unused cache
  alias po='paru -Qtdq | paru -Rns -' # remove unused packages, also try > paru -Qqd | paru -Rsu --print

fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Created by `pipx` on 2025-08-05 16:52:01
export PATH="$PATH:/Users/syaqilaizat/.local/bin"
