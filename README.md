# mosh
Just hosting a mosh built with SSH Agent Forwarding


https://github.com/keithw/mosh ->  https://github.com/keithw/mosh/issues/120 -> https://github.com/keithw/mosh/pull/583 -> https://github.com/kevinr/mosh.git

# how to reproduce (so you don't have to trust this blob)

    git clone https://github.com/kevinr/mosh.git && cd mosh && git checkout kevinr-ssh-agent-forwarding
or
    wget https://github.com/kevinr/mosh/archive/kevinr-ssh-agent-forwarding.zip && unzip kevinr-ssh-agent-forwarding.zip && cd mosh-kevinr-ssh-agent-forwarding/

## quick install dependencies

    sudo apt-get install --no-install-recommends build-essential devscripts libutempter-dev libncurses5-dev dh-autoreconf protobuf-compiler libprotobuf-dev pkg-config libutempter-dev zlib1g-dev libncurses5-dev libssl-dev

## build a .deb package


    dpkg-buildpackage -b -us -uc

# but if you do

    wget https://github.com/PAStheLoD/mosh/raw/master/mosh_1.2.4a-1_amd64.deb -O mosh.deb && sudo dpkg -i mosh.deb
