class TimeFormat

AVAILABLE_FORMATS = {
  'year'    => 'year',
  'month'   => 'month',
  'day'     => 'day',
  'hour'    => 'hour',
  'minute'  => 'min',
  'second'  => 'sec'
}

  def initialize(formats)
    @formats = formats
  end

  def time_string
    times = []
    @formats.each do |format|
      times << send(AVAILABLE_FORMATS[format])
      times[-1] = "0" + times[-1] if times[-1].size == 1
    end
    times.join("-")
  end

  private

  def year
    Time.now.year.to_s
  end

  def month
    Time.now.month.to_s
  end

  def day
    Time.now.day.to_s
  end

  def hour
    Time.now.hour.to_s
  end

  def min
    Time.now.min.to_s
  end

  def sec
    Time.now.sec.to_s
  end

end
