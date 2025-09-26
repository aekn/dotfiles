autoload -U colors add-zsh-hook && colors
setopt prompt_subst

GIT_SEGMENT=""
VENV_SEGMENT=""
ARROW="→"

_git_info() {
  git rev-parse --is-inside-work-tree &>/dev/null || { GIT_SEGMENT=""; return; }

  local branch dirty
  branch=$(git symbolic-ref --short -q HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null) || { GIT_SEGMENT=""; return; }

  # Quick dirty check
  dirty=$(git status --porcelain -uno --ignore-submodules 2>/dev/null)

  if [[ -n "$dirty" ]]; then
    GIT_SEGMENT="%F{red}(${branch})%f"
  else
    GIT_SEGMENT="%F{green}(${branch})%f"
  fi
}

_venv_info() {
  if [[ -n "$VIRTUAL_ENV" ]]; then
    VENV_SEGMENT=" %F{magenta}($(basename "$VIRTUAL_ENV"))%f"
  else
    VENV_SEGMENT=""
  fi
}

_set_prompt() {
  local last=$?
  if (( last == 0 )); then
    ARROW="%F{green}→%f"
  else
    ARROW="%F{red}→%f"
  fi

  _git_info
  _venv_info

  PROMPT="%F{blue}%~%f ${GIT_SEGMENT}${VENV_SEGMENT}
${ARROW} "
}

_chpwd_refresh() {
  _git_info
  _venv_info
}

add-zsh-hook precmd _set_prompt
add-zsh-hook chpwd  _chpwd_refresh
