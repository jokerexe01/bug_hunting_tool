#!/bin/bash

# Function to display a spinner while a command is running
spinner() {
    local pid=$1
    local delay=0.1
    local spinstr='|/-\'
    while ps -p $pid > /dev/null; do
        local temp=${spinstr#?}
        printf " [%c]  " "$spinstr"
        local spinstr=$temp${spinstr%"$temp"}
        sleep $delay
        printf "\b\b\b\b\b\b"
    done
    printf "    \b\b\b\b"
}

# Function to display a rotating line animation
rotating_line() {
    local pid=$1
    local delay=0.2
    local spinstr='|/-\'
    while ps -p $pid > /dev/null; do
        printf " [%c] " "$spinstr"
        sleep $delay
        printf "\b\b\b\b"
        spinstr=$(echo "$spinstr" | sed 's/.$//')$(echo "$spinstr" | sed '$s/^.//')
    done
    printf "    \b\b\b\b"
}
#installing gf tool
go install github.com/tomnomnom/gf@latest
mkdir ~/.gf
cd ~/Tools
git clone https://github.com/Sherlock297/gf_patterns.git
cd gf_patterns
cp *.json ~/.gf
spinner $!

#installing nuclie
go install -v github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest

# Install waybackurls
echo "Installing waybackurls..."
go install github.com/tomnomnom/waybackurls@latest
spinner $!
# Install subfinder
echo "Installing subfinder..."
go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest &
spinner $!

# Install dnsx
echo "Installing dnsx..."
go install -v github.com/projectdiscovery/dnsx/cmd/dnsx@latest &
spinner $!

# Install feroxbuster
cd ~/Tools
wget https://github.com/epi052/feroxbuster/releases/download/v2.10.4/x86_64-linux-feroxbuster.tar.gz
tar -xf x86_64-linux-feroxbuster.tar.gz
chmod +x feroxbuster
sudo cp feroxbuster /usr/bin

# Install httpx
echo "Installing httpx..."
go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest &
spinner $!

# Install dalfox
echo "Installing dalfox..."
go install github.com/hahwul/dalfox/v2@latest &
spinner $!

# Install assetfinder
echo "Installing assetfinder..."
go install github.com/tomnomnom/assetfinder@latest &
spinner $!

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
go install github.com/ffuf/ffuf@latest &
rotating_line $!

# Copy tools to /usr/bin
echo "Copying tools to /usr/bin..."
sudo cp ~/go/bin/{subfinder,httpx,dnsx,assetfinder,dalfox,waybackurls,nuclei,ffuf,gf} /usr/bin/
spinner $!

# Clone XSStrike
echo "Cloning XSStrike..."
cd ~/Tools
git clone https://github.com/s0md3v/XSStrike.git
cd XSStrike
sudo pip3 install -r requirements.txt
cd ..

# Download and install SecLists
echo "Downloading SecLists..."
wget -c https://github.com/danielmiessler/SecLists/archive/master.zip -O secLists.zip &
spinner $!

unzip SecLists-master
rm -rf secLists.zip
mv SecLists-master seclists
sudo mv seclists /usr/share
spinner $!

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
git clone https://github.com/sqlmapproject/sqlmap.git &
spinner $!

# Install Metasploit Framework
echo "Installing Metasploit Framework..."
curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > msfinstall && chmod 755 msfinstall && ./msfinstall &
spinner $!

# Clone SSRFmap
echo "Cloning SSRFmap..."
git clone https://github.com/swisskyrepo/SSRFmap.git &
spinner $!
wait

echo "Setup complete."

