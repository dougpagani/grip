alias ghi='tmux new-window -d -n "GHI_ISSUE_VIEWER" "grip --browser"; \ghi open'
git config ghi.repo dougpagani/grip

alias ghi=ghi-gfmd-enhanced
function ghi-gfmd-enhanced() {
    case "$1" in
        open)
            file='./.git/GHI_ISSUE'
            ;;
        edit)
            file="./.git/GHI_ISSUE_${2}"
            ;;
        *)
            \ghi "$@"
            return
    esac

    # Go to toplevel
    cd $(git rev-parse --show-toplevel)

    # Create the file so grip doesnt immediately error-out
    #touch "$file"
    local url='http://localhost:6419';
    local tabid ref;

    # Kick off the pane, but wait a bit so grip finds a file
    if ( which -s chrome-cli ); then
        ref=$(tmux new-window -P -d -n "GHI_ISSUE_VIEWER" "grip $file")
        sleep 0.5;
        tabid=$(chrome-cli open "$url" | grep Id | awk '{print $2}');
    else
        ref=$(tmux new-window -P -d -n "GHI_ISSUE_VIEWER" "grip --browser ./.git/GHI_ISSUE")
    fi
    # start editing
    (sleep 0.5; chrome-cli reload -t $tabid) &
    (sleep 2; chrome-cli reload -t $tabid) &
    \ghi "$@"
    # kill the pane
    tmux kill-pane -t "$ref" &> /dev/null;
    if ( which -s chrome-cli ); then
        chrome-cli close -t $tabid;
    else
        echo "chrome-cli is not found; close your tab manually";
    fi
    # 
}

