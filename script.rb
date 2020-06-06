query = ARGV[0]
terminal = ARGV[1]

# Remove single quote around file path when selecting from Alfred File Browser
filepath = /^'.*'$/.match?(query) ? query[1..-2] : query

# Executable programming languages' extension hash
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


if File.directory?(filepath)
  command = "cd #{filepath}"
elsif File.file?(filepath)
  file_extension = File.extname(filepath)[1..-1]
  command = "#{runtime_environments[file_extension.to_sym]} #{filepath}"
else
  # Remove `$ ` in the beginning of the command, usually in stackoverflow.com or github.com
  command = /^\$\s.*/.match?(query) ? query[2..-1] : query
end

# https://stackoverflow.com/a/14949613/9984029
`osascript -e 'tell app "#{terminal}" to do script "#{command}" activate'`
