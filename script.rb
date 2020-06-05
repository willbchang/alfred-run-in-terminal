require 'shellwords'

def cd_folder(terminal, path)
  system %Q(osascript -e 'tell app "#{terminal.shellescape}" to do script "cd #{path.shellescape}" activate')
end

def run_command(terminal, command)
  command = /^\$\s.*/.match?(command) ? command[2..-1] : command
  system %Q(osascript -e 'tell app "#{terminal.shellescape}" to do script "#{command}" activate')
end

query = ARGV[0]
terminal = ARGV[1]
# Remove single quote around file path when selecting from Alfred File Browser
filepath = /^'.*'$/.match?(query) ? query[1..-2] : query
if File.directory?(filepath)
  cd_folder(terminal, filepath)
else
  run_command(terminal, query)
  
end
