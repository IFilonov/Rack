class TimeFormat

AVAILABLE_FORMATS = {
  'year'    => '%Y',
  'month'   => '%m',
  'day'     => '%d',
  'hour'    => '%H',
  'minute'  => '%M',
  'second'  => '%S'
}

  def initialize(formats)
    @formats = formats
  end

  def time_string
    times = []
    @formats.each { |format| times.push(Time.now.strftime(AVAILABLE_FORMATS[format])) }
    times.join("-")
  end

  def self.valid?(format)
    AVAILABLE_FORMATS[format]
  end
end
