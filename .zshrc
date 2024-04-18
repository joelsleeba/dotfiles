# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
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
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  adb
  colored-man-pages
  copyfile
  copypath
  git
  rbw
  ufw
  # zsh-autocomplete
  # zsh-fzf-history-search
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# User configuration

eval "$(zoxide init --cmd j zsh)"

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
elif [[ "$USER" = "root" ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi


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
alias nt="cd ~/workspace/NotesHome/"
alias math="cd ~/Books/Mathematics/"
alias kaf="cd ~/workspace/NotesHome/Personal/03\ Personal/Kafka-Sartre/"
alias conf="cd ~/.config/"
alias dotfiles="cd ~/workspace/dotfiles/"
alias vim=nvim
alias hx=helix
alias mime="file -bL --mime-type"
alias tb="nc termbin.com 9999"
alias 0x0="curl -F 'file=@-' 0x0.st | wl-copy"
alias 0x0st="curl -F 'file=@-' -Fsecret= https://0x0.st | wl-copy"
alias title="tr '[A-Z]' '[a-z]'| sed -e 's/\b\w/\U&/g'|wl-copy"
alias ls="eza --icons=auto"
# alias ll="eza -l --icons=auto"
# alias la='eza -l -a --icons=auto'

PATH="/home/joel/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/joel/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/joel/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/joel/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/joel/perl5"; export PERL_MM_OPT;

export PATH="$HOME/.local/bin:$PATH"
export PATH="/usr/local/texlive/2023/bin/x86_64-linux/:$PATH"

# For theme.sh
if command -v theme.sh > /dev/null; then
	# [ -e ~/.theme_history ] && theme.sh "$(theme.sh -l|tail -n1)"

	# Bind C-o to the last theme.
	last_theme() {
		theme.sh "$(theme.sh -l|tail -n4|head -n1)"
	}

  # zle -N is used to create a new-keymap
	zle -N last_theme
	bindkey '^O' last_theme

	alias th='theme.sh -i'

	# Interactively load a light theme
	alias thl='theme.sh --light -i'

	# Interactively load a dark theme
	alias thd='theme.sh --dark -i'
fi

# find and play music with mpd
if command -v mpc > /dev/null; then
  fzf_mpc_play() {
    mpc status| grep -q -E "playing|paused" || mpc clear # clear the queue if not currently playing or has an active queue
    files=("${(@f)$(FZF_DEFAULT_COMMAND='fd -i -t file --base-directory /home/joel/Music/'\
              fzf -m \
              --preview 'exiftool -m -b -Coverart -Picture /home/joel/Music/{}|convert /dev/stdin -resize 320 /dev/stdout |chafa' \
              --preview-window 'right,50%,border-rounded,+{2}+3/3,~3')}")
    echo files
    [[ -n "$files" ]] || return 1
    for file in $files
    do
      mpc add $file
    done
    mpc play
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
    filesearch="$(rg --color=always --line-number --no-heading --smart-case "${*:-}" |
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
bindkey -v


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# >>> mamba initialize >>>
# !! Contents within this block are managed by 'mamba init' !!
export MAMBA_EXE='/home/joel/.local/bin/micromamba';
export MAMBA_ROOT_PREFIX='/home/joel/micromamba';
__mamba_setup="$("$MAMBA_EXE" shell hook --shell zsh --root-prefix "$MAMBA_ROOT_PREFIX" 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__mamba_setup"
else
    alias micromamba="$MAMBA_EXE"  # Fallback on help from mamba activate
fi
unset __mamba_setup
# <<< mamba initialize <<<

if [[ -e "/usr/share/fzf/completion.zsh" ]] && [[ -e "/usr/share/fzf/key-bindings.zsh" ]]; then
  source "/usr/share/fzf/key-bindings.zsh"
  source "/usr/share/fzf/completion.zsh"
fi

