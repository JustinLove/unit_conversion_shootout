require 'benchmark'

SUBJECT = 'quantity/all'

samples = Array.new(100) {rand}

Benchmark.bm(40) do |b|
  b.report(SUBJECT + ' - load') { require SUBJECT }
  b.report(SUBJECT + ' - conversion') do
    samples.map {|x| x.meter.to_km.to_f}
    samples.map {|x| x.km.to_meter.to_f}
    samples.map {|x| x.meter.to_mile.to_f}
    samples.map {|x| x.mile.to_meter.to_f}
  end
end
