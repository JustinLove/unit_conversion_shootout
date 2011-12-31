require 'benchmark'

SUBJECT = 'measure/length'

samples = Array.new(100) {rand}

Benchmark.bm(40) do |b|
  b.report(SUBJECT + ' - load') do
    require SUBJECT
    Measure.def_unit :mile, :length
    Measure.def_conversion :m, :mile => 1609.344
  end
end

Benchmark.bm(40) do |b|
  b.report(SUBJECT + ' - conversion') do
    samples.map {|x| Measure.new(x, :meter).as_km.to_a[0]}
    samples.map {|x| Measure.new(x, :km).as_meter.to_a[0]}
    samples.map {|x| Measure.new(x, :meter).as_mile.to_a[0]}
    samples.map {|x| Measure.new(x, :mile).as_meter.to_a[0]}
  end
end
