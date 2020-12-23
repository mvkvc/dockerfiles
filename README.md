# dockerfiles

```
sudo passwd
su
git clone https://github.com/mvkvc/dockerfiles
chmod +x dockerfiles/install_nvidia.sh dockerfiles/install_docker.sh
# Genesis Cloud needs restart after Nvidia install
dockerfiles/install_nvidia.sh
dockerfiles/install_docker.sh
cp dockerfiles/.bash_aliases .bash_aliases
source .bash_aliases && source .bashrc
alias
```
