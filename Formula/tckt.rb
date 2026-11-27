class Tckt < Formula
  desc "Markdown task manager with terminal, web, and MCP interfaces"
  homepage "https://github.com/ut0s/homebrew-tckt"
  version "0.1.4"
  license "MIT"

  on_macos do
    url "https://github.com/ut0s/homebrew-tckt/releases/download/v0.1.4/tckt-v0.1.4-macos-universal.tar.gz"
    sha256 "38d0f4f532de7fd499366854fe700bef3cc3e615f10f393908212efcba5d1188"
    depends_on macos: :sonoma
    depends_on "ut0s/tckt/pppp@0.1.2"
  end

  on_linux do
    on_intel do
      url "https://github.com/ut0s/homebrew-tckt/releases/download/v0.1.4/tckt-v0.1.4-linux-x86_64-musl.tar.gz"
      sha256 "efc639a10e0b58941f817b6d569314196c07e99552e4c073c156d6962ecbb77d"
    end
    on_arm do
      url "https://github.com/ut0s/homebrew-tckt/releases/download/v0.1.4/tckt-v0.1.4-linux-aarch64-musl.tar.gz"
      sha256 "3cb073fa0a7d4a26056bbb3ab2a20a739fe75f400425b2b7130b3cb69748fb91"
    end
  end

  def install
    if OS.mac?
      libexec.install "tckt"
      pppp_bin = Formula["ut0s/tckt/pppp@0.1.2"].opt_bin
      (bin/"tckt").write_env_script libexec/"tckt", PATH: "#{pppp_bin}:$PATH"
      return
    end

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
