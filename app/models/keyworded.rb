class Keyworded

  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Search
  include Tire::Model::Search
  include Tire::Model::Callbacks

  field :name
  field :description
  field :cost, :type => Float
  field :shape
  field :keywords, :type => String

  index({:keywords => 1}, {:unique => false})

  store_in :collection => :variant_ones
  search_in :keywords

  mapping do
    indexes :id,       :index    => :not_analyzed
    indexes :keywords, :analyzer => 'keyword'
  end

  def self.search_with_regex(keywords)
    keywords.to_a.flatten.inject([]) { |a,keyword| a << where(:keywords => /#{keyword}/i).to_a; a}.flatten
  end

  def self.search_with_fulltext(keywords)
    full_text_search(keywords, :match_all => true).to_a
  end

  def self.search_with_elastic(keywords)
    search(keywords.to_a * ' ', :load => true)
  end

  def to_indexed_json
    self.to_json
  end

end