class Ombrac < Formula
  desc "Safe, fast, small TCP tunnel using Rust"
  homepage "https://github.com/ombrac/ombrac"
  license "Apache-2.0"
  version "0.4.1"

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
             when "x86_64-apple-darwin" then "7c6c380017e6f6f6b54aa3d9995947c1b79b9933955bd454deee68f9f3ace5df"
             when "aarch64-apple-darwin" then "83a1ef32997a4790b28fd6674111cb507a38e0ce2df893ad12bd52f3d8ac3b82"
             when "x86_64-unknown-linux-gnu" then "e44487fca3ce974c0a66060e1da49d22ce56c71278f0ac988a11362f1f913b96"
             when "aarch64-unknown-linux-gnu" then "1ef4dffe848e0c37d740116a865732d4997552e7cc8e1df6c11fe072d03e7ecd"
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
