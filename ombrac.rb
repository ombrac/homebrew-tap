class Ombrac < Formula
  desc "Safe, fast, small TCP tunnel using Rust"
  homepage "https://github.com/ombrac/ombrac"
  license "Apache-2.0"
  version "0.6.2"

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
             when "x86_64-apple-darwin" then "db2e5fffb8631d5759ffd29961f71f23707387084c54509529a15c0a478a231f"
             when "aarch64-apple-darwin" then "62e98c2da1d410ad81801376cad8a4ae50f0b97d9c007adf9a93207ed4ae2264"
             when "x86_64-unknown-linux-gnu" then "cad75d755f2a35398f0a7054ebb558b532e0294103b50644a8eb233a84b76d17"
             when "aarch64-unknown-linux-gnu" then "4a2933733f891723d88f6c6c9f65863a84891b1694125519053c92c3460a4ae4"
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
