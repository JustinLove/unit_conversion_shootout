require 'benchmark'

SUBJECT = 'stick/units'

samples = Array.new(100) {rand}

Benchmark.bm(40) do |b|
  b.report(SUBJECT + ' - load') do
    require SUBJECT
    module U
       # locks up process if included at top level as recommended
      include Stick::Units
    end
  end
end

Benchmark.bm(40) do |b|
  b.report(SUBJECT + ' - conversion') do
    samples.map {|x| x.meters.to(U.km).value}
    samples.map {|x| x.km.to(U.meters).value}
    samples.map {|x| x.meters.to(U.miles).value}
    samples.map {|x| x.miles.to(U.meters).value}
  end
end
