#!/bin/bash

apt-get install -y perl
apt-get install -y sudo
apt-get install -y wget
apt-get install -y ffmpeg
apt-get install -y unzip

pass=$(perl -e 'print crypt($ARGV[0], "password")' $password)
useradd -m -p "$pass" treewyn
usermod -aG sudo treewyn

mkdir /tmp/FACEIT_install
TMP_DIR="/tmp/FACEIT_install"
DL_CONDA="https://repo.anaconda.com/archive/Anaconda3-latest-Linux-x86_64.sh"
DL_FACEIT="https://slgodwyn:holliday954@github.com/slgodwyn/faceit2.git"
FACEIT="/home/treewyn/faceit2"
FACESWAP="${FACEIT}/faceswap"

CONDA_PATHS=("/opt" "/home/treewyn")
CONDA_NAMES=("/ana" "/mini")
CONDA_VERSIONS=("3" "2")
CONDA_BINS=("/bin/conda" "/condabin/conda")
DIR_CONDA="/home/treewyn/anaconda"
CONDA_EXECUTABLE="${DIR_CONDA}/bin/conda"
CONDA_TO_PATH=false
ENV_NAME="faceit"


    # Download and install Anaconda3
script_name='anaconda.sh'
env_path='/home/treewyn/anaconda'
# download the installation script
echo "Downloading conda installation script..."
curl $DL_CONDA -s -o $script_name
# create temporary conda installation
echo "conda installation..."
TMPDIR=$TMP_DIR bash $script_name -b -f -p $env_path >> /dev/null
rm $script_name

source $DIR_CONDA/etc/profile.d/conda.sh
$CONDA_EXECUTABLE init bash
exec $SHELL

cd /home/treewyn

$CONDA_EXECUTABLE create -n faceit python=3.8
$CONDA_EXECUTABLE activate faceit
$CONDA_EXECUTABLE install git
git clone --depth 1 --no-single-branch "$DL_FACEIT"
cd /home/treewyn/faceit2
pip install -r requirements.txt
python $FACESWAP/setup.py --installer --gpu
echo "export WORKSPACE="/home/treewyn/data/persons"" >> /home/treewyn/.bashrc
echo "export FACEIT_PYTHON="python3.8"" >> /home/treewyn/.bashrc
echo "export FACEIT="/home/treewyn/faceit2"" >> /home/treewyn/.bashrc
echo "export FACESWAP="/home/treewyn/faceit2/faceswap"" >> /home/treewyn/.bashrc

WORKSPACE="/home/treewyn/data/persons" 
FACEIT_PYTHON="python3.7" 
FACEIT="/home/treewyn/faceit2"
FACESWAP="/home/treewyn/faceit2/faceswap"


wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1RmcoRCJpjyCgoFqjYxmnNZ-FL6c5FLFK' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1RmcoRCJpjyCgoFqjYxmnNZ-FL6c5FLFK" -O $WORKSPACE/emily.mp4 && rm -rf /tmp/cookies.txt
