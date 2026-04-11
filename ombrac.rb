class Ombrac < Formula
  desc "Safe, fast, small TCP tunnel using Rust"
  homepage "https://github.com/ombrac/ombrac"
  license "Apache-2.0"
  version "0.7.5"

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
             when "x86_64-apple-darwin" then "3afdbd594d62446d016f898a313574d9baff1818d00f339723a214bef3654c69"
             when "aarch64-apple-darwin" then "b4ab549ee63ffa5d4f0d594991cbe6a3cb1793d40d1e8ea801c0a2c25496b60d"
             when "x86_64-unknown-linux-gnu" then "65188b1c7ce6f9d125419da2a3990d41c95495fbeb1cda07c43ea8b5f2d85ef7"
             when "aarch64-unknown-linux-gnu" then "d1a24baaec928631104585a1d12be7c450c3707dd4ec671afb9de8e727caa129"
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
