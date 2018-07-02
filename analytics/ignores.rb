# Decides if a given path is "interesting" for the purpose of log analysis.
#
# Params:
# +log+:: The parsed log line.
#
def should_be_ignored(parsed_log)
  return false
end
