class Ombrac < Formula
  desc "Safe, fast, small TCP tunnel using Rust"
  homepage "https://github.com/ombrac/ombrac"
  license "Apache-2.0"
  version "0.4.0"

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
             when "x86_64-apple-darwin" then "b2d04e5966e933fc6d5e5308ff6eaf9c3060f6c988be8f17161f1210e0422cf6"
             when "aarch64-apple-darwin" then "940c844512abd0f56307445df93cb73e7437175daccf4c9b606b218ff28ef1dc"
             when "x86_64-unknown-linux-gnu" then "915d60e9485e6b76bba3a7097d44c13663a20ceae74ad1703f5abf49d617f2fa"
             when "aarch64-unknown-linux-gnu" then "55bb6f2ab8e0d4da8ab61526df4b637c880da74ade5a002be740f709445144f8"
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
