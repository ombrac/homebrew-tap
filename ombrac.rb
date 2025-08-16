class Ombrac < Formula
  desc "Safe, fast, small TCP tunnel using Rust"
  homepage "https://github.com/ombrac/ombrac"
  license "Apache-2.0"
  version "0.5.10"

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
             when "x86_64-apple-darwin" then "0433cab662289fe8f955409fed0a35914ca989f98aaf768154150dc12e61c134"
             when "aarch64-apple-darwin" then "0703350c501cfca8d2bcfcc4c4ffef8f859e43342add5a000834e6909441a175"
             when "x86_64-unknown-linux-gnu" then "75cd8e0593b6ed3be9212f21223fe512de1cb03ff905921ee61c778d768b31f8"
             when "aarch64-unknown-linux-gnu" then "0c0cd4b4c526a4b3c69d9648345a83094db9a1471b5b6efba7aed98c168373f3"
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
