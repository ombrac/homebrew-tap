class Ombrac < Formula
  desc "Safe, fast, small TCP tunnel using Rust"
  homepage "https://github.com/ombrac/ombrac"
  license "Apache-2.0"
  version "0.4.2"

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
             when "x86_64-apple-darwin" then "9984042ab7d1833405c7671698c67f7bad61e11021a92ed74dfa54766fb92d7e"
             when "aarch64-apple-darwin" then "bd849c75e45c63ff9cf4c4d5b5d9e7f203004443ca5a6eceddb77500a0cf0660"
             when "x86_64-unknown-linux-gnu" then "d36b1f502afc71d4ccbd840f6c1a9484bcd8261c123dc6153748122710f53d83"
             when "aarch64-unknown-linux-gnu" then "6bd305bb4a7176532ea9cc18e433ee608080c28c1fb7a159abaa4d1dbf5e4106"
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
