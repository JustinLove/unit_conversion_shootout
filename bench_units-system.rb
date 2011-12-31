require 'benchmark'

SUBJECT = 'units-system'

samples = Array.new(100) {rand}

Benchmark.bm(40) do |b|
  b.report(SUBJECT + ' - load') { require SUBJECT }
end

Benchmark.bm(40) do |b|
  b.report(SUBJECT + ' - conversion') do
    samples.map {|x| Units.units {x*m.to(km).magnitude}}
    samples.map {|x| Units.units {x*km.to(m).magnitude}}
    samples.map {|x| Units.units {x*m.to(mi).magnitude}}
    samples.map {|x| Units.units {x*mi.to(m).magnitude}}
  end
end
