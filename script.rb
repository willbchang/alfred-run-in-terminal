require 'shellwords'

def get_filepath(query)
  # Remove single quote around file path when selecting from Alfred File Browser
  /^'.*'/.match?(query) ? query[1..-2] : query
end

def get_filetype(filepath)
  # Get file extension from file path, without prefix dot, and convert it to a hash key
  File.extname(filepath)[1..-1].to_sym if File.file?(filepath)
end

def get_script(query, runtimes)
  filepath = get_filepath(query)
  filetype = get_filetype(filepath)
  # The \ in filepath has to be escaped third time so that it will actually work.
  # The first time \\\\\\\\ is in ruby string,
  # The second time \\\\ is in bash script,
  # The third time \\ is in apple script,
  # The fourth time \ is in Terminal app which will escape the special character(s).
  escaped_filepath = filepath.shellescape.gsub('\\', '\\\\\\\\')

  if File.directory?(filepath)
    "cd #{escaped_filepath}"
  elsif File.file?(filepath)
    "#{runtimes[filetype]} #{escaped_filepath}"
  else
    query.gsub(/^\s*\$\s*/, '')
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
  js: 'node',
  ts: 'deno',
  rs: 'rust'
}

if query.empty?
  `open -a #{terminal}`
else
  `osascript -e 'tell app "#{terminal}" to do script "#{get_script(query, runtimes)}" activate'`
end

