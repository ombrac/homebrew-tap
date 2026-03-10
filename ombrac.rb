class Ombrac < Formula
  desc "Safe, fast, small TCP tunnel using Rust"
  homepage "https://github.com/ombrac/ombrac"
  license "Apache-2.0"
  version "0.7.4"

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
             when "x86_64-apple-darwin" then "764bc958968c016577ba278974845cdf8b56b1f19734eb00a8b6f5d593fe916c"
             when "aarch64-apple-darwin" then "2c376f882cdbddb1faa611c4075ae6bb5307c0342792ac3b16a9d0b6be66b19a"
             when "x86_64-unknown-linux-gnu" then "78dd6e096090ff3a709dbac40bbfaf916fcf3e8fe81d16f098129591d1674a4b"
             when "aarch64-unknown-linux-gnu" then "b7b395e971540dcab1247c91714591d4586f8a3aca18fb15f28c4b1bb576a237"
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
