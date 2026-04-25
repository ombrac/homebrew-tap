class Ombrac < Formula
  desc "Safe, fast, small TCP tunnel using Rust"
  homepage "https://github.com/ombrac/ombrac"
  license "Apache-2.0"
  version "0.7.7"

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
             when "x86_64-apple-darwin" then "3f9717a11427b8a1b570cf278a8b373212931b599a32ae70c05a5e7fd0505f1f"
             when "aarch64-apple-darwin" then "92675403382d0f065b8b54e820b043cf8dcbf8ec15ca16b6f6d0865ac0c6ae1a"
             when "x86_64-unknown-linux-gnu" then "efc0be6a48cf9c6af7be1af833ed6b929b2f11a003429d4873a099275c84d817"
             when "aarch64-unknown-linux-gnu" then "22d22096a0bc232e3e20abed25856aa413b46067f154049da2a24e8ef5e41a25"
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
