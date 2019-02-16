class App

  TIME_PATH = '/time'.freeze
  AVAILABLE_FORMATS = {
    'year'    => 'year',
    'month'   => 'month',
    'day'     => 'day',
    'hour'    => 'hour',
    'minute'  => 'min',
    'second'  => 'sec'
  }
  FORMAT_PARAM = 'format'
  PATH_INFO = 'PATH_INFO'
  QUERY_STRING = 'QUERY_STRING'

  SUCCESS     = 200
  BAD_REQUEST = 400
  NOT_FOUND   = 404

  def call(env)
    @status = SUCCESS
    process_request(env)
    [@status, headers, [@body]]
  end

  def headers
    { 'Content-Type' => 'text/plain'}
  end

private

  def process_request(env)
    retrun @status = NOT_FOUND if env[PATH_INFO] != '/time'
    formats = get_formats(env[QUERY_STRING])
    time_string(formats) if formats
  end

  def get_formats(query_string)
    params = Rack::Utils.parse_query(query_string)
    formats = params[FORMAT_PARAM].split(',') if params[FORMAT_PARAM]
    bad_formats = []
    if formats.count > 0
      formats.each do |format|
        bad_formats << format unless AVAILABLE_FORMATS.include?(format)
      end
    end
    if bad_formats.count > 0
      @status = BAD_REQUEST
      @body = "Unknown time format [#{bad_formats.join(",")}]"
      return
    end
    return formats
  end

  def time_string(formats)
    times = []
    formats.each do |format|
      times << send(AVAILABLE_FORMATS[format])
      times [-1] = "0" + times [-1] if times [-1].size == 1
    end
    @body = times.join("-")
  end

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
