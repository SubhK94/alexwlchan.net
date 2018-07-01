require "optparse"
require "ostruct"

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
  puts parse_log_line(line)
}
