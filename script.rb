require 'shellwords'


query = ARGV[0]
terminal = ARGV[1].shellescape
# Remove single quote around file path when selecting from Alfred File Browser
filepath = /^'.*'$/.match?(query) ? query[1..-2] : query
# Remove `$ ` in the beginning of the command, usually in stackoverflow.com or github.com
command = /^\$\s.*/.match?(query) ? query[2..-1] : query
# https://stackoverflow.com/a/14949613/9984029
script = %Q(osascript -e 'tell app "#{terminal}" to do script "COMMAND" activate')

if File.directory?(filepath)
  system script.sub('COMMAND', "cd #{filepath}")
else
  system script.sub('COMMAND', command)
end
