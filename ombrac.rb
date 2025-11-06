class Ombrac < Formula
  desc "Safe, fast, small TCP tunnel using Rust"
  homepage "https://github.com/ombrac/ombrac"
  license "Apache-2.0"
  version "0.6.4"

  os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"
  arch = case Hardware::CPU.arch
         when :x86_64 then "x86_64"
         when :arm64 then "aarch64"
         else
           raise "ombrac: unsupported system architecture #{Hardware::CPU.arch}"
         end

  @@filename = "ombrac-#{arch}-#{os}.tar.gz"
  @@url = "https://github.com/ombrac/ombrac/releases/download/v#{version}/#{@@filename}"

  @@sha256 = case "#{arch}-#{os}"
             when "x86_64-apple-darwin" then "208ceb2d006817cae12231dea272ef9c5716433fcd3732f6358ed7c2113dd3f7"
             when "aarch64-apple-darwin" then "4c9179b3545f27a5d66b5e02fcb732882b2706495100ee4e6899a285347fca10"
             when "x86_64-unknown-linux-gnu" then "2b3bc9118c48ec3ee0cba950e7cc39a3bf76dfd1001cfa3b799d47452b2b073c"
             when "aarch64-unknown-linux-gnu" then "9d8a7858fd8d2140f7e4453c2ce2fde761c064d5aa0fb082ac0b107b1f8cab43"
             else
               raise "ombrac: unsupported system #{arch}-#{os}"
             end

  sha256 @@sha256
  url @@url

  def install
    bin.install "ombrac-client"
    bin.install "ombrac-server"
  end

  test do
    system "#{bin}/ombrac-client", "--version"
    system "#{bin}/ombrac-server", "--version"
  end
end
