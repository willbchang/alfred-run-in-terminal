require 'shellwords'

command = ARGV[0]
terminal = ARGV[1]
command = /^\$\s.*/.match?(command) ? command[2..-1] : command
system %Q(osascript -e 'tell app "#{terminal.shellescape}" to do script "#{command}" activate')

