export PATH=$PATH:/opt/homebrew/bin:/Users/ehwan/Library/Python/3.8/bin
export LIBRARY_PATH=/opt/homebrew/lib
export INCLUDE_PATH=/opt/homebrew/include:/usr/local/include
export LANG=en_US.UTF-8
export EPP_FLAGS="\
-std=c++14 \
-I /Users/ehwan/Documents/workspace/includes \
-I /opt/homebrew/include \
"
export EPP11_FLAGS="\
-std=c++11 \
-I /Users/ehwan/Documents/workspace/includes \
"
function e++()
{
	eval "clang++ $EPP_FLAGS -o main.out $@"
}
function e++11()
{
	eval "clang++ $EPP11_FLAGS -o main.out $@"
}
alias matlab='/Applications/MATLAB_R2019a.app/bin/matlab -nodesktop -nodisplay -nosplash'
#alias e++='clang++ ${EPP_FLAGS} -o main.out'
alias ecc='clang -std=c99 -o main.out'
alias python='python3'

export SOURCEKIT_TOOLCHAIN_PATH="/Library/Developer/Toolchains/swift-latest.xctoolchain/"

export ZSH_THEME="theunraveler"

export EDITOR="nvim"

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

export FZF_BASE=/usr/local/opt/fzf
#export DISABLE_FZF_KEY_BINDINGS="true"
export CED=red99.ced.cei.uec.ac.jp

plugins=( fzf )

HISTSIZE=128
SAVEHIST=256
