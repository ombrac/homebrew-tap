class Ombrac < Formula
  desc "Safe, fast, small TCP tunnel using Rust"
  homepage "https://github.com/ombrac/ombrac"
  license "Apache-2.0"
  version "0.5.13"

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
             when "x86_64-apple-darwin" then "72dea343dd6c350f81342e3b74455ebd127443bf365b7022671d6dd230bee212"
             when "aarch64-apple-darwin" then "62c2ba1c50f8a9cd6bfb4a26dac3596e4c7408cc7874fc12beb60aa654e1b525"
             when "x86_64-unknown-linux-gnu" then "02f27234c6bf19caedd927d995e7d60527caa451bbcacaa1e707af41ba81c95c"
             when "aarch64-unknown-linux-gnu" then "16133abbd16a87d8f022c95e98fd5d3cea4e0d9cc07b8d18112d743c9dea8abc"
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
