class Ombrac < Formula
  desc "Safe, fast, small TCP tunnel using Rust"
  homepage "https://github.com/ombrac/ombrac"
  license "Apache-2.0"
  version "0.5.8"

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
             when "x86_64-apple-darwin" then "bd64cd2688b1eef89c8cdb547669583b2f57a1573d4633d16c23a6b467fec939"
             when "aarch64-apple-darwin" then "a93091588a126a922f72f72b9f9d01089fe98394ccec84a03c3203aded575253"
             when "x86_64-unknown-linux-gnu" then "7bcd33e8852c90578fd7178c44fd32339686b34128cbeddbe1a1398f8622630a"
             when "aarch64-unknown-linux-gnu" then "90532a31a9638477b16e573773f6de5650bb7859a94a24f2657323c78e32534b"
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
