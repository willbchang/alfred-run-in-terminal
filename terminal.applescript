on run argv
	tell application "Terminal"
		activate
		-- If there are no open windows, open one.
		if (count of windows) is less than 1 then
			do script ""
		else
			-- Get the last process from current tab.
			set terminalWindow to window 1
			set tabInfo to properties of tab 1 of terminalWindow
			set processList to processes of tabInfo
			set lastProcess to (last item of processList)

			-- Get the last process from the next tty if using figterm
			if (lastProcess ends with "(figterm)") then
				set ttyDevice to tty of tabInfo
				do shell script "ruby shell_process.rb " & quoted form of ttyDevice
				set lastProcess to the result
			end if

			-- Create a new tab if current tab has active process.
			set defaultShell to do shell script "dscl . -read /Users/$(whoami) UserShell | sed 's/UserShell: \\/.*\\//-/'"
			if not (lastProcess ends with defaultShell or lastProcess ends with "login") then
				tell application "System Events" to keystroke "t" using command down
			end if
		end if

		-- Format the command
		do shell script "ruby format_command.rb " & quoted form of (item 1 of argv)
		set formatCommand to the result

		-- Select current tab and run shell script
		set theTab to selected tab in first window
		do script formatCommand in theTab
	end tell
end run
