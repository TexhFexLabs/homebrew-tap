class Hydronode < Formula
  desc "The HydroNode command line: sensors, values, devices and live data from your terminal"
  homepage "https://hydronode.tech"
  version "0.1.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/TexhFexLabs/hydronode-cli/releases/download/v0.1.2/hydronode-cli-aarch64-apple-darwin.tar.xz"
      sha256 "e4fe1b3a0c34825c75fb86da8947107ca7561ab740c763e1d526a41ed36daf53"
    end
    if Hardware::CPU.intel?
      url "https://github.com/TexhFexLabs/hydronode-cli/releases/download/v0.1.2/hydronode-cli-x86_64-apple-darwin.tar.xz"
      sha256 "d9bff9b9665ea71b9568080127a4d22315a6b0974b6e8e412e87f2ba403f8e1c"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/TexhFexLabs/hydronode-cli/releases/download/v0.1.2/hydronode-cli-aarch64-unknown-linux-musl.tar.xz"
      sha256 "4c0e09d859fef345a6f13d06e8cb14b6c38a61827a1991acc12f596c1d4f9fb5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/TexhFexLabs/hydronode-cli/releases/download/v0.1.2/hydronode-cli-x86_64-unknown-linux-musl.tar.xz"
      sha256 "06ada1312137372754f96ddf86ca592323db7d4a18a91832f66a34b82fec9537"
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
