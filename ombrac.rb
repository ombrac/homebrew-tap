class Ombrac < Formula
  desc "Safe, fast, small TCP tunnel using Rust"
  homepage "https://github.com/ombrac/ombrac"
  license "Apache-2.0"
  version "0.5.14"

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
             when "x86_64-apple-darwin" then "738e902f9edd2f362fa65aa73af9df6374bbc72f277bf3996c8da3a19367c963"
             when "aarch64-apple-darwin" then "6a9beb3cd3a29bbf98499718bab88285eedc3467e7633f7742c1af7664c5068c"
             when "x86_64-unknown-linux-gnu" then "fd5a22050cb89087d245537285c0cdfd526af870d1127e6aa74345e2a39c3918"
             when "aarch64-unknown-linux-gnu" then "1ac5ce62ef9ef7079b03bfcc9c223afb914db1d6eac21b88c3ac36ec256ec226"
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
