require 'benchmark'

SUBJECT = 'alchemist'

samples = Array.new(100) {rand}

Benchmark.bm do |b|
  b.report(SUBJECT + ' - load') { require SUBJECT }
end

Benchmark.bm(10) do |b|
  b.report(SUBJECT + ' - conversion') do
    samples.map {|x| x.meters.to.km}
    samples.map {|x| x.km.to.meters}
    samples.map {|x| x.meters.to.miles}
    samples.map {|x| x.miles.to.meters}
  end
end
