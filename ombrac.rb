class Ombrac < Formula
  desc "Safe, fast, small TCP tunnel using Rust"
  homepage "https://github.com/ombrac/ombrac"
  license "Apache-2.0"
  version "0.7.8"

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
             when "x86_64-apple-darwin" then "54a19bf76dd78eb0f333d3fab5f57503fb3bd778263d3dd85affa95ccd6ccf3c"
             when "aarch64-apple-darwin" then "9656387e2f3cdcf4b77cceab964c6c964efb0522eda799b9fb13924bc315e1c3"
             when "x86_64-unknown-linux-gnu" then "c6d25557be27249330e36cb54eef3711a83cfe0519037d98a7a10b41795ad0ae"
             when "aarch64-unknown-linux-gnu" then "13f7f0540caf4ccc73f72a31fe3d4b5a1b7e5539c873fc817f961036f33fdba2"
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
