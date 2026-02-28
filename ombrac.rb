class Ombrac < Formula
  desc "Safe, fast, small TCP tunnel using Rust"
  homepage "https://github.com/ombrac/ombrac"
  license "Apache-2.0"
  version "0.7.3"

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
             when "x86_64-apple-darwin" then "38ab61694a1e736d9be982e91ea75231b7b48cfa392faf8fe9e0d699d7722a90"
             when "aarch64-apple-darwin" then "bff6146fbc3188ead94c40eb23ae866989b5728a07e5e8f3c7c1f6ccd0167c32"
             when "x86_64-unknown-linux-gnu" then "aaf4121d9450c5decaca0501e416342805cabb7efef72c9ea8ac01a00d437f9e"
             when "aarch64-unknown-linux-gnu" then "5e126d9c853408fdd438fc4c7920ac086e8ef554c84fda60af0a82b57408fd79"
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
