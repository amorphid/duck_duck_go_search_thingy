DuckDuckGo Search Thingy
========================

This app allows you to submit queries to DuckDuckGo.  Queries may be submitted via a web form, or via an API call.

API Searching
=============

Submitting a query via GET request will return JSON.  For best results, separate query arguments with spaces.

```
# bad
$ curl http://localhost:3000/api/search?q=no+spaces

# good
$ curl http://localhost:3000/api/search?q=spaces between arguments
```

Web
===

Submitting a query via the web form will return HTML.  Run `bundle exec rails server` from the command line, and then visit [http://localhost:3000/](http://localhost:3000/) (or whatever domain you're using).

License
=======

MIT
