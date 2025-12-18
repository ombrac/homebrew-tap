class Ombrac < Formula
  desc "Safe, fast, small TCP tunnel using Rust"
  homepage "https://github.com/ombrac/ombrac"
  license "Apache-2.0"
  version "0.6.7"

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
             when "x86_64-apple-darwin" then "10a01237c909ed427380d8fb67da452efa6d93efde9cfa6892af8e5d33bc32e5"
             when "aarch64-apple-darwin" then "673026ee1b34866b70d708d4f6af2028c2aad81f9b3ff0919bdd3a1bd6fe2198"
             when "x86_64-unknown-linux-gnu" then "ad6660b03857bdd688f1eef215d1a1844255105f52a1a5d62ef48049de353102"
             when "aarch64-unknown-linux-gnu" then "d182bc7d1a231ec95c56e54b7aacd0fd3b46af9e3bbf8610f64cdb2f0796dd75"
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
