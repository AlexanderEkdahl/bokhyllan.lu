#Bokhyllan.lu

* Your privacy is honored and information won't be shared with those who do not need it(i.e. Google)
* Sitemap generation(https://github.com/kjvarga/sitemap_generator)
* Format phone numbers
* StatHat
* Merge item data when duplicates are found. Also move orders
* Improve encouragement to verify the account
* Simplfiy password reset both for logged in and logged out users
* Remember me function
* Coveralls
* Code Climate
* Nypris
* Cancel order direct link
* Show cheaper alternative for order if exists
* Advanced queries
* Sliten/Få anteckningar, mindre slitage/Nyskick
* Write detailed tests for the navigation
* Font should be required in the header of the html to decrease the critical path

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
