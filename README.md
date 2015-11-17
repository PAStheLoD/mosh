# mosh
Just hosting a mosh built with SSH Agent Forwarding


https://github.com/keithw/mosh ->  https://github.com/keithw/mosh/issues/120 -> https://github.com/keithw/mosh/pull/583 -> https://github.com/rinne/mosh/tree/ssh-agent-forwarding-ng

# how to reproduce (so you don't have to trust this blob)

    git clone https://github.com/rinne/mosh.git \
    && cd mosh \
    && git checkout ssh-agent-forwarding-ng
or
    wget https://github.com/rinne/mosh/archive/ssh-agent-forwarding.zip \
    && unzip ssh-agent-forwarding.zip \
    && cd mosh-ssh-agent-forwarding/

## quick install dependencies

    sudo apt-get install --no-install-recommends \
            build-essential devscripts libutempter-dev \
            libncurses5-dev dh-autoreconf protobuf-compiler \
            libprotobuf-dev pkg-config libutempter-dev \
            zlib1g-dev libncurses5-dev libssl-dev \
            g++-4.8 bash-completion

## build a .deb package

    CXX=g++-4.8 dpkg-buildpackage -b -us -uc

# Docker-fancy

    cat build-in-docker.bash | sudo docker run -i -v $(readlink -f ./mosh-deb):/opt ubuntu:15.10 bash -x

or using 14.04 (LTS)

    cat build-in-docker.bash | sudo docker run -i -v $(readlink -f ./mosh-deb):/opt ubuntu bash -x

# but if you do

    wget https://github.com/PAStheLoD/mosh/releases/download/1.2.4.95rc2-1.1/mosh_1.2.4.95rc2-1.1_amd64.deb -O mosh.deb \
    && sudo apt-get install -y mosh && sudo dpkg -i mosh.deb

# and don't forget to please the locale gods

## globally

    echo "export LC_ALL=C.UTF-8 ; export LANG=C.UTF-8 ;" > /tmp/lang
    cp /etc/bash.bashrc /etc/bash.bashrc.premosh
    cat /tmp/lang /etc/bash.bashrc > /etc/bash.bashrc.
    mv /etc/bash.bashrc. /etc/bash.bashrc


## per user

    echo "export LC_ALL=C.UTF-8 ; export LANG=C.UTF-8 ;" > /tmp/lang
    cp ~/.bashrc ~/.bashrc.premosh
    cat /tmp/lang ~/.bashrc > ~/.bashrc.
    mv ~/.bashrc. ~/.bashrc

