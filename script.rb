query = ARGV[0]
terminal = ARGV[1]

runtimes = {
  rb: 'ruby',
  sh: 'sh',
  py: 'python',
  go: 'go',
  php: 'php',
  js: 'deno',
  ts: 'deno',
  rs: 'rust'
}

def get_filepath(query)
  # Remove single quote around file path when selecting from Alfred File Browser
  /^'.*'/.match?(query) ? query[1..-2] : query
end

def get_file_extension(filepath)
  # Get file extension from file path, without prefix dot, and convert it to a hash key
  File.extname(filepath)[1..-1].to_sym if File.file?(filepath)
end

def get_command(query, runtimes)
  filepath = get_filepath(query)
  file_extension = get_file_extension(filepath)
  # Remove `$ ` in the beginning of the command, usually in stackoverflow.com or github.com
  command = /^\\s.*/.match?(query) ? query[2..-1] : query

  if File.directory?(filepath)
    "cd #{filepath}"
  elsif File.file?(filepath)
    "#{runtimes[file_extension]} #{filepath}"
  else
    command
  end
end

# https://stackoverflow.com/a/14949613/9984029
if query.empty?
  `open -a #{terminal}`
else
  `osascript -e 'tell app "#{terminal}" to do script "#{get_command(query, runtimes)}" activate'`
end

