# Base16 Shell

# ----GENERAL
set -x EDITOR vim
set -x LC_ALL en_US.UTF-8

# ----NODE
set -x NODE_OPTIONS --max_old_space_size=4096

# --- GO
set -gx GOPATH $HOME/Proyects/go

set -g fish_user_paths "/usr/local/opt/imagemagick@6/bin" $fish_user_paths
