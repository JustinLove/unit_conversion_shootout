require 'benchmark'

SUBJECT = 'uom'

samples = Array.new(100) {rand}

Benchmark.bm(40) do |b|
  b.report(SUBJECT + ' - load') { require SUBJECT }
  b.report(SUBJECT + ' - conversion') do
    samples.map {|x| UOM::Measurement.new(:m, x).as(:km).to_f}
    samples.map {|x| UOM::Measurement.new(:km, x).as(:m).to_f}
    samples.map {|x| UOM::Measurement.new(:m, x).as(:mi).to_f}
    samples.map {|x| UOM::Measurement.new(:mi, x).as(:m).to_f}
  end
end
