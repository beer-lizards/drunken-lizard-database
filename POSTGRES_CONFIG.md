# Postgres Config

Same quick notes on setting up a postgres database.

#### Install postgres

apt-get update
apt-get install postgresql-9.5

#### Create Data Directory
mkdir /opt/data
chown -R postgres:postgres /opt/data

### Edit postgresql.conf file

/etc/postgresql/9.5/main/postgresql.conf

data_directory='/opt/data/pgdata'
listen_addresses = '*'
max_connections = 100
effective_cache_size = 2GB

## Edit pg_hba.conf file

/etc/postgresql/9.5/main/pg_hba.conf

host all all 0.0.0.0/0 md5

#### Create a new base database

cd /usr/lib/postgresql/9.5/bin
sudo -u postgres ./initdb /opt/data/pgdata/"

#### Restart Postgres

servcice restart postgresql
