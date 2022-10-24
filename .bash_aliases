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
    amass enum -d $1 -o $1.txt
}

dsearch(){
    python3 $HOME/tools/dirsearch/dirsearch.py -u $1 -w $2 --config=$HOME/.config/config.ini
}

drble(){
    rot=$(echo $1 | unfurl format %r.%t)
    dom=$(echo $1 | unfurl format %d)
    x=$(date +'%I_%M_%S')
    mkdir -p $HOME/dirble_output/$rot/$dom
    dirble $1 -w $2 -t 40 -r -a "curl/7.68.0" -k -B 404 -o $HOME/dirble_output/$rot/$dom/$x.txt
}

ffuf_recursive(){
    rot=$(echo $1 | unfurl format %r.%t)
    dom=$(echo $1 | unfurl format %d)
    x=$(date +'%I_%M_%S')
    mkdir -p $HOME/ffuf_output/$rot/$dom
    ffuf -c -u $1/FUZZ -w $2 -H "User-Agent: curl/7.68.0" -recursion -recursion-depth 5 -mc 200,204,301,302,307,400,401,403,405,429,500,501,502 -fc 404 -ac -o $HOME/ffuf_output/$rot/$dom/$x.csv -of csv $3
    find $HOME/ffuf_output/$rot -name "*.csv" -type 'f' -size 114c -delete
    find $HOME/ffuf_output/$rot -empty -type d -delete
}

ffuf_cols(){
    rot=$(echo $1 | unfurl format %r.%t)
    dom=$(echo $1 | unfurl format %d)
    find $HOME/ffuf_output/$rot/$dom/ -type f -name '*.csv' | xargs cat | cut -d, -f2,4- | awk -F, 'BEGIN { OFS=FS }; { $1=substr($1, 1, 110); print }' | sort -t, -k4,4 -k2,2 -n -u | column -s, -t | vim -
}

