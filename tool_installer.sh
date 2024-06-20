#!/bin/bash

# Function to check if Go and Python 3 are installed
check_requirments_and_install(){
    sudo apt update -y
    sudo apt upgrade -y
    sudo apt install -y libpcap-dev
        # Check if the 'lolcat' command is available
    if ! command -v lolcat &> /dev/null; then
        echo "lolcat is not installed. Installing lolcat..." | lolcat
    else
        echo "lolcat is installed." | lolcat
        lolcat --version | lolcat
    fi
    # Check if the 'go' command is available
    export PATH=$PATH:/usr/local/go/bin
    if command -v go &> /dev/null
    then
        echo "Go is installed" | lolcat
        go version
    else
        echo "Go is not installed. you can install from here ---> https://go.dev/doc/install" | lolcat
    exit 1
fi

    #checking is Git downloaded or not 
    if ! command -v git &> /dev/null; then
        echo "Git is not installed. now installing Git....." | lolcat
        sudo apt install -y git
    else
        echo "Git already installed " | lolcat
    fi

    #checking is pip3 installed or not
    if !command -v pip3 &> /dev/null; then
        echo "pip3 installed. Now installing pip3....." | lolcat
        sudo apt install -y python3-pip
    else
        echo "pip3 is already installed" | lolcat
    fi

    # Check if the 'python3' command is available
    if ! command -v python3 &> /dev/null; then
        echo "Python 3 is not installed. Installing Python 3..."
        sudo apt install -y python3
    else
        echo "Python 3 is installed."
        python3 --version
        # Add your next command here, for example:
        echo "Running the next command..."
    fi


    #checking is there Tools flder avaiable in the home directory if not then creating one
    TOOLS_DIR="$HOME/Tools"
    if [ -d "$TOOLS_DIR" ]; then
        echo "Tools directory already exists." | lolcat
    else
        echo "Tools directory does not exist. Creating Tools directory..." | lolcat
        mkdir "$TOOLS_DIR"
        echo "Tools directory created at $TOOLS_DIR." | lolcat
    fi
        # Function to check if the system is Kali or Ubuntu
        check_kali_or_ubuntu
    
}




#this functions checks is the system is kali or ubuntu 
check_kali_or_ubuntu(){
        if [ -f /etc/os-release ]; then
        . /etc/os-release
        if [ "$ID" = "kali" ]; then
            echo "The system is running Kali Linux." | lolcat
            #calling kali Linux for tool installetion 
            Tool_for_kali_linux
        elif [ "$ID" = "ubuntu" ]; then
            echo "The system is running Ubuntu." | lolcat
            #calling ubuntu for tool installetion
            Tool_for_ubuntu
        else
            echo -e "The system is not running Kali or Ubuntu. It is running $ID." | lolcat
            Tool_for_ubuntu
        fi
    else
        echo "Cannot determine the operating system." | lolcat
    fi
}



#function for tool installetion in kali 
Tool_for_kali_linux(){

    #checking is feroxbuster is installed or not
    if ! command -v feroxbuster &> /dev/null; then
        echo "feroxbuster is not installed. Installing feroxbuster..." | lolcat
        cd ~/Tools
        wget https://github.com/epi052/feroxbuster/releases/download/v2.10.4/x86_64-linux-feroxbuster.tar.gz
        tar -xf x86_64-linux-feroxbuster.tar.gz
        chmod +x feroxbuster
        sudo cp feroxbuster /bin
        cd ~/Tools
        rm -rf feroxbuster  x86_64-linux-feroxbuster.tar.gz
    else
        echo "feroxbuster is already installed..." | lolcat
    fi

    #checking if XSSstrike is downloaded or not 
    xsstrike_DIR="$HOME/Tools/XSStrike"
    if [ -d "$xsstrike_DIR" ]; then
        echo "Xsstrike is already installed path is ~/Tools/XSStrike." | lolcat
    else
        echo "XSStrike not installed. Now installing XSStrike...."
        cd Tools;git clone https://github.com/s0md3v/XSStrike.git
        cd XSStrike
        pip3 install -r requirements.txt
        chmod +x xsstrike.py
        echo "XSStrike is now installed in ~/Tools" | lolcat
    fi
    
    #checking if sqlmap installed or not 
    if ! command -v sqlmap &> /dev/null; then
        echo "sqlmap is not there. Now installng sqlmap..." | lolcat
        sudo apt install sqlmap
    else
        echo "sqlmap is already installed..." | lolcat
    fi

    #checking if ghauri is installed or not
    if ! command -v ghauri &> /dev/null; then
        echo "ghauri is not installed. Now installing ghauri...." | lolcat
        cd ~/Tools
        git clone https://github.com/r0oth3x49/ghauri.git
        cd ghauri
        pip3 install -r requirements.txt
        python3 setup.py build
        sudo python3 setup.py install
    else
        echo "ghauri is already installed " | lolcat 
    fi

    #checking if waymore installed or not 
    if ! command -v waymore &> /dev/null; then
        echo "waymore is not installed. Now installing waymore..." | lolcat
        cd ~/Tools
        git clone https://github.com/xnl-h4ck3r/waymore.git
        cd waymore/
        pip3 install -r requirements.txt
        python3 setup.py build
        sudo python3 setup.py install
    else 
        echo "waymore is already installed" | lolcat
    fi

    #checkinng if paramspider installed or not 
    if ! command -v paramspider &> /dev/null; then
        echo "paramspier is not installed. Now installing para,spider..." | lolcat
        cd ~/Tools
        git clone https://github.com/devanshbatham/ParamSpider.git
        cd ParamSpider/
        python3 setup.py build
        sudo python3 setup.py install
    else
        echo "paramspider is already installed.." | lolcat
    fi

    #checking if creepy crawler installed or not 
    ccreepyCrawler_DIR=$HOME/Tools/creepyCrawler
    if [ -d "$ccreepyCrawler" ]; then
        echo "creepyCrawler already exist" | lolcat
    else
        echo "Now installing creepyCrawler..." | lolcat
        cd ~/Tools
        git clone https://github.com/chm0dx/creepyCrawler.git
        cd creepyCrawler
        pip3 install -r requirements.txt
        chmod +x creepyCrawler.py
    fi

    #checkig if ffuf installed or not
    if ! command -v ffuf &> /dev/null; then
        echo "ffuf not installed. Now installing ffuf" | lolcat
        sudo apt install ffuf
    else
        echo "ffuf already installed..." | lolcat 
    fi

    #checking if SSRFmap installed or not 
    ssrf_DIR=$HOME/Tools/SSRFmap
    if [ -d "$ssrf_DIR" ]; then
        echo "SSRFmap already installed..." | lolcat
    else
        echo "SSRFmap Now installing...." | lolcat
        cd ~/Tools
        git clone https://github.com/swisskyrepo/SSRFmap.git
        cd SSRFmap
        pip3 install -r requirements.txt
        chmdo +x ssrfmap.py
    fi



install_go_tools
}


#ubuntu's Tools section
Tool_for_ubuntu(){
    sudo apt update
    sudo apt upgrade

    #feroxbuster
    if ! command -v feroxbuster &> /dev/null; then
        echo "feroxbuster is not installed. Installing feroxbuster..." | lolcat
        cd ~/Tools
        wget https://github.com/epi052/feroxbuster/releases/download/v2.10.4/x86_64-linux-feroxbuster.tar.gz
        tar -xf x86_64-linux-feroxbuster.tar.gz
        chmod +x feroxbuster
        sudo cp feroxbuster /bin
        cd ~/Tools
        rm -rf feroxbuster  x86_64-linux-feroxbuster.tar.gz
    else
        echo "feroxbuster is already installed..." | lolcat
    fi

    #XSSstrike 
    xsstrike_DIR="$HOME/Tools/XSStrike"
    if [ -d "$xsstrike_DIR" ]; then
        echo "Xsstrike is already installed path is ~/Tools/XSStrike." 
    else
        echo "XSStrike not installed. Now installing XSStrike...." | lolcat
        cd Tools;git clone https://github.com/s0md3v/XSStrike.git
        cd XSStrike
        pip3 install -r requirements.txt
        chmod +x xsstrike.py
        echo "XSStrike is now installed in ~/Tools" | lolcat
    fi

    #sqlmap 
    sqlmap_DIR="$HOME/Tools/sqlmap"
    if [ -d "$TOOLS_DIR" ]; then
        echo "sqlmap is already installed path is ~/Tools/sqlmap" | lolcat
    else
        echo "now installing sqlmap...." | lolcat
        cd ~/Tools
        git clone https://github.com/sqlmapproject/sqlmap.git
    fi

    #ghauri
    if ! command -v ghauri &> /dev/null; then
        echo "ghauri is not installed. Now installing ghauri...." | lolcat
        cd ~/Tools
        git clone https://github.com/r0oth3x49/ghauri.git
        cd ghauri
        pip3 install -r requirements.txt
        python3 setup.py build
        sudo python3 setup.py install
    else
        echo "ghauri is already installed " | lolcat 
    fi

    #checking if waymore installed or not 
    if ! command -v waymore &> /dev/null; then
        echo "waymore is not installed. Now installing waymore..." | lolcat
        cd ~/Tools
        git clone https://github.com/xnl-h4ck3r/waymore.git
        cd waymore/
        pip3 install -r requirements.txt
        python3 setup.py build
        sudo python3 setup.py install
    else 
        echo "waymore is already installed" | lolcat
    fi

    #checkinng if paramspider installed or not 
    if ! command -v paramspider &> /dev/null; then
        echo "paramspier is not installed. Now installing para,spider..." | lolcat
        cd ~/Tools
        git clone https://github.com/devanshbatham/ParamSpider.git
        cd ParamSpider/
        python3 setup.py build
        sudo python3 setup.py install
    else
        echo "paramspider is already installed.." | lolcat
    fi

    #checking if creepy crawler installed or not 
    ccreepyCrawler_DIR=$HOME/Tools/creepyCrawler
    if [ -d "$ccreepyCrawler_DIR" ]; then
        echo "creepyCrawler already exist" | lolcat
    else
        echo "Now installing creepyCrawler..." | lolcat
        cd ~/Tools
        git clone https://github.com/chm0dx/creepyCrawler.git
        cd creepyCrawler
        pip3 install -r requirements.txt
        chmod +x creepyCrawler.py
    fi

    #checkig if ffuf installed or not
    if ! command -v ffuf &> /dev/null; then
        echo "ffuf not installed. Now installing ffuf" | lolcat
        sudo apt install ffuf
    else
        echo "ffuf already installed..." | lolcat 
    fi

    #checking if SSRFmap installed or not 
    ssrf_DIR=$HOME/Tools/SSRFmap
    if [ -d "$ssrf_DIR" ]; then
        echo "SSRFmap already installed..." | lolcat
    else
        echo "SSRFmap Now installing...." | lolcat
        cd ~/Tools
        git clone https://github.com/swisskyrepo/SSRFmap.git
        cd SSRFmap
        pip install -r requirements.txt
        chmdo +x ssrfmap.py
    fi
    
    #seclists
    seclist_DIR=/usr/share/seclists
    if [ -d "$seclist_DIR" ]; then
        echo "seclist is already installed path is /usr/share/seclists" | lolcat
    else
        echo "Now Installing seclists...." | lolcat
        cd ~/Tools
        git clone https://github.com/danielmiessler/SecLists.git
        mv SecLists seclists
        sudo cp -r seclists /usr/share
        rm -rf seclists
    fi

    #metasploit
    if ! command -v msfvenom &> /dev/null; then
        echo "Now installing metasploit...." | lolcat
        cd ~/Tools
        curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > msfinstall && chmod 755 msfinstall && ./msfinstall
    else
        echo metasploit is already installed
    fi


# calling go tool for installetion
install_go_tools
}



#<---------------------------------------------------------GO Tools-------------------------------------------------->


    #dalfox 
    install_go_tools(){
# Function to install a tool if it's not already installed
install_tool_if_needed() {
    local tool_name=$1
    local install_command=$2
    if ! command -v $tool_name &> /dev/null; then
        echo "$tool_name is not installed. Now installing $tool_name....." | lolcat
        eval $install_command
    else
        echo "$tool_name is already installed" | lolcat
    fi
}

# Install each tool
install_tool_if_needed "dalfox" "go install github.com/hahwul/dalfox/v2@latest"
install_tool_if_needed "subfinder" "go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest"
install_tool_if_needed "nuclei" "go install -v github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest"
install_tool_if_needed "waybackurls" "go install -v github.com/tomnomnom/waybackurls@latest"
install_tool_if_needed "httpx" "go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest"
install_tool_if_needed "assetfinder" "go install github.com/tomnomnom/assetfinder@latest"
install_tool_if_needed "gau" "go install github.com/lc/gau/v2/cmd/gau@latest"
install_tool_if_needed "gf" "go install github.com/tomnomnom/gf@latest && cd ~/Tools && git clone https://github.com/Sherlock297/gf_patterns.git && cd gf_patterns/ && mkdir -p ~/.gf && cp *.json ~/.gf && gf -list"
install_tool_if_needed "dnsx" "go install -v github.com/projectdiscovery/dnsx/cmd/dnsx@latest"
install_tool_if_needed "naabu" "go install github.com/projectdiscovery/naabu/v2/cmd/naabu@latest"
install_tool_if_needed "kxss" "go install github.com/Emoe/kxss@latest"

echo "All installations are complete." | lolcat

#calling copy tools in bin
copy_tools_bin
}

#function to copy files into bin file
copy_tools_bin(){
    # Define source and destination directories
    SOURCE_DIR="$HOME/go/bin"
    DEST_DIR="/bin"
    
    # Check if the source directory exists
    if [ -d "$SOURCE_DIR" ]; then
        echo "Source directory $SOURCE_DIR exists." | lolcat
        
        # Copy all files from source to destination
        echo "Copying all files from $SOURCE_DIR to $DEST_DIR..."
        sudo cp "$SOURCE_DIR"/* "$DEST_DIR/"
        echo "Copying completed." | lolcat 
    else
        echo "Source directory $SOURCE_DIR does not exist. Please ensure Go binaries are installed." | lolcat
    fi
}

# Call the function
check_requirments_and_install
