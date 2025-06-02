class Ombrac < Formula
  desc "Safe, fast, small TCP tunnel using Rust"
  homepage "https://github.com/ombrac/ombrac"
  license "Apache-2.0"
  version "0.5.6"

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
             when "x86_64-apple-darwin" then "8ddd4be61187aafbe06fbff0e2e8872838dbd2de9ea3e40783b04d82a708141f"
             when "aarch64-apple-darwin" then "970adf5e5e1dc2ba633c2745292195f1c71e7d81c21037dcbe035dccdf329191"
             when "x86_64-unknown-linux-gnu" then "063bf6fe3697ce0c7ebcaa1efbd457a47bce84d1dea6e432187edd6d39ff179a"
             when "aarch64-unknown-linux-gnu" then "92ed7b868f031f3d2e8a05d8b86ac751ad263e06e43498e7b290ebe662da0e33"
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
