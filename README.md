ros-vnc-desktop
=========================

Modified from '[fcwu/docker-ubuntu-vnc-desktop](https://github.com/fcwu/docker-ubuntu-vnc-desktop)'

Docker image to provide HTML5 VNC interface with ros preinstalled

Quick Start
-------------------------

Run the docker image and open port `6080`

```
docker run -it --rm -p 6080:80 d4n1el/ros-vnc-desktop
```

Browse http://127.0.0.1:6080/

Connect with VNC Viewer and protect by VNC Password
------------------

Forward VNC service port 5900 to host by

```
docker run -it --rm -p 6080:80 -p 5900:5900 d4n1el/ros-vnc-desktop
```

Now, open the vnc viewer and connect to port 5900. If you would like to protect vnc service by password, set environment variable `VNC_PASSWORD`, for example

```
docker run -it --rm -p 6080:80 -p 5900:5900 -e VNC_PASSWORD=mypassword d4n1el/ros-vnd-desktop
```

A prompt will ask password either in the browser or vnc viewer.

License
==================

See the LICENSE file for details.
