#!/bin/bash

mkdir /root/tool

sudo apt-get update

sudo apt-get install -y libcurl4-openssl-dev
sudo apt-get install -y libssl-dev
sudo apt-get install -y jq
sudo apt-get install -y ruby-full
sudo apt-get install -y libcurl4-openssl-dev libxml2 libxml2-dev libxslt1-dev ruby-dev build-essential libgmp-dev zlib1g-dev
sudo apt-get install -y xargs
sudo apt install -y python3
sudo apt install -y pipx 
pipx ensurepath

echo "installing bash_profile aliases from recon_profile"
git clone https://github.com/nahamsec/recon_profile.git
cd recon_profile
cat bash_profile >> ~/.bash_profile
source ~/.bash_profile
echo "done"

# Install dependencies
sudo apt-get install -y python3 python3-pip python3-venv git curl unzip

wget https://golang.org/dl/go1.22.4.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go1.22.4.linux-amd64.tar.gz
echo 'export GOPATH=$HOME/go' >> ~/.bashrc
echo 'export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin' >> ~/.bashrc
echo 'export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin' >> ~/.profile
source ~/.profile
source ~/.bashrc
	

# Download Go
# sudo rm -rf /usr/local/go
# wget https://golang.org/dl/go1.22.4.linux-amd64.tar.gz
# sudo tar -C /usr/local -xzf go1.22.4.linux-amd64.tar.gz
# echo 'export GOPATH=$HOME/go' >> ~/.bashrc
# echo 'export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin' >> ~/.bashrc
# source ~/.bashrc
# go version

# Install subdomain script 

# Install assetfinder
go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
sudo cp ~/go/bin/subfinder /usr/bin/
export PATH=$PATH:$(go env GOPATH)/bin

# Install httprobe and httpx
echo "Installing httprobe..."
go install github.com/tomnomnom/httprobe@latest
sudo cp ~/go/bin/httprobe /usr/bin/

echo "Installing httpx..."
go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest
sudo cp ~/go/bin/httpx /usr/bin/

echo "Installing gobuster..."
go install github.com/OJ/gobuster/v3@latest
sudo cp ~/go/bin/gobuster /usr/bin/

echo "Installing dirsearch..."
pipx install git+https://github.com/maurosoria/dirsearch.git
pipx ensurepath

# Install url script 
echo "Installing katana..."
go install github.com/projectdiscovery/katana/cmd/katana@latest
sudo cp ~/go/bin/katana /usr/local/bin/

pipx install git+https://github.com/xnl-h4ck3r/waymore.git	
pipx ensurepath


# Install port scan

echo "Installing nmap..."
sudo apt install nmap -y

echo "Installing naabu..."
apt install -y libpcap-dev 
go install -v github.com/projectdiscovery/naabu/v2/cmd/naabu@latest
sudo cp ~/go/bin/naabu /usr/bin/

echo "Installing gf..."
go install github.com/tomnomnom/gf@latest
sudo cp go/bin/gf /bin/
git clone https://github.com/1ndianl33t/Gf-Patterns
mkdir .gf
mv ~/Gf-Patterns/*.json ~/.gf

# install paramspider 
pipx install git+https://github.com/devanshbatham/ParamSpider.git
pipx ensurepath

# install uro
pipx install git+https://github.com/s0md3v/uro.git
pipx ensurepath

# install hive (fast scanner for checking live urls)
pipx install git+https://github.com/gnebbia/halive.git
pipx runpip halive install requests

apt-get install nano

# Create or overwrite the .gau.toml file with the configuration
echo "$CONFIG_CONTENT" > "$GAU_TOML_PATH"

CONFIG_CONTENT=$(cat <<EOF
FILTER_CODE: 404,301,302
FILTER_MIME: text/css,image/jpeg,image/jpg,image/png,image/svg+xml,image/gif,image/tiff,image/webp,image/bmp,image/vnd,image/x-icon,image/vnd.microsoft.icon,font/ttf,font/woff,font/woff2,font/x-woff2,font/x-woff,font/otf,audio/mpeg,audio/wav,audio/webm,audio/aac,audio/ogg,audio/wav,audio/webm,video/mp4,video/mpeg,video/webm,video/ogg,video/mp2t,video/webm,video/x-msvideo,video/x-flv,application/font-woff,application/font-woff2,application/x-font-woff,application/x-font-woff2,application/vnd.ms-fontobject,application/font-sfnt,application/vnd.android.package-archive,binary/octet-stream,application/octet-stream,application/pdf,application/x-font-ttf,application/x-font-otf,video/webm,video/3gpp,application/font-ttf,audio/mp3,audio/x-wav,image/pjpeg,audio/basic,application/font-otf,application/x-ms-application,application/x-msdownload,video/x-ms-wmv,image/x-png,video/quicktime,image/x-ms-bmp,font/opentype,application/x-font-opentype,application/x-woff,audio/aiff
FILTER_URL: .css,.jpg,.jpeg,.png,.svg,.img,.gif,.mp4,.flv,.ogv,.webm,.webp,.mov,.mp3,.m4a,.m4p,.scss,.tif,.tiff,.ttf,.otf,.woff,.woff2,.bmp,.ico,.eot,.htc,.rtf,.swf,.image,/image,/img,/css,/wp-json,/wp-content,/wp-includes,/theme,/audio,/captcha,/font,node_modules,/jquery,/bootstrap
FILTER_KEYWORDS: admin,login,logon,signin,signup,register,registration,dash,portal,ftp,panel,.js,api,robots.txt,graph,gql,config,backup,debug,db,database,git,cgi-bin,swagger,zip,.rar,tar.gz,internal,jira,jenkins,confluence,atlassian,okta,corp,upload,delete,email,sql,create,edit,test,temp,cache,wsdl,log,payment,setting,mail,file,redirect,chat,billing,doc,trace,ftp,gateway,import,proxy,dev,stage,stg,uat,sonar.ci.,.cp.
URLSCAN_API_KEY: 71e965fc-8173-4038-8469-db2e284bbf69
VIRUSTOTAL_API_KEY: 416831de42328f797f483af38bd172bea6039adad6c95dcc58e4d16ba323b389
CONTINUE_RESPONSES_IF_PIPED: True
WEBHOOK_DISCORD: YOUR_WEBHOOK
DEFAULT_OUTPUT_DIR:
EOF
)

# Path to the config.yml file
CONFIG_YML_PATH="$HOME/config.yml"

# Check if the file exists, if not, create it and add the configuration
if [ ! -f "$CONFIG_YML_PATH" ]; then
  echo "File $CONFIG_YML_PATH does not exist. Creating and adding configuration."
  echo "$CONFIG_CONTENT" > "$CONFIG_YML_PATH"
else
  echo "File $CONFIG_YML_PATH exists. Overwriting with new configuration."
  echo "$CONFIG_CONTENT" > "$CONFIG_YML_PATH"
fi

install paramspider 
cd /root/
sudo apt install python3-venv
git clone https://github.com/0xKayala/ParamSpider.git
# cd /root/ParamSpider
python3 -m venv venv
source venv/bin/activate
pip3 install -r /root/ParamSpider/requirements.txt
source venv/bin/activate
deactivate

chmod +x /root/main/url_find.sh /root/main/information.sh /root/main/run_screen.sh 





