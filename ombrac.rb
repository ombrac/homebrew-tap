class Ombrac < Formula
  desc "Safe, fast, small TCP tunnel using Rust"
  homepage "https://github.com/ombrac/ombrac"
  license "Apache-2.0"
  version "0.5.12"

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
             when "x86_64-apple-darwin" then "a9896f196000d0c5e6f9538107228407fa77259d18327eea27dfe368b9688799"
             when "aarch64-apple-darwin" then "38d292d732392b6128949321ef6401d4356611b327dab8b0d0cd4ceccf45fd06"
             when "x86_64-unknown-linux-gnu" then "e9c8b08aa7eb2c06cc5f52f43e916e380c85246bc1bfaa1154197a6417c81a78"
             when "aarch64-unknown-linux-gnu" then "2c02e0d36207a0963be62c3486935eb3e835e12f695050eb37ce6cf2e79df499"
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
