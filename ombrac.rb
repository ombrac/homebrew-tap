class Ombrac < Formula
  desc "Safe, fast, small TCP tunnel using Rust"
  homepage "https://github.com/ombrac/ombrac"
  license "Apache-2.0"
  version "0.7.12"

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
             when "x86_64-apple-darwin" then "02f31af877a0bac96e53bd2f0816c78ebd0f3991f666163108e814e6e014d6eb"
             when "aarch64-apple-darwin" then "f7b3252b39188077fd30da2b22a6a241910b27f26d8a6871cdcdc4b85082b4cb"
             when "x86_64-unknown-linux-gnu" then "527e91dfa5a1dec96bf505a6ecf79831302930bb1d08c814541aa92f9671baa8"
             when "aarch64-unknown-linux-gnu" then "e04625327fde454724173c9a57f488739185c11b0f569e1a3d7200f05d05692d"
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
