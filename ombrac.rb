class Ombrac < Formula
  desc "Safe, fast, small TCP tunnel using Rust"
  homepage "https://github.com/ombrac/ombrac"
  license "Apache-2.0"
  version "0.6.1"

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
             when "x86_64-apple-darwin" then "3aebebfae3a442d0ae035f80225589f419be29f459919fed5eeac9b3ff1554ee"
             when "aarch64-apple-darwin" then "324d139820749682dd3abf88289ff321af77004329ef79bdb2da6f33abc72c6b"
             when "x86_64-unknown-linux-gnu" then "0e88543e573ff2dd58bb970ea71492cca354f7694bfc766aced2f6ccbac47682"
             when "aarch64-unknown-linux-gnu" then "91a7c03eb65b248ee550b4bf07a9eb341d1b0ef7771711b47873c01c13a1626d"
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
