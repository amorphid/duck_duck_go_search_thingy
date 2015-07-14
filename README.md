DuckDuckGo Search Thingy
========================

This app allows you to submit queries to DuckDuckGo.  Queries may be submitted via a web form, or via an API call.

A demo version may be found on Heroku => [https://ddg-search-thingy.herokuapp.com/](https://ddg-search-thingy.herokuapp.com/)

Built & Tested With
===================

* Mac OS X 10.10.4
* Ruby 2.2.2
* Rails 4.2.3

Setup
=====

Install gems

```
$ bundle
```
Start the server
```
$ bundle exec rails server
```

API Searching
=============

Submitting a query via GET request will return JSON.

```
# Has a topic summary
$ curl http://localhost:3000/api/v1/search?q=valley forge national park
$ curl https://ddg-search-thingy.herokuapp.com/api/v1/search?q=valley forge national park

# Does not have a topic summary
$ curl http://localhost:3000/api/v1/search?q=banana
$ curl https://ddg-search-thingy.herokuapp.com/api/v1/search?q=banana

# No search results
$ curl http://localhost:3000/api/v1/search?q=qwieuyqiwey%20kjsdhfklsfhdj%20lkjshdfjklhsdf
$ curl https://ddg-search-thingy.herokuapp.com/api/v1/search?q=qwieuyqiwey%20kjsdhfklsfhdj%20lkjshdfjklhsdf

```

Web
===

Submitting a query via the web form will return HTML.

* Has a topic summary
  * [http://localhost:3000/search?q=valley forge national park](http://localhost:3000/search?q=valley forge national park)
  * [https://ddg-search-thingy.herokuapp.com/search?q=valley forge national park](https://ddg-search-thingy.herokuapp.com/search?q=valley forge national park)
* Does not have a topic summary
  * [http://localhost:3000/search?q=banana](http://localhost:3000/search?q=banana)
  * [https://ddg-search-thingy.herokuapp.com/search?q=banana](https://ddg-search-thingy.herokuapp.com/search?q=banana)
* No search results
  * [http://localhost:3000/search?q=qwieuyqiwey%20kjsdhfklsfhdj%20lkjshdfjklhsdf](http://localhost:3000/search?q=qwieuyqiwey%20kjsdhfklsfhdj%20lkjshdfjklhsdf)
  * [https://ddg-search-thingy.herokuapp.com/search?q=qwieuyqiwey%20kjsdhfklsfhdj%20lkjshdfjklhsdf](https://ddg-search-thingy.herokuapp.com/search?q=qwieuyqiwey%20kjsdhfklsfhdj%20lkjshdfjklhsdf)

License
=======

MIT
