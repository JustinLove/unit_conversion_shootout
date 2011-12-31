require 'benchmark'

SUBJECT = 'geo_units'

samples = Array.new(100) {rand}

Benchmark.bm(40) do |b|
  b.report(SUBJECT + ' - load') { require SUBJECT }
end

Benchmark.bm(40) do |b|
  b.report(SUBJECT + ' - conversion') do
    samples.map {|x| GeoUnits.meters_to :kms, x}
    samples.map {|x| GeoUnits.kms_to :meters, x}
    samples.map {|x| GeoUnits.meters_to :miles, x}
    samples.map {|x| GeoUnits.miles_to :meters, x}
  end
end
