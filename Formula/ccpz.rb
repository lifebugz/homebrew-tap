class Ccpz < Formula
  desc "Pluginize non-plugin Claude Code repos"
  homepage "https://github.com/lifebugz/ccpluginizer"
  # Required: the download URL embeds the version as a mid-path token
  # (ccpz%400.9.0) with no parseable archive name at the tail, so brew cannot
  # auto-scan it. Do not remove as redundant.
  version "0.9.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/lifebugz/ccpluginizer/releases/download/%40ccpluginizer/ccpz%40#{version}/ccpz-darwin-arm64", using: :nounzip
      sha256 "e7b93a550a671660fdc77b3bf1b78f86f4675f9fcdbb8496bc284a5c2da8d589"
    end
    # arm64-only tap: no Intel-macOS branch on purpose. On an Intel Mac brew install
    # fails with "Error: ccpz: formula requires at least a URL" (documented in README).
  end

  on_linux do
    on_intel do
      url "https://github.com/lifebugz/ccpluginizer/releases/download/%40ccpluginizer/ccpz%40#{version}/ccpz-linux-x64", using: :nounzip
      sha256 "4342e97943bda84a7e8d11ffec3487a27bcb893ea6b68931361055576c0fd4ba"
    end
    on_arm do
      url "https://github.com/lifebugz/ccpluginizer/releases/download/%40ccpluginizer/ccpz%40#{version}/ccpz-linux-arm64", using: :nounzip
      sha256 "63a6099cd28c6262d1de1adf9e4eb0d9f96cc7c3c70b6f6831cec213f5f2cb43"
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
