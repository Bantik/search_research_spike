Mongoid-Compatible Search Research Spike
========================================

This reseach spike focuses on benchmarking the performance of several approaches to full-text searching in a project using MongoDB as the primary datastore and Mongoid as the ORM.

This involves comparing the following:

  * Naïve text searching using native regex
  * Maurisio Zaffari's mongoid_search gem (https://github.com/mauriciozaffari/mongoid_search)
  * Elasticsearch via the Tire gem (https://github.com/karmi/tire)

Note that full-text searching is built into the most recent version of MongoDB, but at the time of this writing this was not a viable alternative as 10gen's documentation warned against using it in production environments and the version of Mongoid that supports this feature requires Rails 4, which is currently still in RC status.

Install Elasticsearch
---------------------

* Download from http://www.elasticsearch.org/download/

* Unzip/unarchive the file

* Run this command from the unarchived directory in Terminal: `bin/elasticsearch -f`

Setup
-----

* `bundle` to install mongoid_search, tire, and other dependencies

* Run the seed rake task to generate your sample data (will take about an hour)

    `rake db:seed`

* Run the rake task to create an index for mongoid_search:

    `rake mongoid_search:index`

* Run the rake task to populate the Elasticsearch index:

    `rake benchmark:backfill_elasticsearch`

Benchmarking
------------

Once you're ready to benchmark, run this rake task:

    rake benchmark:all

You can also run benchmarks individually:

    rake benchmark:string_search
    rake benchmark:fulltext_search
    rake benchmark:elastic_search

Results
-------

Nicely formatted results from the benchmarking are available in the _/output_ folder in Numbers and PDF formats.


