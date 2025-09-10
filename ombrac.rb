class Ombrac < Formula
  desc "Safe, fast, small TCP tunnel using Rust"
  homepage "https://github.com/ombrac/ombrac"
  license "Apache-2.0"
  version "0.5.15"

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
             when "x86_64-apple-darwin" then "c9f608a039ff8b6b763c72ebcbaa1a6dce0423629a5e141b778e71ba3117bcf7"
             when "aarch64-apple-darwin" then "44cc738d6b2d032e05d758f1f49e2877007cefa017fbd227ce252d1450c1e405"
             when "x86_64-unknown-linux-gnu" then "e762c9a258fd865cba75fc2eefa1d364938b005c588a1461dc0888422556a9f6"
             when "aarch64-unknown-linux-gnu" then "d8f0ad8ac8a83c7ac8e369ab9e10e9db39854b8398c9ea771c49067f24079499"
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
