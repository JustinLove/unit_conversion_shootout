require 'benchmark'

SUBJECT = 'brute'

samples = Array.new(100) {rand}

Benchmark.bm do |b|
  b.report(SUBJECT + ' - load') do
    module Convert
      def kilometers_from_meters(meters)
        meters / 1000
      end

      def meters_from_kilometers(km)
        km * 1000
      end

      def miles_from_meters(meters)
        meters / 1609.344
      end

      def meters_from_miles(miles)
        miles * 1609.344
      end
      extend self
    end
  end
end

Benchmark.bm(10) do |b|
  b.report(SUBJECT + ' - conversion') do
    samples.map {|x| Convert.kilometers_from_meters(x)}
    samples.map {|x| Convert.meters_from_kilometers(x)}
    samples.map {|x| Convert.miles_from_meters(x)}
    samples.map {|x| Convert.meters_from_miles(x)}
  end
end
