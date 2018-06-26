require "optparse"
require "ostruct"


# Parse command-line options
options = OpenStruct.new({
  "days" => 7,
  "limit" => 25,
})
OptionParser.new do |opt|
  opt.on("--days DAYS", "Number of days of records to check") { |o| options[:days] = o.to_i }
  opt.on("--limit LIMIT", "Max number of records to show") { |o| options[:limit] = o.to_i }
end.parse!

puts options
