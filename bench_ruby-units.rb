require 'benchmark'

SUBJECT = 'ruby-units'

samples = Array.new(100) {rand}

Benchmark.bm do |b|
  b.report(SUBJECT + ' - load') { require SUBJECT }
end

Benchmark.bm(10) do |b|
  b.report(SUBJECT + ' - conversion') do
    samples.map {|x| Unit.new('1m').to('km').scalar}
    samples.map {|x| Unit.new('1km').to('m').scalar}
    samples.map {|x| Unit.new('1m').to('mi').scalar}
    samples.map {|x| Unit.new('1mi').to('m').scalar}
  end
end
