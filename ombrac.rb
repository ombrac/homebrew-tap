class Ombrac < Formula
  desc "Safe, fast, small TCP tunnel using Rust"
  homepage "https://github.com/ombrac/ombrac"
  license "Apache-2.0"
  version "0.6.5"

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
             when "x86_64-apple-darwin" then "2cd07f5a4874abf0eec254899eb5b0598c31779ec7dd631663ecd0fbc067f5cb"
             when "aarch64-apple-darwin" then "21a126a9c2791b7b045d87d5b91a16e835e9fe47fd3b4511e0a9e1462dc7a7c1"
             when "x86_64-unknown-linux-gnu" then "0bc4e3e96163c5b1119a314927f3bc8e0c31f77d821ef5c93ca5a9f88f071efa"
             when "aarch64-unknown-linux-gnu" then "7bb0a873b0a2ee5306fdf4c9f493af67e7bb4361d840e18088e0c755b82949be"
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
