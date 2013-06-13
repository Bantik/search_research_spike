Mongoid-Compatible Search Research Spike
========================================

This reseach spike focuses on benchmarking the performance of several approaches to full-text searching in a project using MongoDB as the primary datastore and Mongoid as the ORM.

This involves comparing the following:

  * Naïve text searching using native regex
  * Maurisio Zaffari's mongoid_search gem (https://github.com/mauriciozaffari/mongoid_search)
  * Elasticsearch via the Tire gem (https://github.com/karmi/tire)

Note that full-text searching is built into the most recent version of MongoDB, but at the time of this writing this was not a viable alternative as 10gen's documentation warned against using it in production environments and the version of Mongoid that supports this feature requires Rails 4, which is currently still in RC status.

Setup
-----

* Bundle to install mongoid_search and tire
* Download, install, and launch Elasticsearch following the directions at http://www.elasticsearch.org/overview/#installation
* Run the seed rake task to generate your sample data:

    rake db:seed

* Run the rake task to create an index for mongoid_search:

    rake mongoid_search:index

* Run the rake task to populate the Elasticsearch index:

    rake benchmark:backfill_elasticsearch

Benchmarking
------------

Once you're ready to benchmark, run this rake task:

    rake benchmark:all

You can also run benchmarks individually:

    rake benchmark:string_search
    rake benchmark:fulltext_search
    rake benchmark:elastic_search

The Good Stuff
--------------

Nicely formatted results from the benchmarking are available in the _/output_ folder in Numbers and PDF formats. Dying to know who won? It was Elasticsearch. :)


