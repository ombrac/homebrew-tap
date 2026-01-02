class Ombrac < Formula
  desc "Safe, fast, small TCP tunnel using Rust"
  homepage "https://github.com/ombrac/ombrac"
  license "Apache-2.0"
  version "0.7.0"

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
             when "x86_64-apple-darwin" then "b259e4eaf1997419b1181c1aee9f457963510093aa43119c2107ffd36640d127"
             when "aarch64-apple-darwin" then "81eeddfce90c4344a9900689e5216cee007e022b266390f20aeb9fb579a7bf8a"
             when "x86_64-unknown-linux-gnu" then "8c6e980e74be548ec54b7e4fa8dcfd0f82e7a5ed4e435ce7c20c3922b4db31d1"
             when "aarch64-unknown-linux-gnu" then "630f056876ac0a43d8ce4b0c5d7f6648740bb71ea840be530d1994a9914c1f24"
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
