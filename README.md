<p align="center">
  <img src="images/icon.png" alt="Run in Terminal Logo" height="150px"><br>
  <sub>Dedicated to my girlfriend  😘  @YangYang </sub>
</p>

# Run in Terminal
An Alfred Workflow to **execute selected file**, **cd to selected folder**, and **run selected text** in Terminal with one hotkey.

## Installation
1. Download [Run in Termianl.alfredworkflow](https://github.com/willbchang/alfred-run-in-terminal/releases/latest).
2. Double click `Run in Terminal.alfredworkflow` to install.
3. Click `Import` Button.
4. Double click `Hotkey` and set your shortcut.(I'm using <kbd>hyper</kbd> + <kbd>t</kbd>).

## Features
1. **Auto-detect whether current selected text is a filepath and run `cd` if it is.**
  - `~` will be auto expanded to `/Users/$(whoami)` for checking the filepath.
  - Spaces before filepath will be removed in order to use `cd`.
   Input:
   ```bash
   ~/Library/Application Support/
   ```
   Output:
   ```bash
   cd "/Users/$(whoami)/Library/Application Support/" 
   ```
2. **Auto remove the solo `$` in the beginning of lines.**
  - Some bash code snippets always prefix with `$`, it's annoying when copy and running them.
  - It won't affect the bash argument, only the `$` with space will be removed, regex: `/^\s*\$\s+/`

   Input:
   ```bash
   $ temp=$(mktemp)
     $ echo "$temp"
   $ rm "$temp"
   $(whoami)
   ```
   Output:
   ```bash
   temp=$(mktemp)
   echo "$temp"
   rm "$temp"
   $(whoami) 
   ```
3. **Auto-detect whether current Terminal tab is running command, it will open a new tab if current tab has active process.**
  - Tested with `zsh`, `bash` and `fish`.
  - Support [Amazon Q(qterm)](https://docs.aws.amazon.com/amazonq/latest/qdeveloper-ug/command-line.html).
4. **It won't mess up with escaping characters even though this extension uses `ruby`, `applescript` and `shell script` together.**

   Input:
   ```bash
   variable="This is a \$10 \"quote\""
   echo $variable
   ```
   Output:
   ```bash
   variable="This is a \$10 \"quote\""
   echo $variable
   ```

Only **Terminal.app** is supported, the AppleScript that Terminal.app uses is not compatible with iTerm.app, pull requests are welcome for iTerm.app or other terminal emulators.

## LICENSE
AGPL-3.0
