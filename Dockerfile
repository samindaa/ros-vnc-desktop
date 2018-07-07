FROM ros:kinetic
MAINTAINER Saminda <samindaa@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

# built-in packages
RUN apt-get update \
    && apt-get install -y --no-install-recommends software-properties-common curl \
    && sh -c "echo 'deb http://download.opensuse.org/repositories/home:/Horst3180/xUbuntu_16.04/ /' >> /etc/apt/sources.list.d/arc-theme.list" \
    && curl -SL http://download.opensuse.org/repositories/home:Horst3180/xUbuntu_16.04/Release.key | apt-key add - \
    && add-apt-repository ppa:fcwu-tw/ppa \
    && apt-get update \
    && apt-get install -y --no-install-recommends --allow-unauthenticated \
        supervisor \
        openssh-server pwgen sudo vim-tiny \
        net-tools \
        lxde x11vnc xvfb \
        gtk2-engines-murrine ttf-ubuntu-font-family \
        libreoffice firefox \
        fonts-wqy-microhei \
        language-pack-zh-hant language-pack-gnome-zh-hant firefox-locale-zh-hant libreoffice-l10n-zh-tw \
        nginx \
        python-pip python-dev build-essential \
        mesa-utils libgl1-mesa-dri \
        gnome-themes-standard gtk2-engines-pixbuf gtk2-engines-murrine pinta arc-theme \
        dbus-x11 x11-utils \
    && apt-get autoclean -y \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*

RUN rm -f /etc/apt/sources.list.d/arc-theme.list

# tini for subreap                                   
ENV TINI_VERSION v0.9.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /bin/tini
RUN chmod +x /bin/tini

ADD image /
RUN pip install setuptools wheel && pip install -r /usr/lib/web/requirements.txt

RUN ["/bin/bash", "-c", "echo '. /opt/ros/$ROS_DISTRO/setup.bash' >> /root/.bashrc"] 

RUN apt-get update && apt-get install -y --no-install-recommends --allow-unauthenticated \
  		      ros-kinetic-xacro \
		      ros-kinetic-gazebo-ros \
              ros-kinetic-controller-manager

RUN apt-get install -y --no-install-recommends --allow-unauthenticated vim terminator wget

RUN sh -c 'echo "deb http://packages.osrfoundation.org/gazebo/ubuntu-stable `lsb_release -cs` main" > /etc/apt/sources.list.d/gazebo-stable.list'
RUN wget http://packages.osrfoundation.org/gazebo.key -O - | sudo apt-key add -
RUN apt-get update && apt-get install -y --no-install-recommends --allow-unauthenticated \
                      gazebo7 libignition-math2-dev               

EXPOSE 80
WORKDIR /root
ENV HOME=/root \
    SHELL=/bin/bash
ENTRYPOINT ["/startup.sh"]
