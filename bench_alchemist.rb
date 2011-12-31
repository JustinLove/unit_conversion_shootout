require 'benchmark'

SUBJECT = 'alchemist'

samples = Array.new(100) {rand}

Benchmark.bm(40) do |b|
  b.report(SUBJECT + ' - load') { require SUBJECT }
  b.report(SUBJECT + ' - conversion') do
    samples.map {|x| x.meters.to.km.to_f}
    samples.map {|x| x.km.to.meters.to_f}
    samples.map {|x| x.meters.to.miles.to_f}
    samples.map {|x| x.miles.to.meters.to_f}
  end
end
