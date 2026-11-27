class PpppAT012 < Formula
  desc "PipoPapo audio CLI for tckt"
  homepage "https://github.com/ut0s/homebrew-pipopapo"
  url "https://github.com/ut0s/homebrew-pipopapo/releases/download/v0.1.2/pppp-v0.1.2-macos-universal.tar.gz"
  version "0.1.2"
  sha256 "d7e464d6a894c45c7839eccca21f69e9195a562b9a691c3f3395fbe528411b61"

  keg_only :versioned_formula

  depends_on macos: :ventura

  def install
    bin.install "pppp"
    pkgshare.install "licenses", "README.txt"
  end

  test do
    assert_equal "pppp 0.1.2", shell_output("#{bin}/pppp --version").strip
  end
end
