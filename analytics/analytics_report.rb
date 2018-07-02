require "cgi"
require "optparse"
require "ostruct"
require "uri"

require "./docker_logs.rb"

# Parse command-line options
options = OpenStruct.new({
  "days" => 7,
  "limit" => 25,
})
OptionParser.new do |opt|
  opt.on("--days DAYS", "Number of days of records to check") { |o| options[:days] = o.to_i }
  opt.on("--limit LIMIT", "Max number of records to show") { |o| options[:limit] = o.to_i }
end.parse!


logs = get_docker_logs(container_name = CONTAINER_NAME, days = options.days)

logs.each { |line|
  parsed_log = parse_log_line(line)

  # Only clients with JavaScript and no DNT request this tracking pixel;
  # requests for anything other than the tracking pixel should be ignored.
  if !parsed_log["url"].start_with?("/analytics/a.gif")
    next
  end

  # Now unpack the contents of the tracking pixel metadata.
  query = URI.parse(parsed_log["url"]).query
  parsed_query = CGI.parse(query)
  parsed_log["query"] = {
    "title" => parsed_query["t"].first,
    "referrer" => parsed_query["ref"].first,
    "url" => parsed_query["url"].first,
  }

  puts parsed_log
}
