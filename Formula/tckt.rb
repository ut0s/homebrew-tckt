class Tckt < Formula
  desc "Markdown task manager with terminal, web, and MCP interfaces"
  homepage "https://github.com/ut0s/homebrew-tckt"
  version "0.1.1"
  license "MIT"

  on_macos do
    url "https://github.com/ut0s/homebrew-tckt/releases/download/v0.1.1/tckt-v0.1.1-macos-universal.tar.gz"
    sha256 "99de5934acab2e0ffdfaf9351c826eec74d596c8c1c7f7ba3f18f85203ca23ad"
    depends_on macos: :sonoma
  end

  on_linux do
    on_intel do
      url "https://github.com/ut0s/homebrew-tckt/releases/download/v0.1.1/tckt-v0.1.1-linux-x86_64-musl.tar.gz"
      sha256 "af556f5a9bfc8364315c9abe3ea9dd3ea3a2d96112d4bfc03ad31ea4255b79fb"
    end
    on_arm do
      url "https://github.com/ut0s/homebrew-tckt/releases/download/v0.1.1/tckt-v0.1.1-linux-aarch64-musl.tar.gz"
      sha256 "a74204655fc30c4243ff6c8721ddceb98b1645e2c501006d40415475eee39637"
    end
  end

  def install
    bin.install "tckt"
  end

  service do
    run [opt_bin/"tckt", "service", "run"]
    keep_alive true
    working_dir HOMEBREW_PREFIX/"var"
    log_path var/"log/tckt.log"
    error_log_path var/"log/tckt.log"
  end

  def caveats
    <<~EOS
      Run tckt init in a project directory, then tckt web to open the UI.
      Optional shared server: brew services start ut0s/tckt/tckt
      Port 4317 must be free; stop other tckt services first.
      After upgrades, restart the server with brew services restart ut0s/tckt/tckt.
    EOS
  end

  test do
    ENV["TCKT_DATA_DIR"] = testpath/"data"
    ENV["TCKT_CONFIG_DIR"] = testpath/"config"
    assert_match version.to_s, shell_output("#{bin}/tckt --version")
    system bin/"tckt", "init"
    system bin/"tckt", "add", "Homebrew smoke test"
    assert_match "Homebrew smoke test", shell_output("#{bin}/tckt --json list")
  end
end
