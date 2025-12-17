class Ombrac < Formula
  desc "Safe, fast, small TCP tunnel using Rust"
  homepage "https://github.com/ombrac/ombrac"
  license "Apache-2.0"
  version "0.6.6"

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
             when "x86_64-apple-darwin" then "95d2ac54ed3654794cfaa4d527889778227138e618ae89923cd6cd9721aa96cc"
             when "aarch64-apple-darwin" then "08753c9907a046dc5922170b5643f64f3c11f390330306347b8a5e24bd8def55"
             when "x86_64-unknown-linux-gnu" then "8e4d39f401b8be58d86aa7ac8626cdf97576db34e23ae29a2557ba3031e8c163"
             when "aarch64-unknown-linux-gnu" then "c449a96cd6d6ac2b663efc887cb20f0a762619716b37d07a478a56186e66f6cc"
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
