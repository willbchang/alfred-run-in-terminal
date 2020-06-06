query = ARGV[0]
terminal = ARGV[1]

runtime_environments = {
  rb: 'ruby',
  sh: 'sh',
  py: 'python',
  go: 'go',
  php: 'php',
  js: 'deno',
  ts: 'deno',
  rs: 'rust'
}

def get_command(query, runtime_environments)
  # Remove single quote around file path when selecting from Alfred File Browser
  filepath = /^'.*'/.match?(query) ? query[1..-2] : query
  # Remove `$ ` in the beginning of the command, usually in stackoverflow.com or github.com
  command = /^\\s.*/.match?(query) ? query[2..-1] : query

  if File.directory?(filepath)
    "cd #{filepath}"
  elsif File.file?(filepath)
    # Get file extension from file path, without prefix dot, and convert it to a hash key
    file_extension = File.extname(filepath)[1..-1].to_sym
    "#{runtime_environments[file_extension]} #{filepath}"
  else
    command
  end
end

# https://stackoverflow.com/a/14949613/9984029
if query.empty?
  `open -a #{terminal}`
else
  `osascript -e 'tell app "#{terminal}" to do script "#{get_command(query, runtime_environments)}" activate'`
end

