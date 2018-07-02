IGNORE_USER_AGENT_FRAGMENTS = [
  "bingbot/2.0",
]


# Can we ignore logs from this user agent?
#
# For example: crawlers, spiders, automated requests.
#
def user_agent_should_be_ignored(user_agent)
  if IGNORE_USER_AGENT_FRAGMENTS.any? { |frag| user_agent.include? frag }
    return true
  end

  false
end


# Decides if a given path is "interesting" for the purpose of log analysis.
#
# Params:
# +log+:: The parsed log line.
#
def should_be_ignored(parsed_log)

  if user_agent_should_be_ignored(parsed_log["user_agent"])
    return true
  end

  return false
end
