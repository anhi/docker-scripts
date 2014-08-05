BALLaxy Docker Image
===================

This [Docker](http://www.docker.io) image allows to easily setup a 
[ballaxy](http://ball-trac.bioinf.uni-sb.de/ballaxy) instance.

It is based on Bjoern Gruening's docker images for galaxy.

The Image is based on [ubuntu/14.04](http://www.ubuntu.org/).


Usage (mostly taken from https://github.com/bgruening/docker-recipes)
=====================================================================

First, install docker (c.f. https://www.docker.io/gettingstarted/#h_installation)

After installing, all you need to do is:

``docker run -d -p 8080:80 anhi/ballaxy``

I will shortly explain the meaning of all the parameters. For a more detailed describtion please consult the [docker manual](http://docs.docker.io/), it's really worth reading.
Let's start: ``docker run`` will run the Image/Container for you. In case you do not have the Container stored locally, docker will download it for you. ``-p 8080:80`` will make the port 80 (inside of the container) available on port 8080 on your host. Inside the container a Apache Webserver is running on port 80 and that port can be bound to a local port on your host computer. With this parameter you can access your ballaxy instance via ``http://localhost:8080`` immediately after executing the command above. ``anhi/ballaxy`` is the Image/Container name, that directs docker to the correct path in the [docker index](https://index.docker.io/u/anhi/ballaxy/). ``-d`` will start the docker container in daemon mode. For an interactive session, you can execute:

``docker run -i -t -p 8080:80 anhi/ballaxy``

and run the ``` startup ``` script by your own, to start PostgreSQL, Apache and Galaxy.

Docker images are "read-only", all your changes inside one session will be lost after restart. This mode is usefull to present Galaxy to your collegues or to run workshops with it. To install Tool Shed respositories or to save your data you need to export the calculated data to the host computer.

Fortunately, this is as easy as:

``docker run -d -p 8080:80 -v /home/user/galaxy_storage/:/export/ anhi/ballaxy``

With the additional ``-v /home/user/galaxy_storage/:/export/`` parameter, docker will mount the folder ``/home/user/galaxy_storage`` into the Container under ``/export/``. A ``startup.sh`` script, that is usually starting Apache, PostgreSQL and Galaxy, will recognise the export directory with one of the following outcomes:

  - In case of an empty ``/export/`` directory, it will move the [PostgreSQL](http://www.postgresql.org/) database, the Galaxy database directory, Shed Tools and Tool Dependencies and various config scripts to /export/ and symlink back to the original location.
  - In case of a non-empty ``/export/``, for example if you continue a previouse session within the same folder, nothing will be moved, but the symlinks will be created.

This enables you to have different export folders for different sessions - means real separation of your different projects.


Support & Bug Reports
=====================

You can file an issue here https://github.com/anhi/ballaxy/issues or ask
us on the Galaxy development list http://lists.bx.psu.edu/listinfo/galaxy-dev


Licence (MIT)
=============

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
