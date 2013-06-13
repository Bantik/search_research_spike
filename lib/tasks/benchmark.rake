require 'benchmark'
require 'tire'

namespace :benchmark do

  desc "Run all benchmarks"
  task :all => :environment do
    total = 100
    string_search     = SearchBenchmark.new(:kind => 'regex',    :iterations => total, :search_method => :search_with_regex)
    full_text_search  = SearchBenchmark.new(:kind => 'fulltext', :iterations => total, :search_method => :search_with_fulltext)
    elastic_search    = SearchBenchmark.new(:kind => 'elastic',    :iterations => total, :search_method => :search_with_elastic)
    [string_search, full_text_search, elastic_search].each{ |searcher| searcher.perform }

    puts

    string_search.report(true)
    full_text_search.report
    elastic_search.report

    puts

    string_search.details
    full_text_search.details
    elastic_search.details

  end

  desc "string search"
  task :string_search => :environment do
    total = 5
    search = SearchBenchmark.new(:kind => 'regex', :iterations => total, :search_method => :search_with_regex)
    search.perform
    search.report(true)
    search.details
  end

  desc "full text search"
  task :fulltext_search => :environment do
    total = 100
    search = SearchBenchmark.new(:kind => 'fulltext', :iterations => total, :search_method => :search_with_fulltext)
    search.perform
    search.report(true)
    search.details
  end

  desc "elastic search"
  task :elastic_search => :environment do
    total = 100
    search = SearchBenchmark.new(:kind => 'elastic', :iterations => total, :search_method => :search_with_elastic)
    search.perform
    search.report(true)
    search.details
  end

  desc "backfill elasticsearch"
  task :backfill_elasticsearch => :environment do
    total = Keyworded.count
    Tire.index 'keywordeds' do
      delete
      create
      Keyworded.each_with_index do |document, i|
        print "\r\e[0KIndexing document #{i +1} of #{total} Keyworded documents..."
        store :id => document.id, :keywords => document.keywords
      end
      refresh
    end
  end

end