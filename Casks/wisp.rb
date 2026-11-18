cask "wisp" do
  version "0.1.0"
  sha256 "0000000000000000000000000000000000000000000000000000000000000000"

  url "https://github.com/karanzykx/wisp/releases/download/v#{version}/Wisp.dmg"
  name "Wisp"
  desc "Safe, one-click deep clean for developer Macs"
  homepage "https://github.com/karanzykx/wisp"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on :macos

  app "Wisp.app"
  # The same cleaner engine the app uses, available in the terminal as `wisp`.
  binary "#{appdir}/Wisp.app/Contents/Resources/wisp.sh", target: "wisp"

  # Wisp is not notarised by Apple.
  # Homebrew has already verified the download against the sha256 above, so the quarantine
  # flag is cleared to spare you the first-launch Gatekeeper prompt. This is the only thing
  # this step does. To keep the prompt, install the DMG manually instead.
  postflight_steps do
    run "/usr/bin/xattr",
        args:         ["-dr", "com.apple.quarantine", "{{appdir}}/Wisp.app"],
        must_succeed: false
  end

  zap trash: [
    "~/.config/wisp",
    "~/Library/Logs/Wisp",
    "~/Library/Preferences/io.github.karanzykx.wisp.plist",
    "~/Library/Saved Application State/io.github.karanzykx.wisp.savedState",
  ]
end
