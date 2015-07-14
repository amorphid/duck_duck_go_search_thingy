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

Make sure you prerequisites installed!

Install gems

```
$ bundle
```
Start the server
```
$ bundle exec rails server
```

Known Issues
============

Because this app requires PhantomJS, and Heroku doesn't (easily) support PhantomJS, this app will likely not work on Heroku.

API Searching
=============

Submitting a query via GET request will return JSON.

```
# Has a topic summary
$ curl http://localhost:3000/api/v1/search?q=valley forge national park


# Does not have a topic summary
$ curl http://localhost:3000/api/v1/search?q=banana

# No search results
$ curl http://localhost:3000/api/v1/search?q=qwieuyqiwey%20kjsdhfklsfhdj%20lkjshdfjklhsdf

```

Web
===

Submitting a query via the web form will return HTML.

* Has a topic summary
  * [http://localhost:3000/search?q=valley forge national park](http://localhost:3000/search?q=valley forge national park)
* Does not have a topic summary
  * [http://localhost:3000/search?q=banana](http://localhost:3000/search?q=banana)
* No search results
  * [http://localhost:3000/search?q=qwieuyqiwey%20kjsdhfklsfhdj%20lkjshdfjklhsdf](http://localhost:3000/search?q=qwieuyqiwey%20kjsdhfklsfhdj%20lkjshdfjklhsdf)

License
=======

MIT
