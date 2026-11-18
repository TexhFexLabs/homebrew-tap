class Hydronode < Formula
  desc "The HydroNode command line: sensors, values, devices and live data from your terminal"
  homepage "https://hydronode.tech"
  version "0.1.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/TexhFexLabs/hydronode-cli/releases/download/v0.1.1/hydronode-cli-aarch64-apple-darwin.tar.xz"
      sha256 "e0a2decca22a0b0b593911f1f948b9424c7dc8598a6caa880a092bd9bb2f8288"
    end
    if Hardware::CPU.intel?
      url "https://github.com/TexhFexLabs/hydronode-cli/releases/download/v0.1.1/hydronode-cli-x86_64-apple-darwin.tar.xz"
      sha256 "bf5b572412c558982c0f9d84da6fe63f1af92e9908419b8f19ddbc99e9ef9aa9"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/TexhFexLabs/hydronode-cli/releases/download/v0.1.1/hydronode-cli-aarch64-unknown-linux-musl.tar.xz"
      sha256 "efddcbb97e7f51000b743ca13424bb48188ac02dd50f8e419b9df952ba54d844"
    end
    if Hardware::CPU.intel?
      url "https://github.com/TexhFexLabs/hydronode-cli/releases/download/v0.1.1/hydronode-cli-x86_64-unknown-linux-musl.tar.xz"
      sha256 "01d1b00e399702977d0b85d1e6abb29c4c75ff63bf3601952fba9109135c661b"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":               {},
    "aarch64-unknown-linux-gnu":          {},
    "aarch64-unknown-linux-musl-dynamic": {},
    "aarch64-unknown-linux-musl-static":  {},
    "x86_64-apple-darwin":                {},
    "x86_64-pc-windows-gnu":              {},
    "x86_64-unknown-linux-gnu":           {},
    "x86_64-unknown-linux-musl-dynamic":  {},
    "x86_64-unknown-linux-musl-static":   {},
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
      bin.install "hn", "hydronode"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "hn", "hydronode"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "hn", "hydronode"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "hn", "hydronode"
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
