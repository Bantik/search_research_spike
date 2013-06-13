class SearchBenchmark

  attr_accessor :kind, :iterations, :times, :search_method

  def initialize(args={})
    args.each{|k,v| respond_to?(k) && self.send("#{k}=", v)}
    self.times = []
  end

  def dictionary
    @dictionary ||= File.readlines('/usr/share/dict/words').map {|l| l.rstrip.downcase}
  end

  def keyword
    dictionary.sample
  end

  def search
    Keyworded.send(self.search_method, keyword)
  end

  def report_progress(i)
    print "\r\e[0KPerforming #{self.kind} search #{i} of #{self.iterations}..."
  end

  def perform
    i = 0
    self.iterations.times {i += 1; report_progress(i); times << sprintf("%0.4f", Benchmark.realtime{ search }).to_f }
  end

  def results
    {
      :min_time           => min_time,
      :max_time           => max_time,
      :mean_time          => mean_time,
      :weighted_mean_time => weighted_mean_time,
      :total_time         => total_time,
      :times              => times
    }
  end

  def min_time
    self.times.min
  end

  def max_time
    self.times.max
  end

  def mean_time
    total_time / self.times.count.to_f
  end

  def weighted_mean_time
    (total_time - max_time - min_time) / (self.times.count  - 2).to_f
  end

  def total_time
    self.times.sum
  end

  def report(include_header=false)
    puts %{\nSearch Kind\tMin\tMax\tMean\tWeighted Mean\tTotal} if include_header
    puts %{#{self.kind}\t#{min_time}\t#{max_time}\t#{mean_time}\t#{weighted_mean_time}\t#{total_time}}
  end

  def details
    puts %{#{self.kind}\t#{times * "\t"}}
  end

end

