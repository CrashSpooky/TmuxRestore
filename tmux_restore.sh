#!/bin/bash
# A nice little script to setup a tmux session

# Sets the sessions name
eval SESSION="${USER}_tmux"

# Loop to checks to see if the session running, if it is then we attach, else we build a new session
if ps -ef | grep -v grep | grep $SESSION ; then
        tmux attach -t  $SESSION

else

tmux -2 new-session -d -s $SESSION

######################################################
# Default new window named window_1 split into 4 panes 
tmux new-window -t $SESSION:1 -n 'window_1'
tmux split-window -h
tmux select-pane -t 0
tmux split-window -v
tmux select-pane -t 2
tmux split-window -v

# Tests pane 0
tmux select-pane -t 0
tmux send-keys "echo "This is pane 0"" C-m

# Tests pane 1
tmux select-pane -t 1
tmux send-keys "echo "This is pane 1"" C-m

# Tests pane 2
tmux select-pane -t 2
tmux send-keys "echo "This is pane 2"" C-m

# Tests pane 3
tmux select-pane -t 3
tmux send-keys "echo "This is pane 3"" C-m

######################################################
# Default new window named window_2 split into 3 panes 
tmux new-window -t $SESSION:2 -n 'Logs'
tmux split-window -h
tmux select-pane -t 1
tmux split-window -v

# Tests pane 0
tmux select-pane -t 0
tmux send-keys "multitail /var/log/syslog /var/log/auth.log" C-m

# Tests pane 1
tmux select-pane -t 1
tmux send-keys  "htop" C-m

# Tests pane 2
tmux select-pane -t 2
tmux send-keys "multitail /var/log/fail2ban.log" C-m
######################################################


# Set default window
tmux select-window -t $SESSION:1+2

# Attach to session
tmux -2 attach-session -t $SESSION

fi
