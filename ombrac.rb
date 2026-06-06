class Ombrac < Formula
  desc "Safe, fast, small TCP tunnel using Rust"
  homepage "https://github.com/ombrac/ombrac"
  license "Apache-2.0"
  version "0.7.10"

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
             when "x86_64-apple-darwin" then "05dd602a572a932da8e5a2e0294b44f72290133a9116e81a9ff46e0310bc0009"
             when "aarch64-apple-darwin" then "a3e1816a5b851cfee2a251abe2c2f91518c51de3d68438a3f1158f02a9622802"
             when "x86_64-unknown-linux-gnu" then "487c705a8053577b45d812c4ded8d21dfba4d6301c77a838a95ae036f2afcfed"
             when "aarch64-unknown-linux-gnu" then "2b5fc3541d9fef79b574aff86af806cfe6b982d703d53a896a96238bdaed24b7"
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
