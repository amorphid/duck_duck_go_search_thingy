(README can via viewed here, too => [https://gist.github.com/amorphid/5b966c0d5f1b4e6d9025](https://gist.github.com/amorphid/5b966c0d5f1b4e6d9025))

DuckDuckGo Search Thingy
========================

This app allows you to submit queries to DuckDuckGo.  Queries may be submitted via a web form, or via an API call.

Prerequisites
=============

* Mac OS X 10.10.4
* Ruby 2.2.2
* Bundler 1.10.5
* PhantomJS 2.0.0

Note:  App configured to run without a database

Setup
=====

Make sure prerequisites are installed!

Install gems

```
$ bundle install
```
Start the server
```
$ bundle exec rails server
```
Design Decisions
================

>> Write a scraper for DuckDuckGo search results: write a function that takes a search string as input and returns a list of results scraped from duckduckgo.com.

* search results handled by `app/models/duck_duck_go_searcher.rb`

>> Wrap that in an API: I should be able to make an HTTP request containing my query and get list of DuckDuckGosearch results as JSON.
>> Create a basic frontend. I should be able to type my query in and get either:
>> A topic summary from the DuckDuckGo API if it's available (see https://duckduckgo.com/api), or
>> a list of search results from the DuckDuckGo scraper

* Every query combine results from an API call & screen scraping
  * Topic summary fetched via API call
  * search results fetched via screen scraping
* Screen scraping is accomplished w/ Capybara & PhantomJS
  * This allows scraper to scrape JavaScript
  * Also makes scraping a little slower
* Only first page or results is returned

Known Issues
============

* Because this app requires PhantomJS, and Heroku doesn't (easily) support PhantomJS, this app will likely not work on Heroku.
* Web searches must be submitted via form
  * Go to [http://localhost:3000](http://localhost:3000) and submit the following query via form => this query works
  * Example => [http://localhost:3000?q=this query will not initiate a seach](http://localhost:3000?q=this query will not initiate a seach)

API Searching
=============

Submitting a query via GET request will return JSON.

```
# Has a topic summary
$ curl http://localhost:3000/api/v1/search?q=valley+forge+national+park

# Does not have a topic summary
$ curl http://localhost:3000/api/v1/search?q=banana

# No search results
$ curl http://localhost:3000/api/v1/search?q=qwieuyqiwey+kjsdhfklsfhdj+lkjshdfjklhsdf

```

Web
===

Submitting a query via the web form will return HTML.

Suggest search terms
* Has a topic summary => valley forge national park
* Does not have a topic summary => banana
* No search results => qwieuyqiwey kjsdhfklsfhdj lkjshdfjklhsdf

License
=======

MIT
