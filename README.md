#Bokhyllan.lu

Your privacy is honored and information won't be shared with those who do not need it(i.e. Google)

##Getting started

###Nitrous.io

###OSX/Linux

Dependencies: PostgreSQL, Ruby 2.0, Bundler, ElasticSearch

    ARCHFLAGS="-arch x86_64" gem install pg
    bundle install
    postgres -D /usr/local/var/postgres
    elasticsearch -f
    rake searchkick:reindex CLASS='Item'
    rails s

###Windows

Don't even bother. Use Nitrous.io instead

##Production

###Pulling the database from Heroku

    heroku pgbackups:capture --expire --app bokhyllan &&
    curl -o heroku.dump `heroku pgbackups:url --app bokhyllan` &&
    pg_restore --clean --no-acl --no-owner -h localhost -U `whoami` -d bokhyllan_development heroku.dump &&
    rm heroku.dump &&
    rake searchkick:reindex CLASS='Item'
