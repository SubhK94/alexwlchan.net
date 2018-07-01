def get_docker_logs(container_name, days)
  # For some reason 'docker logs' doesn't understand '7d' or similar, so
  # convert to a number of minutes first.
  output = `docker logs #{container_name} --since #{days * 24 * 60}m`
  output.split("\n")
end


NGINX_LOG_REGEX = %r{
  (?:\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})\s-\s-\s
  \[(?<datetime>\d{2}\/[A-Z][a-z]{2}\/\d{4}:\d{2}:\d{2}:\d{2}\s(\+|\-)\d{4})\]\s
  "(?<method>OPTIONS|HEAD|GET|POST)\s(?<url>.+)\sHTTP/1\.[01]"\s
  (?<status>\d{3})\s
  (?<bytes_sent>\d+)\s
  "(?:(\-)|([^"]*))"\s
  "(?<user_agent>[^"]*)"\s
  "(?<forwarded_host>[^"]+)"
}x


def parse_log_line(line)
  match = NGINX_LOG_REGEX.match(line)
  Hash[match.names.zip(match.captures)]
end
