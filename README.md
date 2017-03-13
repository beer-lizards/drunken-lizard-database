# Drunken Lizard Database

What is the Drunken Lizard Database?

The Drunken Lizard Database is contains the data model for the drunken lizard
application. It will contain the user information about what beers one has
cosumed, and who their friends are.

## Local development

Use the `migrate.sh` script or,

Create a local config file to store the database connection string and
optionally the database credentials. Flyway will apply the default values from
the `flyway.conf` in the root of this repository and will override those values
with any values from your custom configuration.

### Flyway properties

The following placeholders need to be populated in the flyway.conf:

```sh
flyway.placeholders.admin_email=
flyway.placeholders.admin_password_algorithm=
flyway.placeholders.admin_password_hash=
flyway.placeholders.admin_password_salt=
flyway.placeholders.admin_user=
```

### Database connection string.
flyway.url=jdbc:postgresql://<database-ip>:<database-port>/drunken_lizard

### Database Credentials
flyway.user=<username>
flyway.password=<password>
```

Then run the following command to use the custom configuration.

```sh
$ flyway -configFile=<credentials-config> clean migrate
```

### Postgres

To spin up a local postgres database for testing just run the following docker
run command:

```sh
$ docker run -it --rm --name drunken-lizard-postgres \
    -e POSTGRES_PASSWORD=lizard \
    -e POSTGRES_USER=drunken \
    -p 5432:5432 \
    postgres
```

## Docker

### Build

Building the image

```sh
$ docker build -t drunken-lizard-database:latest .
```

