#Bokhyllan.lu

* Your privacy is honored and information won't be shared with those who do not need it(i.e. Google)
* Sitemap generation
* Format phone numbers
* StatHat
* Merge item data when duplicates are found. Also move orders
* Link item with other textbook
* Course names as an attribute
* Improve encouragement to verify the account
* Simplfiy password reset both for logged in and logged out users
* Remember me function
* Coveralls
* Code Climate
* Nypris
* Cancel order direct link
* IndexTank
* Show cheaper alternative for order if exists
* Reorganize fonts
* Advanced queries

##Getting started

###Nitrous.io

###Mac OS X

Postgres, bundler

    bundle install
    pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start
    elasticsearch -f -D es.config=/usr/local/opt/elasticsearch/config/elasticsearch.yml
    rake environment tire:import CLASS='Item' FORCE=true
    rails s

###Linux

###Windows

Don't even bother.
