#Bokhyllan.lu

##Getting started

###Nitrous.io

###OSX/Linux

Dependencies: PostgreSQL, Ruby 2.0, Bundler

    ARCHFLAGS="-arch x86_64" gem install pg
    bundle install --without production staging
    postgres -D /usr/local/var/postgres
    rails s

###Windows

Don't even bother. Use Nitrous.io instead

##Production

###Pulling the database from Heroku

    heroku pgbackups:capture --expire --app bokhyllan &&
    curl -o heroku.dump `heroku pgbackups:url --app bokhyllan` &&
    pg_restore --clean --no-acl --no-owner -h localhost -U `whoami` -d bokhyllan_development heroku.dump &&
    rm heroku.dump &&
    foreman run rake algoliasearch:reindex

###Generating UML Diagram

Dependencies: Railroady

    railroady -M | dot -Tpng > models.png
