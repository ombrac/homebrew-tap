class Ombrac < Formula
  desc "Safe, fast, small TCP tunnel using Rust"
  homepage "https://github.com/ombrac/ombrac"
  license "Apache-2.0"
  version "0.7.2"

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
             when "x86_64-apple-darwin" then "a89f811e1e4d0d540bbdaef6e3d47e64cde51798a52ca94152d85cada01ea0ea"
             when "aarch64-apple-darwin" then "dbb7dc2ca17739e0c2624427ce1d5b2d6b75042119ebae5ae0aa6ca776556d13"
             when "x86_64-unknown-linux-gnu" then "fc21f4112ef40ecb9ddd843c46b78d6c59f7806a061440e541444e5da65a368c"
             when "aarch64-unknown-linux-gnu" then "db8187f051b557ceffc9f1a9a23e9f0e2a8ae828141cee87fd181bc370f71aa6"
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
