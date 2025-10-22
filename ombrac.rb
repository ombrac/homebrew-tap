class Ombrac < Formula
  desc "Safe, fast, small TCP tunnel using Rust"
  homepage "https://github.com/ombrac/ombrac"
  license "Apache-2.0"
  version "0.6.3"

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
             when "x86_64-apple-darwin" then "9850383abd27834a31bdd35b736f4a296fe1b2771636cfdf8b041e17a21ec1a5"
             when "aarch64-apple-darwin" then "4673d0562f3dae93b0a4f22598436b1ac9105d7dd3397470b3dc558d6307e332"
             when "x86_64-unknown-linux-gnu" then "6b3257d5a1c7c8f7d0193ca4c51192c3e2e68ffa2bb6cd382ce21d320672085e"
             when "aarch64-unknown-linux-gnu" then "ae37a03ef270a7b80c3981dd8216b6d9a92dc686003e2f28b9048e15d9e56236"
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
