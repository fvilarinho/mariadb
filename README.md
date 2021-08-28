Synopsys
========

This a base image for the usage of a relational database.
It uses the `ghcr.io/fvilarinho/base-image` and [mariadb](https://mariadb.org/).
It also uses [flyway](https://flywaydb.org) to control the versions and states of the schemas.
The configurations/settings are defined using the JSON format and stored in the `etc` directory.
The scripts are stored in the `sql` directory and must follow the standard below:

- `V<sequence-number>__<name-of-the-script>.sql`

All scripts will be checked in the bootstrap and applied in the database if it wasn't yet.


Build status
============

![CI/CD](https://github.com/fvilarinho/mariadb/workflows/CI/CD/badge.svg)


How to use
==========

Just put the line below in your Dockerfile.

`FROM ghcr.io/fvilarinho/mariadb:1.1.0` - To use the last stable version.

`FROM ghcr.io/fvilarinho/mariadb:latest` - To use the development version.


License
=======

This image is licensed under the Apache 2.0. Please read the licence file or check the URL [https://www.apache.org/licenses/LICENSE-2.0.txt](https://www.apache.org/licenses/LICENSE-2.0.txt)


Author
======

My name is Felipe Vilarinho (A.K.A Vila) and you can know more about me at the social medias below:

1. [LinkedIn](https://br.linkedin.com/in/fvilarinho)

Or send an email to fvilarinho@gmail.com or fvilarinho@concepting.com.br

Have Fun!

Best