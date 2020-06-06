require 'shellwords'


query = ARGV[0]
terminal = ARGV[1].shellescape
# Remove single quote around file path when selecting from Alfred File Browser
filepath = /^'.*'$/.match?(query) ? query[1..-2] : query
# Remove `$ ` in the beginning of the command, usually in stackoverflow.com or github.com
command = /^\$\s.*/.match?(query) ? query[2..-1] : query
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

# https://stackoverflow.com/a/14949613/9984029
script = %Q(osascript -e 'tell app "#{terminal}" to do script "COMMAND" activate')

p filepath
p File.file?(filepath)
if File.directory?(filepath)
  system script.sub('COMMAND', "cd #{filepath}")
elsif File.file?(filepath)
  file_extension = File.extname(filepath)[1..-1]
  system script.sub('COMMAND', "#{runtime_environments[file_extension.to_sym]} #{filepath}")
else
  system script.sub('COMMAND', command)
end
