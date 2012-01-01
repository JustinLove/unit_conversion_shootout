# Ruby Unit Conversion Shootout

There are a huge number of unit conversion libraries for Ruby.  The decision of which one to use will depend in large part on personal taste, as well as your application's requirements.  If you are throwing arounds lots of values in mixed units, one of the more fluid, magical libraries might make sense.  
My application was rankingobjects retrieved from a bunch of different sources.  I noticed that the distance ranking was taking substantially longer than the other steps (~0.13 seconds vs. less than 0.0001 seconds), and traced this to the Alchemist library, which indeed shows up as the slowpoke of those tested.  This application creates a number of biases in my library selection, such as disqualifiying gems without built-in distance conversions.

## The Controls

- brute force: one of the controls, a locally defined method that's about as dirt simple as possible
- direct: another control, does the conversion inline with bare math

## The Contestants

- [Alchemist](http://rubygems.org/gems/alchemist): Numeric extensions.  `x.meters.to.km.to_f`
- [Geo Units](https://github.com/kristianmandrup/geo_units): has a number of units useful to geographic calculations.  `GeoUnits.meters_to :kms, x`
- [M9t](https://github.com/joeyates/m9t): While it has tagged number objects, I used the direct conversion methods, which proved to be fastest library method by an order of magnitude.  `M9t::Distance.meters_to_kilometers(x)`
- [Measure](http://rubygems.org/gems/measure): Explicitly constructed tagged numbers.  I had to define miles myself, and kind of hack the number back out.  `Measure.new(x, :meter).as_km.to_a[0]`
- [Measurement](https://github.com/jemmyw/measurement): Tagged number objects, which use meters internall and croak if you specify them explicitly.  `Length.new(x).in_km`
- [Quantity.rb](http://quantity.rubyforge.org/): Numeric extensions. `x.meter.to_km.to_f`
- [Ruby Units](https://github.com/olbrich/ruby-units): Tagged number objects, created with strings.  `Unit.new('1m').to('km').scalar`
- [Stick](http://stick.rubyforge.org/): May have been Van Units in a previous life.  Numeric extensions and global unit methods.  Except that including the global units at the top level locks up the process, so I had to use a module. `x.meters.to(U.km).value`
- [Units-System](https://github.com/jgoizueta/units-system): Uses a block scope to make units available as symbols; create tagged objects by multiplying units with scalars.  `Units.units {x*m.to(km).magnitude}`
- [Units](http://rubygems.org/gems/units): Numeric extensions.  `x.meters.to_km`
- [UOM](https://github.com/caruby/uom/): Tagged wrapper objects.  `UOM::Measurement.new(:m, x).as(:km).to_f`

## The results on my machine:

The library load time is also tested, more as a tie-breaker than a primary concern.  All of the libraries are tested in separate files because many of them make similar extensions to `Numeric`.  Times are in seconds, provide by the standard Benchmark library.

                           convert        load
    ./brute               0.000123    0.000659
    direct                0.000111

    alchemist             0.449174    0.110788
    geo_units             0.091413    0.143500
    m9t                   0.000713    0.206981
    measure/length        0.008206    0.144750
    measurement/length    0.013005    0.133140
    quantity/all          0.006318    0.155692
    ruby-units            0.239024    0.289221
    stick/units           0.065487    0.278137
    units-system          0.054632    0.196454
    units/standard        0.151823    0.113290
    uom                   0.056836    0.257610

