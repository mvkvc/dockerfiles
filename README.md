# dockerfiles

```
sudo passwd
su
git clone https://github.com/mvkvc/dockerfiles
chmod +x dockerfiles/install_nvidia.sh dockerfiles/install_docker.sh dockerfiles/monitor.sh
dockerfiles/install_nvidia.sh
# Genesis Cloud needs restart after Nvidia install
dockerfiles/install_docker.sh
# Skip for Genesis cloud, needs UI shutdown
cp dockerfiles/monitor.sh /tmp/monitor.sh
cp dockerfiles/monitor.service /etc/systemd/system/monitor.service
systemctl enable monitor.service
# Restart
cp dockerfiles/.bash_aliases .bash_aliases
source .bash_aliases && alias
```
