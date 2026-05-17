class Ombrac < Formula
  desc "Safe, fast, small TCP tunnel using Rust"
  homepage "https://github.com/ombrac/ombrac"
  license "Apache-2.0"
  version "0.7.9"

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
             when "x86_64-apple-darwin" then "fd2d5e947856e4ea18aa54231af86f55a9f0c12beb8889cca8535f4fb6db8e65"
             when "aarch64-apple-darwin" then "bb1020f1b258a8b4236fe4d9a84f5cbee73fb75bb9d55ca95c6556a1824c20e8"
             when "x86_64-unknown-linux-gnu" then "d7738ca47852756142e5275153a579196c2f8bac00e55a47a9b99cd91842acd6"
             when "aarch64-unknown-linux-gnu" then "60a06b4ae0ffc548a9150391a31c4a9fd57656c81c80fe414fe3d16485aac6ec"
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
