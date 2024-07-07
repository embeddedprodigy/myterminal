#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

# Set up fzf key bindings and fuzzy completion
eval "$(fzf --bash)"

# fzf knowledge source, https://www.josean.com/posts/7-amazing-cli-tools
# --- setup fzf theme ---
fg="#CBE0F0"
bg="#011628"
bg_highlight="#143652"
purple="#B388FF"
blue="#06BCE4"
cyan="#2CF9ED"

export FZF_DEFAULT_OPTS="--color=fg:${fg},bg:${bg},hl:${purple},fg+:${fg},bg+:${bg_highlight},hl+:${purple},info:${blue},prompt:${cyan},pointer:${cyan},marker:${cyan},spinner:${cyan},header:${cyan}"

# bind control key to preview found in this link, https://github.com/junegunn/fzf/issues/1819
export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always --line-range :500 {}' --bind 'j:down,k:up,ctrl-j:preview-down,ctrl-k:preview-up'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200' --bind 'j:down,k:up,ctrl-j:preview-down,ctrl-k:preview-up'"

_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo $'{}"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "bat -n --color=always --line-range :500 {}" "$@" ;;
  esac
}

# Interactive nvim
alias inv='nvim $(fzf --preview="bat --color=always {} ")'
bind -x '"\C-n":nvim $(fzf -m --preview="bat --color=always {} ")'

# fzf-git config, clone it to ~
# git clone https://github.com/junegunn/fzf-git.sh.git
source ~/fzf-git.sh/fzf-git.sh

# config for bat command, https://github.com/sharkdp/bat
# 1 - creat the directory: mkdir -p "$(bat --config-dir)/themes"
# 2 - download the theme to where it was created: ~/.config/bat/theme/<theme here>
# 3 - to check: cd "$(bat --config-dir)/themes"
# 4 - run comand: bat cache --build
# to check theme realtie in terminal: bat --list-themes | fzf --preview="bat --theme={} --color=always <sample file ./fzf-git.sh/README.md>"
alias catb="bat"
export BAT_THEME=gruvbox-dark

# config for eza, https://github.com/eza-community/eza
# 1 - sudo pacman -S eza
# 2 - paste the command added below
# 3 - for directory(tree) command use eza --tree --level=<num>
# 4 -  
alias lse="eza --color=always --icons=always --git --long"

# zoxide config, https://github.com/ajeetdsouza/zoxide
eval "$(zoxide init bash)"
alias cd="z"

# tldr config, dependency/ies npm https://github.com/tldr-pages/tldr
# nodejs and npm installation
# sudo pacman -S nodejs npm
# source: https://nodejs.org/en/download/package-manager/all#arch-linux
# install npm install -g tldr
alias mant="tldr"


# thefuck config, https://github.com/nvbn/thefuck
eval $(thefuck --alias)
# You can use whatever you want as an alias, like for Mondays:
eval $(thefuck --alias fuck)
