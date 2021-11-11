#! /bin/bash

python= python3 --version	#check for python
pip= pip3 --version		#check for pip  	
venv= virtualenv --version	#check for virtualenv

if  [ ! python ]
then
	echo "python3 not installed"
	sudo apt install -y python3
	echo "installed python3"
	printf "\n"
fi

if [ ! pip ]
then
	echo "pip3 not installed"
	sudo apt-get -y install python3-pip
	echo "installed pip3"
	printf "\n"

fi

if [ ! venv ]
then
	echo "virtual environment not installed"
	pip3 install virtualenv
	echo "installed virtual environment"
	printf "\n"
fi

# create virtualenv as venv
virtualenv venv

# activate venv
echo 'Activating virtualenv venv'
source ./venv/bin/activate
echo 'Activated venv'

# installing the dependencies 
pip3 install -r ./requirements.txt

function argParser(){
    unset url
    ARGS=""
    
    VALID_ARGS=$(getopt -o u:,s --long url:,http_server -- "$@")
    if [[ $? -ne 0 ]]; then
        exit 1;
    fi
    
    eval set -- "$VALID_ARGS"
    while [ : ]; do
        case "$1" in
            -u | --url)
                ARGS="$ARGS $1 $2"
                url=$1
                shift 2
            ;;
            -s | --http_server)
                ARGS="$ARGS $1"
                shift
            ;;
            --) shift;
                break
            ;;
        esac
    done
    
    # exit on missing url
    : ${url:?Missing --url}
    
    echo $ARGS
}


function runPythonFile(){
	
	python3 ./pythonfile.py $@ 

}

function index(){
	
	FLAGS=$(argParser $@)
	echo $FLAGS
	runPythonFile $FLAGS 

}


index $@
