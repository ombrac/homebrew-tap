class Ombrac < Formula
  desc "Safe, fast, small TCP tunnel using Rust"
  homepage "https://github.com/ombrac/ombrac"
  license "Apache-2.0"
  version "0.7.13"

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
             when "x86_64-apple-darwin" then "7e96fca620d5fe64d0fe848bd5f88b52afb48028c64ca56471ebbdc8c0c99993"
             when "aarch64-apple-darwin" then "0fd57f3cb9afd25bc89dcfc076b74f6974c2c8eaa736db24e4f35205a3abef6f"
             when "x86_64-unknown-linux-gnu" then "5e2587976b1e1cebab65d940980005a794e9ffb0687902d01cf1d44afcb9ecf2"
             when "aarch64-unknown-linux-gnu" then "951c21d93423d22a13ca8f1066d50d86130e3d90fb4014994494d319c121e845"
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
