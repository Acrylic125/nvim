# Neovim Setup 

## Pre-reqs
1. Install dependencies:
  - [ripgrep](https://github.com/BurntSushi/ripgrep)
  - [fzf](https://github.com/junegunn/fzf)
1. Setup terminal font to [Hack Nerd Font](https://www.nerdfonts.com/) on your terminal.
1. Have fun!

__NOTES__:
- MacOS default terminal may not have sufficient colour support. Use `iterm` or another terminal.
- On your terminal of choice, set the `text font` to `Hack Nerd Font`. For example, on `iterm` and `terminal`, under `Profile > Text`, change the font there.

# IOS Development
For `IOS` Development, (Adapted from [here](https://wojciechkulik.pl/ios/the-complete-guide-to-ios-macos-development-in-neovim))
- Download [xcode-build-server](https://github.com/SolaWing/xcode-build-server)
- Download [sourcekit-lsp](https://github.com/swiftlang/sourcekit-lsp)
- Make sure to set the root by running `sudo xcode-select -s /Applications/Xcode-16.1.0.app/Contents/Developer` (XCode installation location).
- Go to your project, run `xcode-build-server config -scheme <Scheme> -project *.xcodeproj` (e.g. `xcode-build-server config -scheme TestApp -project *.xcodeproj`)

