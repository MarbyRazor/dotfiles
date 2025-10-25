# autoload bashcompinit
# bashcompinit

# -----------------------------------------------------------------------------
# General
# -----------------------------------------------------------------------------
export EDITOR="nvim"

# -----------------------------------------------------------------------------
# Dotfiles
# -----------------------------------------------------------------------------
export PATH="$HOME/.local/bin:$PATH"

# -----------------------------------------------------------------------------
# Environment/Path settings
# -----------------------------------------------------------------------------
# Storing custom scripts
export PATH="$HOME/.local/bin:$PATH"

# run this blaizingly fast
s () {
  # Find all scripts in ~/.local/bin and pass them to fzf for selection
  local script=$(find ~/.local/bin -type f | fzf --prompt="Select a script: " --height=40% --border --reverse)
  
  # If a script is selected, execute it
  if [[ -n $script ]]; then
    echo "Executing: $script"
    "$script"
  else
    echo "No script selected."
  fi
}

# -----------------------------------------------------------------------------
# zsh-completions
# -----------------------------------------------------------------------------
if type brew &>/dev/null; then
    FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

    autoload -Uz compinit
    compinit
fi

# -----------------------------------------------------------------------------
# Kubernetes
# -----------------------------------------------------------------------------
if [ /opt/homebrew/bin/kubectl ]; then source <(kubectl completion zsh); fi

alias k=kubectl

# Switch context
knx () {
  local context
  context=$(kubectl config get-contexts --no-headers | awk '{print $2}' | fzf --prompt="Select Context: " --height=40% --reverse)
  if [ -n "$context" ]; then
    kubectl config use-context "$context"
  else
    echo "No context selected."
  fi
}

# Switch namespace
kns () {
  local namespace
  namespace=$(kubectl get namespaces --no-headers | awk '{print $1}' | fzf --prompt="Select Namespace: " --height=40% --reverse)
  if [ -n "$namespace" ]; then
    kubectl config set-context --current --namespace="$namespace"
  else
    echo "No namespace selected."
  fi
}

# -----------------------------------------------------------------------------
# FZF and FD
# -----------------------------------------------------------------------------
# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
eval "$(fzf --zsh)"

# export FZF_DEFAULT_OPS="--extended"
# export FZF_DEFAULT_COMMAND="fd --typ f" # Use FD instead of find - ignores files from .gitignore
# export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

# -----------------------------------------------------------------------------
# Blazingly fast
# -----------------------------------------------------------------------------
bindkey -s "^f" "tmux-sessionizer\n"

# ----------------------------------------------------------------------------
# go-taskfile tasklist
# -----------------------------------------------------------------------------
t (){
    # Attempt to store the output of `task -as` while capturing any errors
    TASK_OUTPUT=$(task -as 2>&1)  # Redirects both standard output and errors

    # Check if an error occurred
    if [ $? -ne 0 ]; then
        # Print the error message and exit the function
        echo "Error: $TASK_OUTPUT"
        return 1
    fi

    # If no error occurred, call `fzf` with the output of `task -as`
    TASK=$(echo "$TASK_OUTPUT" | fzf)

    # If a selection was made, execute the selected task
    if [ -n "$TASK" ]; then
        task "$TASK"
    else
        echo "No task selected."
    fi
}

# -----------------------------------------------------------------------------
# Alias
# -----------------------------------------------------------------------------

# # Globacl
alias ll="ls -ahl"
alias l="ls -ahl"
alias vim=$EDITOR
alias vi=$EDITOR
alias v="$EDITOR ."
alias c="code ."
alias ta="tmux a"
#
# # Git
alias gs='git status'
alias gb='git branch '
alias got='git '
alias get='git '
alias sz='source ~/.zshrc'
