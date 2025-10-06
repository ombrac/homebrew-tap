class Ombrac < Formula
  desc "Safe, fast, small TCP tunnel using Rust"
  homepage "https://github.com/ombrac/ombrac"
  license "Apache-2.0"
  version "0.6.0"

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
             when "x86_64-apple-darwin" then "c0e66513702a1f130f5b7f1baa2724a49c3b85b4af3fd455bfe675885e7d5939"
             when "aarch64-apple-darwin" then "1478d3f723fd4d122b784ece34e16a0c08b59b4703d90f10040f7e76d09e8e6d"
             when "x86_64-unknown-linux-gnu" then "2b92826bcb64105f87968f43614d4fac760ac6c2b93830ff4e276279da80948f"
             when "aarch64-unknown-linux-gnu" then "2a1199e65ad37db1392001dfccf3a702eac6463b8ffcc7b738ebde7747010d3a"
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
