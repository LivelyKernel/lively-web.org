# Running [Lively Web](https://github.com/LivelyKernel/LivelyKernel) on Docker

## [Docker](http://www.docker.com/) setup on MacOS

First make sure you have [homebrew](http://brew.sh/) installed.

Docker on MacOS runs inside a [VirtualBox](https://www.virtualbox.org/) image, so please install VirtualBox as well. Since docker containers only run on Linux, the VirtualBox image will be used to host the containers on your system and runs the main docker application. In order to interact with docker you also need the boot2docker distribution. To install both run:

```sh
brew install docker boot2docker
```

Make sure the rest of your sytems can talk to the boot2docker distro:

```sh
echo 'export DOCKER_HOST=tcp://127.0.0.1:2375' >> ~/.bash_profile
```

Now initialize boot2docker:

```sh
boot2docker download
boot2docker init
boot2docker up
```

## Install and Run Lively

Using the Dockerfile in this repo you can now build and run Lively:

```sh
git clone https://github.com/LivelyKernel/lively-docker/
docker build --rm -t lively-server .
docker run -p 9001:9001 -i -t lively-server
```

Specifically for MacOS: Above command only forwards port 9001 from the Docker container to the boot2docker distro running in your VBox image. To also forward this port from VBox to your main machine run:

```sh
VBoxManage controlvm boot2docker-vm natpf1 "lively-server,tcp,127.0.0.1,9001,,9001"
```


<!--## Important-->
<!--Make sure objects.sqlite is existant`touch objects.sqlite` !!!-->

<!--Later, when lively started up you can get a "real" copy of the objects DB via-->
<!--`curl localhost:9001/objects.sqlite > objects.sqlite` and rebuild the server to-->
<!--have a shorter startup time.-->

<!--### Mac OS hint-->

<!--If you run docker via [boot2docker](https://github.com/boot2docker/boot2docker)-->
<!--then make sure you not only forward ports between the lively-server and the-->
<!--boot2docker environment but also between boot2docker and Mac OS:-->

<!--```sh-->
<!--VBoxManage controlvm boot2docker-vm natpf1 "lively-server,tcp,127.0.0.1,9001,,9001"-->
<!--```-->
