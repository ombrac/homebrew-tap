class Ombrac < Formula
  desc "Safe, fast, small TCP tunnel using Rust"
  homepage "https://github.com/ombrac/ombrac"
  license "Apache-2.0"
  version "0.5.9"

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
             when "x86_64-apple-darwin" then "51e010feaad8e373762a65e84fa22f6f34df4503badf97cb41fc9009d7d69301"
             when "aarch64-apple-darwin" then "9474376560096cf2e6dcbc3967e2f5d17fc9ff87837b62a8159c3b3b379cf9d5"
             when "x86_64-unknown-linux-gnu" then "ca4793b49630dd631270dc79f83f000bf5a754b306cbb7cbcd093a01182b8dc6"
             when "aarch64-unknown-linux-gnu" then "ba2c3d5becd856183f28a8aa0f1158d9525171ca8458c6bb3beebc4988988c47"
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
