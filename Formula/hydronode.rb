class Hydronode < Formula
  desc "The HydroNode command line: sensors, values, devices and live data from your terminal"
  homepage "https://hydronode.tech"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/TexhFexLabs/hydronode-cli/releases/download/v0.1.0/hydronode-cli-aarch64-apple-darwin.tar.xz"
      sha256 "94809c45b3ef36b745753513f122d390851de9adf6022fd2c1dc1c17d3a19d87"
    end
    if Hardware::CPU.intel?
      url "https://github.com/TexhFexLabs/hydronode-cli/releases/download/v0.1.0/hydronode-cli-x86_64-apple-darwin.tar.xz"
      sha256 "c257d19f0405252e52d69b46ed91e054cff4950a12cf3d4a91f1bd5ea6fcaea1"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/TexhFexLabs/hydronode-cli/releases/download/v0.1.0/hydronode-cli-aarch64-unknown-linux-musl.tar.xz"
      sha256 "5f638308e9f3ec49b50ebb23206727f46de0c44b27a7ea8b63256124e6122f9e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/TexhFexLabs/hydronode-cli/releases/download/v0.1.0/hydronode-cli-x86_64-unknown-linux-musl.tar.xz"
      sha256 "82f2a85d14e64c4f522d5fc0d49ad3dbaeb53f6e511655b7660f61df1d6d2d5f"
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
