class Ombrac < Formula
  desc "Safe, fast, small TCP tunnel using Rust"
  homepage "https://github.com/ombrac/ombrac"
  license "Apache-2.0"
  version "0.5.7"

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
             when "x86_64-apple-darwin" then "adbf178f263de79a0895963adf476c096fcce7028982b41246cc1cad90772144"
             when "aarch64-apple-darwin" then "54601a550381cd8b6743007bb417d7715b7aaefddc2b7b377a38644e71c52c69"
             when "x86_64-unknown-linux-gnu" then "074a68dacd45a2c9b7264cabe60ab34a7a92ba8f4434e9aed49faeff30fbf677"
             when "aarch64-unknown-linux-gnu" then "f0fbeb7d80c27cc4e06bedb82483d1563e732e125ec4d4bc3e6f8e58bca61a8e"
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
