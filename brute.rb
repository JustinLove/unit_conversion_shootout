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
