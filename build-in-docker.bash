# for making sure you can bootstrap docker containers fast
# use apt-cacher-ng (on a host as 172.17.42.1, or on a dedicated IP somewhere in your network)
# 
#   sudo docker run --name='apt-cacher-ng' -d -p 3142:3142 -v /opt/apt-cacher-ng:/var/cache/apt-cacher-ng sameersbn/apt-cacher-ng:latest 
#
echo 'HEAD / ' | nc 172.17.42.1 3142  && echo 'Acquire::http { Proxy "http://172.17.42.1:3142"; };' > /etc/apt/apt.conf.d/01proxy

apt-get update
apt-get install -y --no-install-recommends \
	wget unzip build-essential devscripts dh-autoreconf \
	protobuf-compiler libprotobuf-dev pkg-config libutempter-dev zlib1g-dev libncurses5-dev libssl-dev

wget --no-check-certificate https://github.com/kevinr/mosh/archive/kevinr-ssh-agent-forwarding.zip && \
unzip kevinr-ssh-agent-forwarding.zip && \
cd mosh-kevinr-ssh-agent-forwarding/ 


if [[ $(g++ --version | grep 4.9 | wc -l ) = 1 ]] ; then
	apt-get install g++-4.8
	CXX=g++-4.8 dpkg-buildpackage -uc -us -b
else
	dpkg-buildpackage -uc -us -b
fi

mv ../mosh*.deb /opt/

