require 'benchmark'

SUBJECT = 'm9t'

samples = Array.new(100) {rand}

Benchmark.bm do |b|
  b.report(SUBJECT + ' - load') { require SUBJECT }
end

Benchmark.bm(10) do |b|
  b.report(SUBJECT + ' - conversion') do
    samples.map {|x| M9t::Distance.meters_to_kilometers(x)}
    samples.map {|x| M9t::Distance.kilometers_to_meters(x)}
    samples.map {|x| M9t::Distance.meters_to_miles(x)}
    samples.map {|x| M9t::Distance.miles_to_meters(x)}
  end
end
