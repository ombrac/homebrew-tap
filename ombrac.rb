class Ombrac < Formula
  desc "Safe, fast, small TCP tunnel using Rust"
  homepage "https://github.com/ombrac/ombrac"
  license "Apache-2.0"
  version "0.5.2"

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
             when "x86_64-apple-darwin" then "883a00495cbeb5ecee59eb952b3bb7f7ada95fc6d2cf8e1b8a66919b81b8bbf3"
             when "aarch64-apple-darwin" then "e44e317f3b9af5628552db172f8becbf0090b9b52cb71c96fb3d29e8843d302e"
             when "x86_64-unknown-linux-gnu" then "bd21f89787548121dc2dcb2bd7a2711d8f37b0daf599eb53a5e8498e3ef9fa77"
             when "aarch64-unknown-linux-gnu" then "1091d89e86879a17da5daa690a891cb44624aebd63631f17ddec337bb86964ac"
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
