require_relative 'time_format'
class App

  TIME_PATH = '/time'.freeze
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
    return bad_url if env[PATH_INFO] != '/time'
    formats = get_formats(env[QUERY_STRING])
    if formats
      time_format = TimeFormat.new(formats)
      @body = time_format.time_string
    end
  end

  def get_formats(query_string)
    params = Rack::Utils.parse_query(query_string)
    return bad_params until params[FORMAT_PARAM]
    formats = params[FORMAT_PARAM].split(',')
    if formats.count > 0
      bad_formats = []
      formats.each do |format|
        bad_formats << format unless TimeFormat::valid?(format)
      end
      return bad_params(bad_formats) if bad_formats.count > 0
    end
    formats
  end

  def bad_params(bad_formats = nil)
    @status = BAD_REQUEST
    @body = "Unknown time format"
    @body += " [#{bad_formats.join(",")}]" if bad_formats
    nil
  end

  def bad_url
    @status = NOT_FOUND
    @body = "Bad url"
  end

end
