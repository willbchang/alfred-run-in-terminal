require 'shellwords'

def get_filepath(query)
  # Remove single quote around file path when selecting from Alfred File Browser
  filepath = /^'.*'/.match?(query) ? query[1..-2] : query
  space_tilde_slash = /^\s*~\//
  if filepath.start_with?(space_tilde_slash)
    username = `whoami`.strip
    subpath = filepath.sub(space_tilde_slash, '')
    "/Users/#{username}/#{subpath}"
  else
    filepath.gsub(/^\s*/, '')
  end
end

def get_filetype(filepath)
  # Get file extension from file path, without prefix dot, and convert it to a hash key
  File.extname(filepath)[1..-1].to_sym if File.file?(filepath)
end

def get_script(query, runtimes)
  filepath = get_filepath(query)
  filetype = get_filetype(filepath)

  if File.directory?(filepath)
    "cd \\\"#{filepath}\\\""
  elsif File.file?(filepath)
    "#{runtimes[filetype]} \\\"#{filepath}\\\""
  else
    query.gsub(/^\s*\$\s+/, '')
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

