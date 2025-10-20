# put myzshrc.sh execution at the end of zshrc

# Settings
CUDA_HOME=/usr/local/cuda
HOMEBREW_HOME=/opt/homebrew

MY_INCLUDE=/usr/local/include
MY_LIB=/usr/local/lib

MY_PYTHON_VENV_DIR="$HOME/workspace/PythonVEnv"

# for linux
if [ "$(uname)" = "Linux" ]; then
	# cuda
	MY_PATH=$CUDA_HOME/bin
	MY_INCLUDE=$MY_INCLUDE:$CUDA_HOME/include
	MY_LIB=$MY_LIB:$CUDA_HOME/lib64

# for macOS
elif [ "$(uname)" = "Darwin" ]; then
	# homebrew
	MY_PATH=$HOMEBREW_HOME/bin
	MY_INCLUDE=$MY_INCLUDE:$HOMEBREW_HOME/include
	MY_LIB=$MY_LIB:$HOMEBREW_HOME/lib

else
	echo "[ERROR] myzshrc.sh: Unknown OS!"
fi

# python
if [ -d "$MY_PYTHON_VENV_DIR" ]; then
    MY_PATH=$MY_PATH:$MY_PYTHON_VENV_DIR
    alias python='$MY_PYTHON_VENV_DIR/bin/python3'
    alias pip='$MY_PYTHON_VENV_DIR/bin/pip3'
else
    echo "Error: python venv '$MY_PYTHON_VENV_DIR' NOT EXIST."
    echo "Run 'python3 -m venv $MY_PYTHON_VENV_DIR' to create one."
fi


if command -v lsd &> /dev/null; then
    alias ls='lsd'
else
    echo "Error: 'lsd' command NOT FOUND. Alias 'ls' not set."
fi
alias ll='ls -la'
alias la='ls -a'
alias l='ls -l'

export PATH=$PATH:$MY_PATH
export LIBRARY_PATH=$LIBRARY_PATH:$MY_LIB
export INCLUDE_PATH=$INCLUDE_PATH:$MY_INCLUDE

export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

export EDITOR="nvim"

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

export EPP_FLAGS="\
-std=c++17 \
"
function e++()
{
	eval "clang++ $EPP_FLAGS -o main.out $@"
}


#source ~/workspace/Setting/zsh-autosuggestions/zsh-autosuggestions.zsh
#ZSH_AUTOSUGGEST_STRATEGY = (completion history)
#bindkey '^ '   complete-word       # tab          | complete
#bindkey '^ '   autosuggest-accept  # ctrl + space | autosuggest
#bindkey '^I'   autosuggest-accept  # tab | autosuggest

HISTSIZE=128
SAVEHIST=256

eval "$(starship init zsh)"
