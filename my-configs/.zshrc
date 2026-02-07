# ==============================================================================
# ------------------------------------------------------------------------------
# 🚀 TOOL INITIALIZATION & CONFIGURATION
# ------------------------------------------------------------------------------

# --- Welcome Message ---
# Displays a colorful welcome message.
# FILE: .zshrc
# DESCRIPTION: Main configuration file for the Zsh shell.
# This file handles theme, plugins, aliases, environment variables,
# and shell behavior.
# ==============================================================================

# Disable Powerlevel10k instant prompt
typeset -g POWERLEVEL9K_INSTANT_PROMPT=off

# ------------------------------------------------------------------------------
# 🚀 POWERLEVEL10K INSTANT PROMPT
# ------------------------------------------------------------------------------
# Enables faster shell startup by loading a cached version of the prompt.
# See: https://github.com/romkatv/powerlevel10k#instant-prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ------------------------------------------------------------------------------
# 📦 ZINIT PLUGIN MANAGER
# ------------------------------------------------------------------------------
# Initializes Zinit, a flexible and fast plugin manager for Zsh.
# It will be automatically installed if not found.
# See: https://github.com/zdharma-continuum/zinit
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [ ! -d "$ZINIT_HOME" ]; then
	mkdir -p "$(dirname $ZINIT_HOME)"
	git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "${ZINIT_HOME}/zinit.zsh"

# --- ZINIT PLUGINS ------------------------------------------------------------

# Theme » Powerlevel10k
# A fast and feature-rich theme for Zsh.
# See: https://github.com/romkatv/powerlevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k

# Zsh Core Plugins
zinit light zsh-users/zsh-syntax-highlighting # Syntax highlighting for commands
zinit light zsh-users/zsh-completions         # Enhanced completion system
zinit light zsh-users/zsh-autosuggestions     # Fish-like command suggestions
zinit light Aloxaf/fzf-tab                    # Fuzzy completion for tab
zinit light jeffreytse/zsh-vi-mode            # Vi mode integration

# Oh-My-Zsh Plugins
# Loads useful plugins from the Oh-My-Zsh repository.
zinit snippet OMZP::git               # Git integration and aliases
zinit snippet OMZP::sudo              # Press ESC twice to add sudo
zinit snippet OMZP::archlinux         # Arch Linux specific commands
zinit snippet OMZP::command-not-found # Suggests packages for unknown commands
zinit snippet OMZP::colored-man-pages # Colorized man pages
zinit snippet OMZP::history           # History management

# -------------------------------------------
# 1. Edit Command Buffer
# -------------------------------------------
# Open the current command in your $EDITOR (e.g., neovim)
# Press Ctrl+X followed by Ctrl+E to trigger
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey  '^Xe' edit-command-line

# -------------------------------------------
# 2. Undo in ZSH
# -------------------------------------------
# Press Ctrl+_ (Ctrl+Underscore) to undo
# This is built-in, no configuration needed!
# Redo widget exists but has no default binding:
bindkey '^Y' redo # Example binding if you want it

# Copy the current command to the clipboard
zle -N copy-command
bindkey '^Y^Y' copy-command
# -------------------------------------------
# 3. Magic Space - Expand History
# -------------------------------------------
# ---------- make history-expand-line available ----------
# If you already use zsh-history-substring-search or
# zsh-syntax-highlighting, just load that plugin instead.
autoload -Uz up-line-or-history
zle -N history-expand-line  up-line-or-history   # or any no-op you like

# -------------------------------------------
# 4. chpwd Hook - Run Commands on Directory Change
# -------------------------------------------
# NOTE: Only one chpwd hook can be defined at once
# To merge them, use add-zsh-hook which is mentioned below
# Example: List directory contents on cd
# chpwd() {
#  ls
# }
# ------------------------------------------------------------------------------
# 🌍 ENVIRONMENT & PATH CONFIGURATION
# ------------------------------------------------------------------------------

# --- Core Environment Variables ---
export EDITOR=nvim visudo
export VISUAL=nvim visudo
export FCEDIT=nvim
export TERMINAL=kitty
export MICRO_TRUECOLOR=1
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

if [[ -x "$(command -v fzf)" ]]; then
	export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS \
	  --info=inline-right \
	  --ansi \
	  --layout=reverse \
	  --border=rounded \
	  --color=border:#27a1b9 \
	  --color=fg:#c0caf5 \
	  --color=gutter:#16161e \
	  --color=header:#ff9e64 \
	  --color=hl+:#2ac3de \
	  --color=hl:#2ac3de \
	  --color=info:#545c7e \
	  --color=marker:#ff007c \
	  --color=pointer:#ff007c \
	  --color=prompt:#2ac3de \
	  --color=query:#c0caf5:regular \
	  --color=scrollbar:#27a1b9 \
	  --color=separator:#ff9e64 \
	  --color=spinner:#ff007c \
	"
fi
# --- PATH Configuration ---
# Consolidates all PATH modifications for clarity.
# Zsh's `path` array is tied to the $PATH variable.
# Prepending to the `path` array is the idiomatic way to add directories.
# `typeset -U path` ensures no duplicate entries.
typeset -U path
path=(
  "$HOME/.local/bin"
  "$HOME/.cargo/bin"
  "$HOME/.npm-global/bin"
  "$HOME/go/bin"
  "/usr/lib/go/bin"
  "/opt/firefox"
  "$HOME/bin"
  "$HOME/srhills/shims"
  $path
)

# --- Tool-Specific Environment Variables ---
# Golang environment variables
export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export GOROOT=/usr/lib/go
export GOENV_ROOT="$HOME/.goenv"
export GIN_MODE=release
# Update PATH to include GOPATH and GOROOT binaries
export PATH=$GOPATH/bin:$GOROOT/bin:$HOME/.local/bin:$PATH
export GITHUB_TOKEN="YOUR_GITHUB_TOKEN"

# Bat (Cat Clone)
export BAT_THEME="Dracula"
# FZF (Fuzzy Finder)
export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -n -200'"
export FZF_CTRL_T_OPTS="--preview 'bat --style=numbers --color=always --line-range :500 {}'"
export FZF_DEFAULT_OPTS="--height 70% --layout=reverse --border=sharp --prompt '∷ ' --pointer ▶ --marker ⇒"

# GPG
export GPG_TTY=$(tty)

# Other Tools
export WATCHTOWER_IMAGE=containrrr/watchtower
export HF_HUB_ENABLE_HF_TRANSFER=1
export N8N_RUNNERS_ENABLED=true
export N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS=true

# ------------------------------------------------------------------------------
# ⚙️ SHELL OPTIONS (setopt)
# ------------------------------------------------------------------------------

# --- History Management ---
setopt APPEND_HISTORY         # Append to history file
setopt EXTENDED_HISTORY       # Save timestamp and duration
setopt HIST_EXPIRE_DUPS_FIRST # Remove duplicates first when trimming
setopt HIST_FIND_NO_DUPS      # Don't display duplicates during searches
setopt HIST_IGNORE_ALL_DUPS   # If a new command is a duplicate, remove the older one
setopt HIST_IGNORE_DUPS       # Don't record consecutive duplicate commands
setopt HIST_IGNORE_SPACE      # Don't record commands starting with a space
setopt HIST_REDUCE_BLANKS     # Remove superfluous blanks
setopt HIST_SAVE_NO_DUPS      # Don't write duplicate entries in the history file
setopt HIST_VERIFY            # Show command with history expansion before running
setopt INC_APPEND_HISTORY     # Write to history immediately, not on shell exit
setopt SHARE_HISTORY          # Share history between all sessions

# --- Directory & Navigation ---
setopt AUTOCD                 # Change directory without `cd`
setopt AUTO_PUSHD             # Make `cd` push the old directory onto the stack
setopt PUSHD_IGNORE_DUPS      # Don't push multiple copies of the same directory
setopt PUSHD_MINUS            # Exchange meanings of +/- with directory stack numbers
setopt CORRECT                # Command auto-correction
setopt NUMERIC_GLOB_SORT      # Sort filenames numerically

# --- Completion ---
setopt COMPLETE_IN_WORD       # Complete from cursor position
setopt ALWAYS_TO_END          # Move cursor to end of word after completion
setopt AUTO_LIST              # Show completion list on ambiguous match
setopt AUTO_MENU              # Show completion menu on successive tabs
setopt AUTO_PARAM_SLASH       # Add trailing slash to completed directories
setopt MENU_COMPLETE          # Automatically select first completion entry

# --- General Behavior ---
setopt BANG_HIST              # Treat '!' specially for history expansion
setopt INTERACTIVE_COMMENTS   # Allow comments in interactive shell
setopt MAGIC_EQUAL_SUBST      # Filename expansion for 'anything=expression'
setopt MULTIOS                # Allow multiple I/O redirection
setopt NO_BEEP                # Don't beep on errors
setopt NONOMATCH              # Hide error if glob pattern has no match
setopt NOTIFY                 # Report status of background jobs immediately
setopt PROMPT_SUBST           # Allow substitutions in the prompt

# ------------------------------------------------------------------------------
# 📖 HISTORY CONFIGURATION
# ------------------------------------------------------------------------------
# Sets the location and size of the shell history.
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000000
SAVEHIST=10000000

# ------------------------------------------------------------------------------
# ⌨️ COMPLETION SYSTEM
# ------------------------------------------------------------------------------
# Initializes the Zsh completion system and sets custom paths/styles.
# Load completions

autoload -Uz compinit && compinit
autoload -U compaudit compinit
autoload -Uz _zinit
zinit cdreplay -q
autoload -U promptinit; promptinit
# Add custom completion directories to the function path.
fpath=(
  "$HOME/.local/share/zsh/completions"
  "$HOME/.zsh-completions"
   $fpath
)
compinit
# --- Completion Styling (zstyle) ---
zmodload zsh/complist
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu select=2 eval "$(dircolors -b)"
zstyle ':fzf-tab:*' use-fzf-default-opts yes
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'exa --color=always \$realpath'
zstyle ':completion:*:*:docker:*' option-stacking yes
zstyle ':completion:*:*:docker-*:*' option-stacking yes
zstyle ':completion:*:corrections' format ' %F{green}-- %d (errors: %e) --%f'
zstyle ':completion:*:descriptions' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
zstyle ':completion:*' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
zstyle ':completion:*' group-name '' 
zstyle ':completion:*' menu select
zstyle ':completion:*' verbose yes
zstyle ':completion:*' rehash yes
zstyle -e ':completion:*:approximate:*' max-errors 'reply=( $(( ($#PREFIX + $#SUFFIX) / 3 )) )'
zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup

# ------------------------------------------------------------------------------
# ⚡ KEYBINDINGS
# ------------------------------------------------------------------------------
bindkey -v                        # Use vi key bindings
bindkey '^P' up-line-or-search    # Ctrl-P for previous command
bindkey '^N' down-line-or-search  # Ctrl-N for next command

# ------------------------------------------------------------------------------
# 🏷️ ALIASES
# ------------------------------------------------------------------------------

# --- General Aliases ---
alias vim='nvim'
alias fixit='$(thefuck --alias)'
alias help='run-help'
alias copilot='gh copilot'
alias gcs='gh copilot suggest'
alias gce='gh copilot explain'
alias gcse='gh config set editor "nvim --wait"'

# --- Global Aliases ---
alias -g C='| wl-copy'

# Use bat for help pages
# in your .bashrc/.zshrc/*rc
alias bathelp='bat --plain --language=help'
function help {
    "$@" --help 2>&1 | bathelp
}

# --- Fabric AI Pattern Aliases ---
# Dynamically creates an alias for each pattern directory in the Fabric config directory.
# Usage: `alias_name` is equivalent to `fabric --pattern alias_name`
# Performance optimization: Only load if FABRIC_ALIASES_ENABLED is not set to false
if [[ "${FABRIC_ALIASES_ENABLED:-true}" != "false" ]] && [[ -d "$HOME/.config/fabric/patterns" ]] && command -v fabric &> /dev/null; then
    # Loop through all directories in the ~/.config/fabric/patterns directory
    for pattern_dir in $HOME/.config/fabric/patterns/*; do
        # Only process if it's a directory and contains a system.md file
        if [[ -d "$pattern_dir" && -f "$pattern_dir/system.md" ]]; then
            # Get the base name of the directory (i.e., remove the directory path)
            pattern_name="$(basename "$pattern_dir")"
            alias_name="${FABRIC_ALIAS_PREFIX:-}${pattern_name}"

            # Create an alias in the form: alias pattern_name="fabric --pattern pattern_name"
            alias_command="alias $alias_name='fabric --pattern $pattern_name'"

            # Evaluate the alias command to add it to the current shell
            eval "$alias_command"
        fi
    done
fi

yt() {
    if [ "$#" -eq 0 ] || [ "$#" -gt 2 ]; then
        echo "Usage: yt [-t | --timestamps] youtube-link"
        echo "Use the '-t' flag to get the transcript with timestamps."
        return 1
    fi

    transcript_flag="--transcript"
    if [ "$1" = "-t" ] || [ "$1" = "--timestamps" ]; then
        transcript_flag="--transcript-with-timestamps"
        shift
    fi
    local video_link="$1"
    fabric -y "$video_link" $transcript_flag
}

# ------------------------------------------------------------------------------
# 🛠️ CUSTOM FUNCTIONS
# ------------------------------------------------------------------------------

# --- cheat ---
# Fetches cheat sheets from cheat.sh.
# Usage: cheat <command>
cheat() {
  curl "cheat.sh/$*"
}

# --- Yazi Shell wrapper ---
# We suggest using this y shell wrapper that provides the ability to change the 
# current working directory when exiting Yazi.
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

# Function to extract and print text
pt() {
    # Check if an argument is provided
    if [ -z "$1" ]; then
        echo "Usage: pt <transcribe_minutes>"
        return 1
    fi

# To use it, copy the function into the configuration file of your respective shell.
# Then use y instead of yazi to start, and press q to quit, you'll see the CWD changed. 
# Sometimes, you don't want to change. Press Q to quit.
    
    # Extract the input text (removing leading/trailing whitespace)
    extracted_text=$(echo "$1" | xargs)
    
    echo "$extracted_text"  # Output the extracted text
}

# --- Fabric Helper Functions ---

# Regenerate fabric aliases on demand
fabric_reload_aliases() {
    echo "Reloading Fabric aliases..."
    
    # Remove existing fabric aliases to avoid duplicates
    if [[ -d "$HOME/.config/fabric/patterns" ]]; then
        for pattern_dir in $HOME/.config/fabric/patterns/*; do
            if [[ -d "$pattern_dir" && -f "$pattern_dir/system.md" ]]; then
                pattern_name="$(basename "$pattern_dir")"
                alias_name="${FABRIC_ALIAS_PREFIX:-}${pattern_name}"
                unalias "$alias_name" 2>/dev/null
            fi
        done
    fi
    
    # Recreate aliases
    if command -v fabric &> /dev/null; then
        for pattern_dir in $HOME/.config/fabric/patterns/*; do
            if [[ -d "$pattern_dir" && -f "$pattern_dir/system.md" ]]; then
                pattern_name="$(basename "$pattern_dir")"
                alias_name="${FABRIC_ALIAS_PREFIX:-}${pattern_name}"
                alias_command="alias $alias_name='fabric --pattern $pattern_name'"
                eval "$alias_command"
                echo "Created alias: $alias_name"
            fi
        done
    else
        echo "Error: fabric command not found"
        return 1
    fi
    
    echo "Fabric aliases reloaded successfully"
}

# ------------------------------------------------------------------------------
# 🚀 TOOL INITIALIZATION & CONFIGURATION
# ------------------------------------------------------------------------------

# --- Atuin (Shell History) ---
# Replaces default history with a searchable, synced, and structured database.
# See: https://github.com/atuinsh/atuin
if command -v atuin &> /dev/null; then
  eval "$(atuin init zsh)"
fi

# Append a command directly (after sourcing zvm)
zvm_after_init_commands+=(
 'eval "$(atuin init zsh)"'
)
# --- Zoxide (Directory Navigation) ---
# A smarter `cd` command that learns your habits.
# See: https://github.com/ajeetdsouza/zoxide
eval "$(zoxide init --cmd cd zsh)"

# --- FZF (Fuzzy Finder) ---
# Enables fzf's key bindings (Ctrl-T, Ctrl-R, Alt-C).
# See: https://github.com/junegunn/fzf
#######################################################
# Shell integrations
#######################################################

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

#Zoxide config for zsh plugins 
eval "$(fzf --zsh)"

# --- UV (Python Tooling) ---
# An extremely fast Python package installer and resolver.
# See: https://github.com/astral-sh/uv
eval "$(uv generate-shell-completion zsh)"
eval "$(uvx --generate-shell-completion zsh)"

# --- Goenv (Go Version Manager) ---
# See: https://github.com/go-nv/goenv
if command -v goenv &> /dev/null; then
  eval "$(goenv init -)"
fi

# --- GHCup (Haskell Toolchain) ---
[ -f "$HOME/.ghcup/env" ] && source "$HOME/.ghcup/env"

# --- GitHub Copilot CLI ---
# Generates shell command suggestions.
compdef gh # Ensures gh completions are loaded

# --- Bat & Help System ---
# Configures the `run-help` command to use `bat`.
unalias run-help 2>/dev/null
autoload -Uz run-help

# --- URL Handling ---
# Enables smart pasting and quoting of URLs.
autoload -Uz bracketed-paste-magic; zle -N bracketed-paste bracketed-paste-magic
autoload -Uz url-quote-magic;      zle -N self-insert url-quote-magic

# --- Autosuggestion Styling ---
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#ff9fbd,bold'

# --- Spelling Correction Prompt ---
SPROMPT='zsh: correct %F{#e63d1f}%R%f to %F{#00ff00}%r%f [nyae]? '

# ------------------------------------------------------------------------------
# ✨ FINALIZATION
# ------------------------------------------------------------------------------

# --- Load Powerlevel10k Configuration ---
# This file is generated by `p10k configure`.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# --- Load Personal/Local Configuration ---
#create a file called .zshrc-personal and put all your personal aliases
#in there. They will not be overwritten by skel.
[[ -f ~/.zshrc-personal ]] && . ~/.zshrc-personal

# These TWO Code blocks cause pasted URLs to be automatically quoted, without
# needing to disable globbing.
autoload -Uz bracketed-paste-magic
zle -N bracketed-paste bracketed-paste-magic

autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic

# Prints random height bars across the width of the screen
# (great with lolcat application on new terminal windows)
function random_bars() {
	columns=$(tput cols)
	chars=(▁ ▂ ▃ ▄ ▅ ▆ ▇ █)
	for ((i = 1; i <= $columns; i++))
	do
		echo -n "${chars[RANDOM%${#chars} + 1]}"
	done
	echo
}

# --- Zinit Cache ---
zinit cdreplay -q
# --- Environment Variables ---
export LMS_EMAIL_USER="your_email@gmail.com"
export LMS_EMAIL_PASS="your_passphrase"
# zsh (See ~/.zshrc)
if [[ $TERM_PROGRAM != "WarpTerminal" ]]; then
##### WHAT YOU WANT TO DISABLE FOR WARP - BELOW
    # Unsupported plugin/prompt code here
##### WHAT YOU WANT TO DISABLE FOR WARP - ABOVE
fi

# opencode
export PATH=/home/srhills/.opencode/bin:$PATH
export XDG_RUNTIME_DIR="/run/user/$(id -u)"
export DBUS_SESSION_BUS_ADDRESS="unix:path=$XDG_RUNTIME_DIR/bus"
export PATH="/usr/lib/ccache/bin/:$PATH"

eval $(thefuck --alias)
export GEM_HOME="$(ruby -e 'puts Gem.user_dir')"
export PATH="$PATH:$GEM_HOME/bin"
eval "$(starship init zsh)"
export PATH=~/.npm-global/bin:$PATH
fpath+=${ZDOTDIR:-~}/.zsh_functions

. "$HOME/.atuin/bin/env"
# BEGIN_KITTY_SHELL_INTEGRATION
if [[ -n "$KITTY_INSTALLATION_DIR" && -e "$KITTY_INSTALLATION_DIR/shell-integration/zsh/kitty.zsh" ]]; then
    source "$KITTY_INSTALLATION_DIR/shell-integration/zsh/kitty.zsh"
fi
# END_KITTY_SHELL_INTEGRATION
alias huggingface-cli=hf

# bun completions
[ -s "/home/srhills/.bun/_bun" ] && source "/home/srhills/.bun/_bun"

# lscolors config file
# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
. /usr/share/LS_COLORS/dircolors.sh
export PATH="$HOME:$PATH"
