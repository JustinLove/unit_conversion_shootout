require 'benchmark'

SUBJECT = 'units/standard'

samples = Array.new(100) {rand}

Benchmark.bm(40) do |b|
  b.report(SUBJECT + ' - load') { require SUBJECT }
  b.report(SUBJECT + ' - conversion') do
    samples.map {|x| x.meters.to_km}
    samples.map {|x| x.km.to_meters}
    samples.map {|x| x.meters.to_miles}
    samples.map {|x| x.miles.to_meters}
  end
end
