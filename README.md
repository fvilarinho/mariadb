Synopsys
========
This a base image for the usage of a relational database.
It uses the `ghcr.io/fvilarinho/base-image` and [mariadb](https://mariadb.org/).
It also uses [flyway](https://flywaydb.org) to control the versions and states of the schemas.
The configurations/settings are defined using the JSON format and stored in the `etc` directory.
The scripts are stored in the `sql` directory and must follow the standard below:

- `V<sequence-number>__<name-of-the-script>.sql`

All scripts will be checked in the bootstrap and applied in the database if it wasn't yet.

How to use
==========
Just put the line below in your Dockerfile.

`FROM ghcr.io/fvilarinho/mariadb:1.2.0` - To use the last stable version.

`FROM ghcr.io/fvilarinho/mariadb:latest` - To use the development version.

Build status
============
[![CI/CD Pipeline](https://github.com/fvilarinho/mariadb/actions/workflows/pipeline.yml/badge.svg)](https://github.com/fvilarinho/mariadb/actions/workflows/pipeline.yml)

License
=======
This image is licensed under the Apache 2.0. Please read the licence file or check the URL [https://www.apache.org/licenses/LICENSE-2.0.txt](https://www.apache.org/licenses/LICENSE-2.0.txt)

Contact
=======
**Website:** - https://vilanet.sh

**e-Mail:**
- fvilarinho@gmail.com
- fvilarinho@outlook.com
- me@vila.net.br

and that's all! Have fun!