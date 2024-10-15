export PATH=$PATH:/opt/homebrew/bin:/Users/ehwan/workspace/PythonVEnv/bin
export LIBRARY_PATH=/opt/homebrew/lib
export INCLUDE_PATH=/opt/homebrew/include:/usr/local/include

export LANG=en_US.UTF-8

export EDITOR="nvim"

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

export EPP_FLAGS="\
-std=c++17 \
-I /Users/ehwan/Documents/workspace/includes \
-I /opt/homebrew/include \
"
function e++()
{
	eval "clang++ $EPP_FLAGS -o main.out $@"
}

alias python='~/workspace/PythonVEnv/bin/python3'
alias pip='~/workspace/PythonVEnv/bin/pip3'

alias ls='lsd'
alias ll='ls -la'
alias la='ls -a'
alias l='ls -l'

#source ~/workspace/Setting/zsh-autosuggestions/zsh-autosuggestions.zsh
#ZSH_AUTOSUGGEST_STRATEGY = (completion history)
#bindkey '^ '   complete-word       # tab          | complete
#bindkey '^ '   autosuggest-accept  # ctrl + space | autosuggest
#bindkey '^I'   autosuggest-accept  # tab | autosuggest

HISTSIZE=128
SAVEHIST=256

eval "$(starship init zsh)"
