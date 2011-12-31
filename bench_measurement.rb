require 'benchmark'

SUBJECT = 'measurement/length'

samples = Array.new(100) {rand}

Benchmark.bm(40) do |b|
  b.report(SUBJECT + ' - load') { require SUBJECT }
  b.report(SUBJECT + ' - conversion') do
    samples.map {|x| Length.new(x).in_km }
    samples.map {|x| Length.new(x, :km).to_f }
    samples.map {|x| Length.new(x).in_miles }
    samples.map {|x| Length.new(x, :miles).to_f }
  end
end
