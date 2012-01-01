# Ruby Unit Conversion Shootout

There are a huge number of unit conversion libraries for Ruby.  The decision of which one to use will depend in large part on personal taste, as well as your application's requirements.  If you are throwing arounds lots of values in mixed units, one of the more fluid, magical libraries might make sense.  
My application was rankingobjects retrieved from a bunch of different sources.  I noticed that the distance ranking was taking substantially longer than the other steps (~0.13 seconds vs. less than 0.0001 seconds), and traced this to the Alchemist library, which indeed shows up as the slowpoke of those tested.  This application creates a number of biases in my library selection, such as disqualifiying gems without built-in distance conversions.

## The Contestants

- [Alchemist](http://rubygems.org/gems/alchemist): Numeric extensions.  `x.meters.to.km.to_f`
- brute force: one of the controls, a locally defined method that's about as dirt simple as possible
- direct: another control, does the conversion inline with bare math
- [Geo Units](https://github.com/kristianmandrup/geo_units): has a number of units useful to geographic calculations.  `GeoUnits.meters_to :kms, x`
- [M9t](https://github.com/joeyates/m9t): While it has tagged number objects, I used the direct conversion methods, which proved to be fastest library method.  `M9t::Distance.meters_to_kilometers(x)`
- [Measure](http://rubygems.org/gems/measure): Explicitly constructed tagged numbers.  I had to define miles myself, and kind of hack the number back out.  `Measure.new(x, :meter).as_km.to_a[0]`
- [Measurement](https://github.com/jemmyw/measurement): Tagged number objects, which use meters internall and croak if you specify them explicitly.  `Length.new(x).in_km`
- [Quantity.rb](http://quantity.rubyforge.org/): Numeric extensions. `x.meter.to_km.to_f`
- [Ruby Units](https://github.com/olbrich/ruby-units): Tagged number objects, created with strings.  `Unit.new('1m').to('km').scalar`
- [Stick](http://stick.rubyforge.org/): May have been Van Units in a previous life.  Numeric extensions and global unit methods.  Except that including the global units at the top level locks up the process, so I had to use a module. `x.meters.to(U.km).value`
- [Units-System](https://github.com/jgoizueta/units-system): Uses a block scope to make units available as symbols; adding units to a scalar to create tagged objects is done by multiplication.  `Units.units {x*m.to(km).magnitude}`
- [Units](http://rubygems.org/gems/units): Numeric extensions.  `x.meters.to_km`

## The results on my machine:

The library load time is also tested, more as a tie-breaker than a primary concern.  All of the libraries are tested in separate files because many of them make similar extensions to `Numeric`.

    alchemist - load                   0.110788
    alchemist - conversion             0.449174
    ./brute - load                     0.000659
    ./brute - conversion               0.000123
    direct - conversion                0.000111
    geo_units - load                   0.143500
    geo_units - conversion             0.091413
    m9t - load                         0.206981
    m9t - conversion                   0.000713
    measure/length - load              0.144750
    measure/length - conversion        0.008206
    measurement/length - load          0.133140
    measurement/length - conversion    0.013005
    quantity/all - load                0.155692
    quantity/all - conversion          0.006318
    ruby-units - load                  0.289221
    ruby-units - conversion            0.239024
    stick/units - load                 0.278137
    stick/units - conversion           0.065487
    units-system - load                0.196454
    units-system - conversion          0.054632
    units/standard - load              0.113290
    units/standard - conversion        0.151823
    uom - load                         0.257610
    uom - conversion                   0.056836

