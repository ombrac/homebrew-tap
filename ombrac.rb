class Ombrac < Formula
  desc "Safe, fast, small TCP tunnel using Rust"
  homepage "https://github.com/ombrac/ombrac"
  license "Apache-2.0"
  version "0.7.11"

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
             when "x86_64-apple-darwin" then "38bc6975a14ee242997d1e513e10631036fbf53396b54ba2b3a01ff570827a03"
             when "aarch64-apple-darwin" then "6341e54d65ec3f61657ff69da02e448cc2d719f64635a261efe9cef91e79b32c"
             when "x86_64-unknown-linux-gnu" then "5b0da10a22557e2f72eef0b0cea940eff0587fd78ce8342e6327f1f0a8400ffc"
             when "aarch64-unknown-linux-gnu" then "2474f62a290c263539ef8df21f3937872a341956ed4f7d3b391133c55616dbe5"
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
