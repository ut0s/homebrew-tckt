class Tckt < Formula
  desc "Markdown task manager with terminal, web, and MCP interfaces"
  homepage "https://github.com/ut0s/homebrew-tckt"
  version "0.1.3"
  license "MIT"

  on_macos do
    url "https://github.com/ut0s/homebrew-tckt/releases/download/v0.1.3/tckt-v0.1.3-macos-universal.tar.gz"
    sha256 "831b3a7587333c0d725347892ab45f62f234e56082fabed838ecef64abacf3f8"
    depends_on macos: :sonoma
  end

  on_linux do
    on_intel do
      url "https://github.com/ut0s/homebrew-tckt/releases/download/v0.1.3/tckt-v0.1.3-linux-x86_64-musl.tar.gz"
      sha256 "cdda97486ddcf34e7e32ffdade2f6c637a7589a8fb38d53015811dbf18f009eb"
    end
    on_arm do
      url "https://github.com/ut0s/homebrew-tckt/releases/download/v0.1.3/tckt-v0.1.3-linux-aarch64-musl.tar.gz"
      sha256 "2f486603a98f71a98b9bc40028e7f3cc43d2290b81a2ff95d2e98964d3cd6912"
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
