alias ls='ls --color=auto'
alias c='clear'
alias ..='cd ..'
alias ...='cd ../..'
alias e='nvim'
alias grep='grep --color=auto'
alias la='ls -a'

#COLOR_RESET="\[\033[0m\]"
#COLOR_BLUE="\[\033[0;34m\]"     # For current working directory
#COLOR_ARROW="\[\033[0;32m\]"    # Green arrow
#COLOR_BASH_INDICATOR="\[\033[0;33m\]" # Yellow (bash) indicator
#
## Build the PS1 string directly
## First line: Current directory in blue
## Second line: Yellow (bash) indicator + Static green arrow
#PS1="${COLOR_BLUE}\w${COLOR_RESET}\n${COLOR_BASH_INDICATOR}(bash)${COLOR_RESET} ${COLOR_ARROW}→${COLOR_RESET} "

# Define color codes
COLOR_RESET="\[\033[0m\]"
COLOR_BLUE="\[\033[0;34m\]"     # For current working directory
COLOR_GREEN="\[\033[0;32m\]"    # For success arrow
COLOR_RED="\[\033[0;31m\]"      # For failure arrow
COLOR_BASH_INDICATOR="\[\033[0;33m\]" # Yellow (bash) indicator

# Function to dynamically set the main part of the prompt
set_bash_prompt() {
    local LAST_COMMAND_STATUS="$?" # Get the exit status of the *last* command
    local ARROW_COLOR=""
    local ARROW_SYMBOL="→"

    if [ "$LAST_COMMAND_STATUS" -eq 0 ]; then
        ARROW_COLOR="$COLOR_GREEN"
    else
        ARROW_COLOR="$COLOR_RED"
    fi

    # This part ensures the prompt always starts on a fresh line, without adding an extra blank line.
    # It moves the cursor to the end of the current line, then back to the start (effectively new line).
    # We need to wrap the printf in `\[ \]` because its output manipulates the cursor but is not visible.
    local PRE_PROMPT_NEWLINE="\[$(printf "%$((`tput cols`-1))s\r")\]"

    # Now construct the PS1 using this pre-prompt newline part
    # First line: Current directory in blue
    # Second line: Yellow (bash) indicator + Dynamic green/red arrow
    PS1="${PRE_PROMPT_NEWLINE}${COLOR_BLUE}\w${COLOR_RESET}\n" # Note: \n for two-line prompt
    PS1+="${COLOR_BASH_INDICATOR}(bash)${COLOR_RESET} "
    PS1+="${ARROW_COLOR}${ARROW_SYMBOL}${COLOR_RESET} "
}

# PROMPT_COMMAND calls set_bash_prompt to update the prompt
PROMPT_COMMAND="set_bash_prompt"

## Define color codes
#COLOR_RESET="\[\033[0m\]"
#COLOR_BLUE="\[\033[0;34m\]"     # For current working directory
#COLOR_GREEN="\[\033[0;32m\]"    # For success arrow
#COLOR_RED="\[\033[0;31m\]"      # For failure arrow
#COLOR_BASH_INDICATOR="\[\033[0;33m\]" # Yellow (bash) indicator
#
## Function to dynamically set the prompt
#set_bash_prompt() {
#    local LAST_COMMAND_STATUS="$?" # Get the exit status of the *last* command
#    local ARROW_COLOR=""
#    local ARROW_SYMBOL="→"
#
#    if [ "$LAST_COMMAND_STATUS" -eq 0 ]; then
#        ARROW_COLOR="$COLOR_GREEN"
#    else
#        ARROW_COLOR="$COLOR_RED"
#    fi
#
#    # Build the PS1 string
#    # First line: Current directory in blue
#    # Second line: Yellow (bash) indicator + Dynamic green/red arrow
#    PS1="\n"
#    PS1+="${COLOR_BLUE}\w${COLOR_RESET}\n"
#    PS1+="${COLOR_BASH_INDICATOR}(bash)${COLOR_RESET} "
#    PS1+="${ARROW_COLOR}${ARROW_SYMBOL}${COLOR_RESET} "
#}
#
## PROMPT_COMMAND tells Bash to execute a command before each prompt is displayed.
## We use this to call our function to update PS1 with the correct exit status.
#PROMPT_COMMAND="set_bash_prompt"
