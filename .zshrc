# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ZSH History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=5000
HIST_STAMPS="yyyy-mm-dd"
setopt appendhistory
setopt extendedhistory
setopt sharehistory
setopt incappendhistory
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

setopt autocd

# plugin manager
source ~/.antidote/antidote.zsh
antidote load ${ZDOTDIR:-$HOME}/.zsh_plugins.txt

eval "$(zoxide init --cmd j zsh)"


# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
elif [[ "$USER" = "root" ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi


alias 0x0="curl -F 'file=@-' 0x0.st | wl-copy"
alias 0x0st="curl -F 'file=@-' -Fsecret= https://0x0.st | wl-copy"
alias conf="cd ~/.config/"
alias dotfiles="cd ~/workspace/dotfiles/"
alias H=Hyprland
alias hx=helix
alias kaf="cd ~/NotesHome/Personal/03\ Personal/Kafka-Sartre/"
alias l="eza -l --icons=auto"
alias la='eza -l -a --icons=auto'
alias ls="eza --icons=auto"
alias liv='ps aux|grep '
alias mime="file -bL --mime-type"
alias math="cd ~/Books/Mathematics/"
alias nt="cd ~/NotesHome/"
alias pp="papis open"
alias tb="nc termbin.com 9999"
alias title="tr '[A-Z]' '[a-z]'| sed -e 's/\b\w/\U&/g'|wl-copy"
alias vim=nvim

# to use preloaded shell completions that ships with programs
autoload -U compinit
compinit

# For theme.sh
if command -v theme.sh > /dev/null; then
	# [ -e ~/.theme_history ] && theme.sh "$(theme.sh -l|tail -n1)"

	# Bind C-o to the last theme.
	last_theme() {
		theme.sh "$(theme.sh -l|tail -n4|head -n1)"
	}

  # zle -N is used to create a new-keymap
	zle -N last_theme
	bindkey '^R' last_theme

	alias th='theme.sh -i'

	# Interactively load a light theme
alias thl='theme.sh --light -i'

	# Interactively load a dark theme
	alias thd='theme.sh --dark -i'
fi

# find and play music with mpv
if command -v mpc > /dev/null; then
  fzf_mpc_play() {
    mpc status| grep -q -E "playing|paused" || mpc clear > /dev/null # clear the queue if not currently playing or has an active queue
    files=("${(@f)$(FZF_DEFAULT_COMMAND='fd -i -t file --base-directory /home/joel/Music/'\
              fzf -m \
              --preview 'exiftool -m -b -Coverart -Picture /home/joel/Music/{}|magick /dev/stdin -resize 500 /dev/stdout |chafa' \
              --preview-window 'right,50%,border-rounded,+{2}+3/3,~3')}")
    [[ -n "$files" ]] || return 1
    for file in $files
    do
      mpc add ~/joel/Music/$file
    done
    systemctl --user start mpDris2.service
    mpc play > /dev/null
  }

  alias /m=fzf_mpc_play
fi

# find and open the document required (filtering in pdf, djvu, and epub)
if command -v zathura > /dev/null; then
  open_document() {
    document="$(FZF_DEFAULT_COMMAND='fd . -i -t file --base-directory /home/joel/Books/ -e pdf -e djvu -e epub' fzf)"
    [[ -n "$document" ]] && $(zathura ~/Books/$document &) # spawn grandchild process so the zathura instance doesn't get terminated with the current shell
  }

  alias /d=open_document
fi

# find and open the file required with nvim and fd
if command -v nvim> /dev/null; then
  open_text_file() {
    file="$(FZF_DEFAULT_COMMAND='fd . -i -H -t file --base-directory .' fzf)"
    [[ -n "$file" ]] && (nvim $(pwd)/$file)
  }

  alias /f=open_text_file
fi

# find and open the file required with nvim and ripgrep
if command -v nvim> /dev/null; then
  search_text_file() {
    filesearch="$(rga --color=always --line-number --no-heading --smart-case "${*:-}" |
    fzf --ansi -i\
        --color "hl:-1:underline,hl+:-1:underline:reverse" \
        --delimiter : \
        --preview 'bat --color=always {1} --highlight-line {2} --style=changes,numbers,snip' \
        --preview-window 'right,50%,border-rounded,+{2}+3/3,~3')"
    file="$(echo "$filesearch"|cut -d':' -f1)"
    line="$(echo "$filesearch"|cut -d':' -f2)"
    [[ -n "$file" ]] && (nvim "$(pwd)/$file" "+$line")
  }

  alias /s=search_text_file
fi

# jump to required folder with fd
if command -v fd> /dev/null; then
  jump_to_folder() {
    folder="$(FZF_DEFAULT_COMMAND='fd . -i -H -t directory --base-directory .' fzf)"
    [[ -n "$folder" ]] && zoxide add $(pwd)/$folder && cd $(pwd)/$folder
  }

  alias /j=jump_to_folder
fi

if command -v papis> /dev/null; then
  alias /r='papis open'
fi

alias /R='python ~/.config/userscripts/radio-fzf.py'

# send signal across all instances of zsh
TRAPUSR1() {
  scheme=$(cat /tmp/color_scheme)
  if [[ "$scheme" == "day" ]];then
    theme.sh gruvbox
  elif [[ "$scheme" == "night" ]]; then
    theme.sh gruvbox-dark-hard
  fi
}
TRAPUSR1

# Vim keybindings
set -o vi
bindkey -v '^?' backward-delete-char

# Yank to the system clipboard
function vi-yank-xclip {
   zle vi-yank
   echo "$CUTBUFFER" | wl-copy
}

# Copy to clipboard
zle -N vi-yank-xclip
bindkey -M vicmd 'y' vi-yank-xclip

# pattern match search through history on arrow up
bindkey "^[[A" history-substring-search-up
bindkey "^[OA" history-substring-search-up
bindkey "^[[B" history-substring-search-down
# Use Ctrl+P and Ctrl+N for the same
bindkey "^P" history-substring-search-up
bindkey "^N" history-substring-search-down

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Source fzf
source <(fzf --zsh)

. "$HOME/.cargo/env"
