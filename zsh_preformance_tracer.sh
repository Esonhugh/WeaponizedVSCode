zsh_trace_start() {
    echo "starting zsh tracing"
    # set the trace prompt to include seconds, nanoseconds, script name and line number
    # This is GNU date syntax; by default Macs ship with the BSD date program, which isn't compatible
    if [[ $ZSH_VERSION > 4.3.11 ]]; then
        zmodload zsh/datetime
        setopt promptsubst
        export PS4='+$EPOCHREALTIME %N:%i> '
    else
        export PS4='+$(date "+%s:%N") %N:%i> '
    fi
    # save file stderr to file descriptor 3 and redirect stderr (including trace 
    # output) to a file with the script's PID as an extension
    exec 3>&2 2>/tmp/startlog.$$
    # set options to turn on tracing and expansion of commands contained in the prompt
    setopt xtrace prompt_subst
    trap 'setopt xtrace' EXIT
}

zsh_trace_end() {
    # turn off tracing
    unsetopt xtrace
    # restore stderr to the value saved in FD 3
    exec 2>&3 3>&-
    echo "zsh tracing done. See /tmp/startlog.$$"
    trap 'unsetopt xtrace' EXIT
}

