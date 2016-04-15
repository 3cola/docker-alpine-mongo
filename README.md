Forked from [mvertes/dokcer-alpine-mongo](https://github.com/mvertes/docker-alpine-mongo)

# docker-alpine-mongo

This repository contains Dockerfile for [MongoDB 3.2](https://www.mongodb.org)
container, based on the [Alpine 3.3](https://hub.docker.com/_/alpine/) image.

Why ? the official mongo image size: 317 MB, alpine-mongo: 133 MB

## Install

As a prerequisite, you need [Docker](https://docker.com) to be installed.

To download this image from the public docker hub:

	$ docker pull 3cola/alpine-mongo

To re-build this image from the dockerfile:

	$ docker build -t 3cola/alpine-mongo .

## Usage

To run `mongod`:

	$ docker run -d --name mongo_1 -p 27017:27017 3cola/alpine-mongo

Or do not expose port and use a link in the container that need a connection to the db...

You can also specify the database repository where to store the data
with the volume -v option:

	$ docker run -d --name mongo_1 -p 27017:27017 \
	  -v /somewhere/onmyhost/mydatabase:/data/db \
	  3cola/alpine-mongo

and with the authentication on (for production):

	$ docker run -d --name mongo_1 3cola/alpine-mongo --auth

to create the first admin user:

	$ docker exec -it mongo_1 mongo admin
	> db.createUser({ user: "admin", pwd: "myPassw0rd", roles: [ { role: "userAdminAnyDatabase", db: "admin" } ] })

to create a user and its db:

	$ docker exec -it mongo_1 sh
	$ mongo -u "admin" -p "myPassw0rd" --authenticationDatabase "admin" myDb
	> db.createUser({ user: "myUser", pwd: "123Soleil", roles: [ { role: "dbOwner", db: "myDb" } ] })

Now, on the same host where the mongodb container is running, to trace
database network activity in real-time:

	$ docker exec -ti mongo_1 mongosniff

To run a shell session:

    $ docker exec -ti mongo_1 sh

To use the mongo shell client:

	$ docker exec -ti mongo_1 mongo

The mongo shell client can also be run its own container:

	$ docker run -ti --rm --name mongoshell-volatile 3cola/alpine-mongo mongo host:port/db

or with a link

	$ docker run -ti --rm --name mongoshell-volatile --link "mongo_1:db" 3cola/alpine-mongo mongo db/myDb

## Limitations

- On MacOSX, volumes located in a virtualbox shared folder are not
  supported, due to a limitation of virtualbox (default docker-machine
  driver) not supporting fsync().
