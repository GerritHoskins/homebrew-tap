class Hushpush < Formula
  desc "Find likely personal data in logs and screenshots before pushing"
  homepage "https://github.com/GerritHoskins/hushpush"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/GerritHoskins/hushpush/releases/download/v0.1.0/hushpush-cli-aarch64-apple-darwin.tar.xz"
      sha256 "a2464601b6cd6e62b0f742ea75535c95a2f181d32cfdf3966fb653677d0d1f50"
    end
    if Hardware::CPU.intel?
      url "https://github.com/GerritHoskins/hushpush/releases/download/v0.1.0/hushpush-cli-x86_64-apple-darwin.tar.xz"
      sha256 "8b7a26a04562324e1cecfa6001ca99723c3b3c9dc66a4d941299f210c92e7069"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/GerritHoskins/hushpush/releases/download/v0.1.0/hushpush-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "b2eab85366c7c2838f3b2280e92243eee7d349a35efa9eb2085295be8ca02595"
    end
    if Hardware::CPU.intel?
      url "https://github.com/GerritHoskins/hushpush/releases/download/v0.1.0/hushpush-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "9b1e0cf8d527d32ffa4ac293eff0327f33078e11dbc5840530a1c15a372b5f92"
    end
  end
  license any_of: ["MIT", "Apache-2.0"]

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "hushpush"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "hushpush"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "hushpush"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "hushpush"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
