require 'shellwords'

def cd_folder(terminal, path)
  system %Q(osascript -e 'tell app "#{terminal.shellescape}" to do script "cd #{path.shellescape}" activate')
end

def run_command(terminal, command)
  system %Q(osascript -e 'tell app "#{terminal.shellescape}" to do script "#{command}" activate')
end

terminal = ARGV[1].shellescape
query = ARGV[0]
# Remove single quote around file path when selecting from Alfred File Browser
filepath = /^'.*'$/.match?(query) ? query[1..-2] : query
# Remove `$ ` in the beginning of the command, usually in stackoverflow.com or github.com
command = /^\$\s.*/.match?(query) ? query[2..-1] : query

if File.directory?(filepath)
  cd_folder(terminal, filepath)
else
  run_command(terminal, command)
end
