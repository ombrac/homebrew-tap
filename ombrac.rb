class Ombrac < Formula
  desc "Safe, fast, small TCP tunnel using Rust"
  homepage "https://github.com/ombrac/ombrac"
  license "Apache-2.0"
  version "0.5.4"

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
             when "x86_64-apple-darwin" then "1043ec99bc10a79dec7cac1b5e705c6ae61c31cbad745500fcd2022024c41a60"
             when "aarch64-apple-darwin" then "aea2ecb3025a740044502ed22d364b9d951663f0781852838fe8228ba1ec6b0f"
             when "x86_64-unknown-linux-gnu" then "1a8659cd51640b2b392ef411fb66e9e03603ea9a5b86d71bc57dc2aeb934e914"
             when "aarch64-unknown-linux-gnu" then "83a5552aaeeabfa59b1fcdfb8ac19d2222543a06b5a821d2d6d6014fcb588219"
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
