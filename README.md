# Star Wars DataPad
This is a fun little project using [Mechanize](https://github.com/sparklemotion/mechanize) to scrape [Wookieepedia's Characters by faction](http://starwars.wikia.com/wiki/Category:Individuals_by_faction) and save the Characters it finds and serve them up with a dirt simple API.

Primarily intended for frontend/mobile students to ping for Star Wars characters.

## Setup
1. Fork this repository
1. `$ bundle`
1. `$ bin/rake db:create db:migrate datapad:populate` to start getting
   Star Wars data

If you just want general `Faker` gem data, run `$ bin/rake db:seed`.
