# The cask for ryanbrunner/homebrew-tap. `script/release publish` fills in
# version and sha256 for each release and pushes the result to the tap.
# Change it here: the tap's copy is overwritten.
cask "reeve" do
  version "0.2.1"
  sha256 "702ea3a7bd192774b301b69091f3dbbd7c0f52b01c04712bd1390f8e38683d1f"

  url "https://github.com/ryanbrunner/reeve-terminal/releases/download/v#{version}/Reeve.zip"
  name "Reeve"
  desc "Kanban board of Claude Code sessions, each card a terminal"
  homepage "https://github.com/ryanbrunner/reeve-terminal"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sonoma

  # ~/Applications rather than /Applications: just for you, and no admin
  # password to install or upgrade. Homebrew expands ~ in a target, but not
  # in a source, so the binary's path is spelled out.
  app "Reeve.app", target: "~/Applications/Reeve.app"
  binary "#{Dir.home}/Applications/Reeve.app/Contents/Helpers/reeve"

  zap trash: [
    "~/Library/Application Support/Reeve Terminal",
    "~/Library/Preferences/com.ryanbrunner.reeve-terminal.plist",
    "~/Library/Saved Application State/com.ryanbrunner.reeve-terminal.savedState",
  ]

  # Not dependencies: Claude Code and gh are often installed some other way,
  # and a second copy from Homebrew would shadow the one already set up.
  caveats <<~EOS
    Each card runs Claude Code, which Reeve finds on your login shell's PATH.
    Install it and log in once before opening a card:
      https://claude.com/claude-code

    Optional:
      gh     pull request badges on cards (brew install gh; gh auth login)
      gloss  the Preview tab (brew install ryanbrunner/tap/gloss)
  EOS
end
