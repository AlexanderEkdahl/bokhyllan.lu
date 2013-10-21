#Bokhyllan.lu

Your privacy is honored and information won't be shared with those who do not need it(i.e. Google)

##TODO

* Sitemap generation(https://github.com/kjvarga/sitemap_generator)
* Format phone numbers
* Cancel order direct link from email
* Sliten/Få anteckningar, mindre slitage/Nyskick
* Write detailed tests for the navigation
* Font should be required in the header of the html to decrease the critical path
* Automatically fetch name and phonenumber(Using gmail)
* Propose prices/Nypris
* Complete your profile - When adding an item. 2 additional fields are added. When creating an order you get redirected to that page.
* OBS finns billigare(om boken finns i samma kvalitet billigare)
* Add courses, course list(with unbuyable items) / more advanced queries
* Factor out authors/courses separation. What is different about them?
* Boost items with more orders
* Items as PDF
* Favicon - Apple Icon
* Tel links

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
