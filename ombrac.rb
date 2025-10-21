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
             when "x86_64-apple-darwin" then "5eb4f986d41e68d3c935fa668952b900d7b50e661a52b09f4c9617f8e6fd7b05"
             when "aarch64-apple-darwin" then "fad927451d73724adc6a04721c6985719996c9afcbc8e5988d3fb8dd0810a827"
             when "x86_64-unknown-linux-gnu" then "ebb7ea31f3faa45b93691268354d90305b129c90b41b78c5481e36964a576181"
             when "aarch64-unknown-linux-gnu" then "f90a01b1ea4f713f72440bae165cdba91874b38baab5cd54bb9b892ea17d15e5"
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
