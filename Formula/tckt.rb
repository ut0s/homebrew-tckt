class Tckt < Formula
  desc "Markdown task manager with terminal, web, and MCP interfaces"
  homepage "https://github.com/ut0s/homebrew-tckt"
  version "0.1.2"
  license "MIT"

  on_macos do
    url "https://github.com/ut0s/homebrew-tckt/releases/download/v0.1.2/tckt-v0.1.2-macos-universal.tar.gz"
    sha256 "3c01b90c221e6e0d1a017037a62cd8f1ebd677c138ffdd1a128405ae090c38b1"
    depends_on macos: :sonoma
  end

  on_linux do
    on_intel do
      url "https://github.com/ut0s/homebrew-tckt/releases/download/v0.1.2/tckt-v0.1.2-linux-x86_64-musl.tar.gz"
      sha256 "8fe7b0cfda2b680ed3c532527f0b0e2a3d3691f0f14e732cdd40692153266d0f"
    end
    on_arm do
      url "https://github.com/ut0s/homebrew-tckt/releases/download/v0.1.2/tckt-v0.1.2-linux-aarch64-musl.tar.gz"
      sha256 "461aafba7ed22c591954e949b439b14863977413020c0274206892fdb7b0b8f4"
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
