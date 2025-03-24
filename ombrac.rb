class Ombrac < Formula
  desc "Safe, fast, small TCP tunnel using Rust"
  homepage "https://github.com/ombrac/ombrac"
  license "Apache-2.0"
  version "0.5.0"

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
             when "x86_64-apple-darwin" then "6c350a74dfa2ff00e9259b7353729680113a9267ee0beaf86bcddaf7dbdc02fb"
             when "aarch64-apple-darwin" then "6088c7ecfbd3d3c3da0509b162077b7feddc31b1bea5a6430d90d3777b663665"
             when "x86_64-unknown-linux-gnu" then "ce3777b74146d118ebc75f707ea78b9b56275c2654aed1e43d7f21c5ec7888c4"
             when "aarch64-unknown-linux-gnu" then "b28c8055412ebf7d06f9eee1f5ceeaadad449f1d5effb5611b9a55da940f4340"
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
