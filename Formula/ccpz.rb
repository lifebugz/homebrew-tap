class Ccpz < Formula
  desc "Pluginize non-plugin Claude Code repos"
  homepage "https://github.com/lifebugz/ccpluginizer"
  # Required: the download URL embeds the version as a mid-path token
  # (ccpz%400.8.0) with no parseable archive name at the tail, so brew cannot
  # auto-scan it. Do not remove as redundant.
  version "0.8.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/lifebugz/ccpluginizer/releases/download/%40ccpluginizer/ccpz%40#{version}/ccpz-darwin-arm64", using: :nounzip
      sha256 "4e42bb32e2eb558680eac989a2cbe8c02aedec1a17a2ace24ce90526e1f33f11"
    end
    # arm64-only tap: no Intel-macOS branch on purpose. On an Intel Mac brew install
    # fails with "Error: ccpz: formula requires at least a URL" (documented in README).
  end

  on_linux do
    on_intel do
      url "https://github.com/lifebugz/ccpluginizer/releases/download/%40ccpluginizer/ccpz%40#{version}/ccpz-linux-x64", using: :nounzip
      sha256 "4f74fc1c806a8dcae66c0695789233a6eccdfa7db5f20957cdecb3482acab3f0"
    end
    on_arm do
      url "https://github.com/lifebugz/ccpluginizer/releases/download/%40ccpluginizer/ccpz%40#{version}/ccpz-linux-arm64", using: :nounzip
      sha256 "211016526794b64c02fcd0f3c1a3e546093b7abad3fcc8f9050380c8b0ffd24f"
    end
  end

  def install
    # :nounzip stages exactly one file. Glob "*" instead of a name pattern so install
    # never depends on the staged filename. Parenthesized odie keeps Style/AndOr happy.
    binary = Dir["*"].find { |f| File.file?(f) } || odie("ccpz: no downloaded binary staged")
    bin.install binary => "ccpz"
  end

  test do
    # ccpz has no --version/--help. Exercise a real subcommand with a known nonzero
    # exit (1) and stable error text.
    (testpath/"bad.json").write("not json")
    output = shell_output("#{bin}/ccpz validate #{testpath}/bad.json 2>&1", 1)
    assert_match("Invalid JSON", output)
  end
end
