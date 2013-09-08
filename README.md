#Bokhyllan.lu

Your privacy is honored and information won't be shared with those who do not need it(i.e. Google)

##TODO

* Sitemap generation(https://github.com/kjvarga/sitemap_generator)
* Format phone numbers
* Merge item data when duplicates are found. Also move orders
* Cancel order direct link
* Advanced queries
* Sliten/Få anteckningar, mindre slitage/Nyskick
* Write detailed tests for the navigation
* Capybara
* Font should be required in the header of the html to decrease the critical path
* "Hittar ingen stans, alla böcker som är inne" - Lars
* Automatically fetch name and phonenumber
* Propose prices/Nypris
* Tydligare hur man lägger in böcker - Catta
* Complete your profile - When adding an item. 2 additional fields are added. When creating an order you get redirected to that page. - pilar
* OBS finns billigare(om boken finns i samma kvalitet billigare)
* Upplaga i order
* Boost title search score

##Getting started

###Nitrous.io

###Mac OS X

Postgres, bundler

    bundle install
    pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start
    elasticsearch -f -D es.config=/usr/local/opt/elasticsearch/config/elasticsearch.yml
    rake environment tire:import CLASS='Item' FORCE=true NEWRELIC_ENABLE=false
    rails s

###Linux

###Windows

Don't even bother.

##Production

    rake sitemap:refresh NEWRELIC_ENABLE=false
    rake environment tire:import CLASS='Item' FORCE=true NEWRELIC_ENABLE=false

    User.all.map { |u| u.email }.join("; ")
    CSV.parse(csv) { |row| Item.create(isbn: row[0], name: row[1], authors: row[2], courses: row[3]) }
