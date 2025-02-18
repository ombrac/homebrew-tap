class Ombrac < Formula
  desc "Safe, fast, small TCP tunnel using Rust"
  homepage "https://github.com/ombrac/ombrac"
  license "Apache-2.0"
  version "0.3.2"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ombrac/ombrac/releases/download/v0.3.2/ombrac-aarch64-apple-darwin.tar.gz"
      sha256 "6eed20358e14fb91daaaf1f464c1fef66ee41c6f32d55c6ce27ce93665506d9b"
    elsif Hardware::CPU.intel?
      url "https://github.com/ombrac/ombrac/releases/download/v0.3.2/ombrac-x86_64-apple-darwin.tar.gz"
      sha256 "dfae33027b4254e4de6adda1535248600471b5b99a09349e4cfb697307888125"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ombrac/ombrac/releases/download/v0.3.2/ombrac-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "4a6888ec0fb455a96fcf23ed7f882d7b089936541964ffa4d8b866e97ece4639"
    elsif Hardware::CPU.intel?
      url "https://github.com/ombrac/ombrac/releases/download/v0.3.2/ombrac-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "91762776178885c5cf586898224d52ee8854524c43dfacb50603bbd0f955f098"
    end
  end

  def install
    bin.install "ombrac-client"
    bin.install "ombrac-server"
  end

  test do
    system "#{bin}/ombrac-client", "--version"
    system "#{bin}/ombrac-server", "--version"
  end
end
