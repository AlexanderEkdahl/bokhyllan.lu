# Bokhyllan.lu

## Setup

### OSX/Linux

Dependencies: PostgreSQL(running), Ruby 2.0, Bundler

    ARCHFLAGS="-arch x86_64" gem install pg
    bundle install --without production staging
    rake db:setup
    bin/rails s

## Production

### Updating remote

    git push origin master # Codeship keeps origin master in sync with staging
    heroku pipeline:promote --app bokhyllan-staging

### Pulling the database from Heroku

    heroku pg:backups capture --app bokhyllan &&
    curl -o heroku.dump `heroku pg:backups public-url --app bokhyllan` &&
    pg_restore --clean --no-acl --no-owner -h localhost -U `whoami` -d bokhyllan_development heroku.dump &&
    rm heroku.dump &&
    bin/rake algoliasearch:reindex

### Generating UML Diagram

Dependencies: Railroady

    railroady -M | dot -Tpng > models.png
