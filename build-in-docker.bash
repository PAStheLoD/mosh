# for making sure you can bootstrap docker containers fast
# use apt-cacher-ng (on a host as 172.17.42.1, or on a dedicated IP somewhere in your network)
#
#   sudo docker run --name='apt-cacher-ng' -d -p 3142:3142 -v /opt/apt-cacher-ng:/var/cache/apt-cacher-ng sameersbn/apt-cacher-ng:latest 
#
perl -e 'use IO::Socket::INET; $s = new IO::Socket::INET(PeerAddr => "172.17.42.1", PeerPort => "3142", Proto => "tcp", Timeout => 1) || die("no"); $s->send("HEAD /\r\n") || die("nono")' 2>/dev/null \
    && echo 'Acquire::http { Proxy "http://172.17.42.1:3142"; };' > /etc/apt/apt.conf.d/01proxy

apt-get update
apt-get install -y --no-install-recommends \
	wget unzip build-essential devscripts dh-autoreconf bash-completion \
	protobuf-compiler libprotobuf-dev pkg-config libutempter-dev zlib1g-dev libncurses5-dev libssl-dev

BALL=https://github.com/PAStheLoD/mosh-src/archive/ssh-agent-forwarding-ng.zip
wget --no-check-certificate $BALL -O ball.zip && \

D=$(unzip -l ball.zip  | grep -Po '(?: 0\s*[0-9: -]+\s*)\K[a-z0-9_-]+/$')
unzip ball.zip && cd $D


dch -v 1.9.99~$(lsb_release -cs) "added agent forwarding patch"

if [[ $(g++ --version | grep 4.9 | wc -l ) = 1 ]] ; then
	apt-get install -y g++-4.8
	CXX=g++-4.8 dpkg-buildpackage -uc -us -b || echo "Failed to build package :O"
else
	dpkg-buildpackage -uc -us -b || echo "Failed to build package :O"
fi


mv ../mosh*.deb /opt/

echo "Finished"

ls -alh /opt/
