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
# https://stackoverflow.com/a/41553295/5520270
def get_default_shell
  `dscl . -read /Users/$(whoami) UserShell | sed 's/UserShell: \\\/.*\\\///'`
end

`
osascript <<EOF
-- Get the title of the Terminal window
-- Please enable the Active process name
-- Settings → Profiles → Window → Active process name
tell application "Terminal"
	activate
	set frontWindow to front window
	set windowTitle to name of frontWindow

 	-- Create a new tab if the window title does not end with shell name or login, which means it has active process.
	if not (windowTitle ends with "-#{get_default_shell}" or windowTitle ends with "login") then
		tell application "System Events" to keystroke "t" using command down
	end if

	-- Select current tab and run shell script
	set theTab to selected tab in first window
	do script "#{get_script(ARGV[0], runtimes)}" in theTab
end tell
EOF
`

