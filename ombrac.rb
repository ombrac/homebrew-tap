class Ombrac < Formula
  desc "Safe, fast, small TCP tunnel using Rust"
  homepage "https://github.com/ombrac/ombrac"
  license "Apache-2.0"
  version "0.5.5"

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
             when "x86_64-apple-darwin" then "4adce6106f9e5dc3f98845b6a9b26202a7eac97d51c3e71c49a8791826311f7e"
             when "aarch64-apple-darwin" then "42730a35bfd0ea80df45fd8ec7a5ec67ad825a3e96d17e44858420c734303de5"
             when "x86_64-unknown-linux-gnu" then "421e5d9090ea9005df3fb38df4f854baf78def63f266694f4963a3c12e8a36ae"
             when "aarch64-unknown-linux-gnu" then "11249603f27cc78574f77ff479814d2ce818f9867c79317c920a9e08a623bce0"
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
