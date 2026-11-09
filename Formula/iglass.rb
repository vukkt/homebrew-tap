# Homebrew formula for iglass, published in github.com/vukkt/homebrew-tap as Formula/iglass.rb.
# Edit it here: when a release is published, the Release workflow fills in url and sha256 for
# that release, checks the formula with brew audit, install and test, and pushes it to the tap.
class Iglass < Formula
  desc "Liquid Glass theme for iTerm2, Ghostty, kitty and Warp"
  homepage "https://github.com/vukkt/iglass"
  url "https://github.com/vukkt/iglass/archive/refs/tags/v1.7.0.tar.gz"
  sha256 "cfd4bc3dc1e2069b9b5f240b4f8e6ccc87eaafa005866f6b0da5bf98fc41a382"
  license "MIT"

  on_linux do
    depends_on "jq"
  end

  def install
    libexec.install "bin", "lib", "data"
    bin.install_symlink libexec/"bin/iglass"
    bash_completion.install "completions/iglass.bash" => "iglass"
    zsh_completion.install "completions/_iglass"
    fish_completion.install "completions/iglass.fish"
  end

  def caveats
    <<~EOS
      To install the theme into your terminal (iTerm2, Ghostty, kitty or Warp), run:
        iglass install
      Remove it before uninstalling the formula:
        iglass uninstall
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/iglass --version")
    assert_match "iglass Frosted", shell_output("#{bin}/iglass export --terminal iterm2")
    assert_path_exists zsh_completion/"_iglass"
  end
end
