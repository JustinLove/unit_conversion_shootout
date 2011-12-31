require 'benchmark'

SUBJECT = 'direct'

samples = Array.new(100) {rand}

Benchmark.bm(40) do |b|
  b.report(SUBJECT + ' - conversion') do
    samples.map {|x| x * 1000}
    samples.map {|x| x / 1000}
    samples.map {|x| x * 1609.344}
    samples.map {|x| x / 1609.344}
  end
end
