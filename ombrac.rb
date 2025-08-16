class Ombrac < Formula
  desc "Safe, fast, small TCP tunnel using Rust"
  homepage "https://github.com/ombrac/ombrac"
  license "Apache-2.0"
  version "0.5.11"

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
             when "x86_64-apple-darwin" then "1feb9140c48b069caa263c1eb520d0f04d29c6a1d4fd244b089e078d4be878ae"
             when "aarch64-apple-darwin" then "a3aacd4abb9b9552c92fac4c5db873c7530fabd7c0265dcc6a70f877ada11e94"
             when "x86_64-unknown-linux-gnu" then "fdeb9da5b1496658cd8125cf9bbe2a0ccbee6b9a4e45daa3854d8b1877c9d32a"
             when "aarch64-unknown-linux-gnu" then "edcf85224310e8b74b9c3fbdea98041a799f97facdf20101814b2dc5382648d7"
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
