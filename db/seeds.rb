dict = File.readlines('/usr/share/dict/words').map {|l| l.rstrip.downcase}

total = 10

(1..total).each do |i|

  print "\r\e[0KCreating sample data #{i} of #{total}"

  name = dict.sample
  description = dict[(i / 4)..(i / 4 + 10)].to_sentence
  cost = rand(1000).to_f
  shape = ['rectangle', 'triangle', 'circle', 'hexagon'][rand(4)]
  keywords = dict[(i / 4)..(i / 4 + 10)]

  Keyworded.create(
    :name         => name,
    :description  => description,
    :cost         => cost,
    :shape        => shape,
    :keywords     => keywords.to_sentence
  )

end