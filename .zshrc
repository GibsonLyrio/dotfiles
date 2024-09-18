# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
# {{{
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
# }}}


# Set the directory we want to store zinit and plugins {{{
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
# }}}


# Download zinit if it's not there yet {{{
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
# }}}


# Source/Load {{{
source "${ZINIT_HOME}/zinit.zsh"
source /opt/asdf-vm/asdf.sh
# }}}


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh. {{{
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
# }}}


# Exports {{{
export PATH=$HOME/.local/bin:$HOME/.cargo/bin:$PATH
# }}}


# Adding plugins {{{
zinit ice depth=1; zinit light romkatv/powerlevel10k
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab
# }}}


# Load completions plugin {{{
autoload -U compinit && compinit
# }}}


# Keybindings {{{
bindkey -e
bindkey "^p" history-search-backward
bindkey "^n" history-search-forward
# }}}


# History {{{
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
# }}}


# Completions style {{{
zstyle ":completion:*" matcher-list "m:{a-z}={A-Za-z}"
zstyle ":completion:*" list-colors "${(s.:.)LS_COLORS}"
zstyle ":completion:" menu no
zstyle ":fzf-tab:complete:cd:*" fzf-preview "exa --icons $realpath"
# }}}


# Aliases {{{
alias ls="exa --icons"
alias cat="bat"
# }}}


# Shell integrations {{{
eval "$(fzf --zsh)"
# }}}
