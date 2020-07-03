def get_filepath(query)
  # Remove single quote around file path when selecting from Alfred File Browser
  /^'.*'/.match?(query) ? query[1..-2] : query
end

def get_filetype(filepath)
  # Get file extension from file path, without prefix dot, and convert it to a hash key
  File.extname(filepath)[1..-1].to_sym if File.file?(filepath)
end

def remove_dollar(text)
  # Remove `$ ` or ` $ ` in the beginning of the command, usually in stackoverflow.com or github.com
  if /^\$\s.*/.match?(text)
    text[2..-1]
  elsif /^\s?\$\s.*/.match?(text)
    text[3..-1]
  else
    text
  end
end

def get_command(query)
 query.lines.map{|line| remove_dollar(line)}.join
end

def get_script(query, runtimes)
  filepath = get_filepath(query)
  filetype = get_filetype(filepath)

  if File.directory?(filepath)
    "cd #{filepath}"
  elsif File.file?(filepath)
    "#{runtimes[filetype]} #{filepath}"
  else
    get_command(query)
  end
end

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

if query.empty?
  `open -a #{terminal}`
else
  `osascript -e 'tell app "#{terminal}" to do script "#{get_script(query, runtimes)}" activate'`
end

