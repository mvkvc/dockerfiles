# dockerfiles

```
sudo passwd
su
git clone https://github.com/mvkvc/dockerfiles
chmod +x dockerfiles/install_nvidia.sh dockerfiles/install_docker.sh dockerfiles/monitor.sh
dockerfiles/install_nvidia.sh
shutdown -r now #Genesis Cloud
dockerfiles/install_docker.sh
cp dockerfiles/monitor.sh /tmp/monitor.sh #Google
cp dockerfiles/monitor.service /etc/systemd/system/monitor.service #Google
systemctl enable monitor.service #Google
shutdown -r now #Google
cp dockerfiles/.bash_aliases .bash_aliases
source .bash_aliases
```
