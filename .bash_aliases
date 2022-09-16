alias profile="source $HOME/.profile"
alias edprofile="vim $HOME/.bash_aliases"
today=$(date +'%d-%B-%y')
alias del="rm -rf '$@'"
alias update="sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get autoremove -y"
countuniq(){ cat "$@" | sort -u | wc -l ; }
count(){ cat "$@" | wc -l ; }
user_agent="curl/7.68.0"
user_agent_header="User-Agent: curl/7.68.0"


##---------------------Tools----------------------------
linkfinder(){
	python3 $HOME/tools/LinkFinder/linkfinder.py -d -i $1 -o cli -r "^/"
}

am(){
    amass enum -src -d $1
}

dirsearch(){
    python3 $HOME/tools/dirsearch/dirsearch.py -u $1 -w $2 --config=$HOME/.config/config.ini
}

