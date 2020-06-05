require 'shellwords'


def run_command(terminal, command)
  command = /^\$\s.*/.match?(command) ? command[2..-1] : command
  system %Q(osascript -e 'tell app "#{terminal.shellescape}" to do script "#{command}" activate')
end

query = ARGV[0]
terminal = ARGV[1]
run_command(terminal, query)

