findandkill() {
    force_terminate=0
    while getopts f: opt
    do
        case $opt in
            f)
                force_terminate=1
                ;;
        esac
    done

    if [$force_terminate -eq 1]
    then
        lsof -i TCP:$1 | awk '/LISTEN/{print $2}' | xargs kill -9
        echo "$1 process terminated"
        exit
    fi

    lsof -i TCP:$1 | awk '/LISTEN/{print $2}'
    echo "Would you like to kill this process (y/n)?"
    read res
    if [[$res = "y"]]
    then
        lsof -i TCP:$1 | awk '/LISTEN/{print $2}' | xargs kill -9
    fi
}
