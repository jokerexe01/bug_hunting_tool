#!/bin/bash

# Function to check and create Tools directory
check_and_create_tools_directory() {
    TOOLS_DIR="$HOME/Tools"
    if [ -d "$TOOLS_DIR" ]; then
        echo "Tools directory already exists." | lolcat
    else
        echo "Tools directory does not exist. Creating Tools directory..." | lolcat
        mkdir "$TOOLS_DIR"
        echo "Tools directory created at $TOOLS_DIR." | lolcat
    fi
}
# Check and create Tools directory if needed
check_and_create_tools_directory

#installing gf tool
go install github.com/tomnomnom/gf@latest
mkdir ~/.gf
cd ~/Tools
git clone https://github.com/Sherlock297/gf_patterns.git
cd gf_patterns
cp *.json ~/.gf
rm -rf ~/Tools/gf_patterns

#installing nuclie
go install -v github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest

# Install waybackurls
echo "Installing waybackurls..."
go install github.com/tomnomnom/waybackurls@latest
# Install subfinder
echo "Installing subfinder..."
go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest 

# Install dnsx
echo "Installing dnsx..."
go install -v github.com/projectdiscovery/dnsx/cmd/dnsx@latest 

# Install feroxbuster
cd ~/Tools
wget https://github.com/epi052/feroxbuster/releases/download/v2.10.4/x86_64-linux-feroxbuster.tar.gz
tar -xf x86_64-linux-feroxbuster.tar.gz
sudo cp feroxbuster /usr/bin

# Install httpx
echo "Installing httpx..."
go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest 

# Install dalfox
echo "Installing dalfox..."
go install github.com/hahwul/dalfox/v2@latest 

# Install assetfinder
echo "Installing assetfinder..."
go install github.com/tomnomnom/assetfinder@latest 

# Install ParamSpider
echo "Installing ParamSpider..."
cd ~/Tools
git clone https://github.com/devanshbatham/ParamSpider.git
cd ParamSpider
sudo python3 setup.py build
sudo python3 setup.py install
cd ..

# Install ffuf (Fuzz Faster U Fool)
echo "Installing ffuf..."
go install github.com/ffuf/ffuf@latest 

# Copy tools to /usr/bin
echo "Copying tools to /usr/bin..."
sudo cp ~/go/bin/{subfinder,httpx,dnsx,assetfinder,dalfox,waybackurls,nuclei,ffuf,gf} /usr/bin/


# Clone XSStrike
echo "Cloning XSStrike..."
cd ~/Tools
git clone https://github.com/s0md3v/XSStrike.git
cd XSStrike
sudo pip3 install -r requirements.txt
cd ..

# Download and install SecLists
read -p "Do you need to download SecLists for feroxbuster? (y/n): " answer

if [[ "$answer" == "y" ]]; then
    echo "Downloading SecLists..."
    wget -c https://github.com/danielmiessler/SecLists/archive/master.zip -O secLists.zip &
    wait # wait for the download to finish
    unzip secLists.zip
    rm -rf secLists.zip
    mv SecLists-master seclists
    sudo mv seclists /usr/share
    echo "SecLists has been downloaded and moved to /usr/share" | lolcat	
else
    echo "Skipping SecLists download..." | lolcat
    # Add the next commands you want to run here
fi

# Clone waymore tool
echo "Cloning and setting up waymore..."
cd ~/Tools
git clone https://github.com/xnl-h4ck3r/waymore.git
cd waymore
sudo pip3 install -r requirements.txt
sudo python3 setup.py build
sudo python3 setup.py install
cd ..

# Clone and set up sqlmap
echo "Cloning and setting up sqlmap..."
git clone https://github.com/sqlmapproject/sqlmap.git 

# Install Metasploit Framework
read -p "Do you need to download SecLists for feroxbuster? (y/n): " answer

if [[ "$answer" == "y" ]]; then
    echo "Downloading SecLists..."
    wget -c https://github.com/danielmiessler/SecLists/archive/master.zip -O secLists.zip &
    wait # wait for the download to finish
    unzip secLists.zip
    rm -rf secLists.zip
    mv SecLists-master seclists
    sudo mv seclists /usr/share
    echo "SecLists has been downloaded and moved to /usr/share"
else
    echo "Skipping SecLists download..."
fi

read -p "Do you need to install Metasploit Framework? (y/n): " answer | lolcat 

if [[ "$answer" == "y" ]]; then
    echo "Installing Metasploit Framework..." | lolcat
    curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > msfinstall
    chmod 755 msfinstall
    ./msfinstall
    echo "Metasploit Framework has been installed" | lolcat
else
    echo "Skipping Metasploit Framework installation..." | lolcat
fi

# Clone SSRFmap
SSRF_DIR="$HOME/Tools/SSRFmap"
if [ -d "$SSRF_DIR" ]; then
    echo "SSRFmap directory already exists. Skipping clone." | lolcat
else
    echo "Cloning SSRFmap..." | lolcat
    git clone https://github.com/swisskyrepo/SSRFmap.git "$SSRF_DIR"
    wait
    echo "SSRFmap has been cloned into $SSRF_DIR." | lolcat
fi
echo "Setup complete." | lolcat
