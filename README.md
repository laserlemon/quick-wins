# Quick Wins

_An example application to demonstrate "quick wins" for Rails performance_

[![Build Status](https://img.shields.io/travis/laserlemon/quick-wins/master.svg?style=flat)](https://travis-ci.org/laserlemon/quick-wins)
[![Code Climate](https://img.shields.io/codeclimate/github/laserlemon/quick-wins.svg?style=flat)](https://codeclimate.com/github/laserlemon/quick-wins)
[![Code Coverage](http://img.shields.io/codeclimate/coverage/github/laserlemon/quick-wins.svg?style=flat)](https://codeclimate.com/github/laserlemon/quick-wins)
[![Dependency Status](https://img.shields.io/gemnasium/laserlemon/quick-wins.svg?style=flat)](https://gemnasium.com/laserlemon/quick-wins)

## Background

This repository contains a Rails application named "Inbox."

Inbox is a simple application with the concept of users and sending messages
between those users.

There is one primary interface to the application: a list of messages that have
been received by the logged in user. Unread messages are highlighted and can be
marked as read, several at a time.

## Performance

The code in `master` contains a number of opportunities for increased
performance. A [performance test](spec/performance/message_list_spec.rb) exists
in order to benchmark execution time for a particular taxing use case.

We'll use six techniques to increase performance in the application. The changes
for each of these techniques are encapsulated in individual pull requests.

## Database Indexes

Branch: [database-indexes](https://github.com/laserlemon/quick-wins/compare/database-indexes)

Declaring proper database indexes can make queries faster. Consider database
indexes for columns that are included in queries' "where" and "order" clauses.

## Memoization

*Branch:* [memoization](https://github.com/laserlemon/quick-wins/compare/memoization)

Using memoization is a popular technique to cache the result of a potentially
expensive method. After the first evaluation, subsequent calls to the method
will return the saved result.

## Bulk Update

*Branch:* [bulk-update](https://github.com/laserlemon/quick-wins/compare/bulk-update)

When multiple database records need to be updated at once, it's sometimes
possible to update them all at once using one query rather than performing a
separate update query for each record.

## Eager Loading

*Branch:* [eager-loading](https://github.com/laserlemon/quick-wins/compare/eager-loading)

When displaying a list of records along with some of each record's associated
data, beware of the dreaded "n + 1" query problem. The term "n + 1" refers to
the number of queries that are performed to render the list. You might have one
query to fetch the list of records, and then another query *per record* to fetch
some data associated to that record. For a list of 100 records, the system would
perform 101 queries.

Instead, you can often fetch the primary records in one query and then fetch
*all* of the associated data with only one more query. The system would only
perform two queries.

## Inverse Association

*Branch:* [inverse-association](https://github.com/laserlemon/quick-wins/compare/inverse-association)

When loading a collection of records associated with a parent record, each child
record has to load its parent from the database (even though we already have an
instance of it). With a little Active Record configuration, each child can be
given a copy of its parent instance in order to reduce the number of queries.

This optimization is similar to "Eager Loading" above.

## Fragment Caching

*Branch:* [fragment-caching](https://github.com/laserlemon/quick-wins/compare/fragment-caching)

View rendering time can account for a large percentage of your overall request
processing time. Fragment caching, like "Memoization" above, allows you render
portions of the view once and reuse the result for subsequent renderings of the
same view.
