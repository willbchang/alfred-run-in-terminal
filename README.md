<p align="center">
  <img src="images/icon.png" alt="Run in Terminal Logo" height="150px"><br>
  <sub>Dedicated to my girlfriend  😘  @YangYang </sub>
</p>

# Run in Terminal
An Alfred Workflow to **execute selected file**, **cd to selected folder**, and **run selected text** in Terminal with one hotkey.

## Installation
1. Download [Run in Termianl.alfredworkflow](https://github.com/willbchang/alfred-run-in-terminal/releases/download/V1.0.0/Run-in-Terminal.alfredworkflow).
2. Double click `Run in Terminal.alfredworkflow` to install.
3. Click `Import` Button.
4. Double click `Hotkey` and set your shortcut.(I'm using <kbd>alt</kbd> + <kbd>t</kbd>).

## Usage
<kbd>alt</kbd> + <kbd>t</kbd>
![run in terminal](images/run-in-terminal.gif)
- Launch Terminal if Terminal isn't active.
- Bring Terminal to the front window if Terminal is active.
- Run selected text in Terminal, it avoids `$ ` in the beginning of the first line.
  ```bash
  $ echo select me and press hotkey!
   $ echo Hello $(whoami)
     $    echo Alfred Loves You!
  ```
- `cd` selected file/folder from Finder or Alfred File Browser.
  1. **Enable Quick Search Mode** in `Features -> File Action`.
  2. Launch Alfred and press <kbd>spacebar</kbd> or input a single quote.
  3. Move the highlight block to the destination folder.
  4. *Notice*: if you enabled `Advanced -> History` and browse file with it, you should use <kbd>tab</kbd> or <kbd>←</kbd> or <kbd>→</kbd> to avoid Alfred's default selection.
  5. Press <kbd>alt</kbd> + <kbd>t</kbd> or your own shortcut.
  

### Change Terminal App
1. Open **Alfred Preferences** -> **Workflows**  -> **Open in Terminal**.
2. Double click `Run Script`, replace `Terminal` with `YOUR TERMINAL APP`.
3. Make sure the app name surrounds with **double quote** `""`.

### Add Runtimes
1. Open **Alfred Preferences** -> **Workflows**  -> **Open in Terminal**.
2. Right click `Open in Editor` workflow -> Open in Finder
3. Open `script.rb`, press <kbd>Command</kbd> + <kbd>F</kbd> to find `runtimes`.
   ```ruby
   runtimes = {
     rb: 'ruby',
     sh: 'sh',
     py: 'python',
     go: 'go',
     php: 'php',
     js: 'deno',
     ts: 'deno',
     rs: 'rust'
   }
   ```
4. Add new `FILETYPE: RUNTIME`, you can also set other command for specific file type.

## Contribution
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

## Credits
Icon made by https://www.flaticon.com/authors/kirill-kazachek <br>
It was built with 💖 in [NeoVim](https://neovim.io/) & [RubyMine](https://www.jetbrains.com/ruby/).

## License
[MIT](LICENSE)

