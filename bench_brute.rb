require 'benchmark'

SUBJECT = './brute'

samples = Array.new(100) {rand}

Benchmark.bm(40) do |b|
  b.report(SUBJECT + ' - load') { require SUBJECT }
end

Benchmark.bm(40) do |b|
  b.report(SUBJECT + ' - conversion') do
    samples.map {|x| Convert.kilometers_from_meters(x)}
    samples.map {|x| Convert.meters_from_kilometers(x)}
    samples.map {|x| Convert.miles_from_meters(x)}
    samples.map {|x| Convert.meters_from_miles(x)}
  end
end
