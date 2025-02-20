class Ombrac < Formula
  desc "Safe, fast, small TCP tunnel using Rust"
  homepage "https://github.com/ombrac/ombrac"
  license "Apache-2.0"
  version "0.3.2"

  os = OS.mac? ? "darwin" : "linux"
  arch = case Hardware::CPU.arch
         when :x86_64 then "x86_64"
         when :arm64 then "aarch64"
         else
           raise "Ombrac: Unsupported system architecture #{Hardware::CPU.arch}"
         end

  @@filename = "ombrac-#{version}-#{os}-#{arch}.tar.gz"
  @@url = "https://github.com/ombrac/ombrac/releases/download/v#{version}/#{@@filename}"

  @@sha256 = case "#{os}-#{arch}"
             when "darwin-x86_64" then "dfae33027b4254e4de6adda1535248600471b5b99a09349e4cfb697307888125"
             when "darwin-aarch64" then "6eed20358e14fb91daaaf1f464c1fef66ee41c6f32d55c6ce27ce93665506d9b"
             when "linux-x86_64" then "91762776178885c5cf586898224d52ee8854524c43dfacb50603bbd0f955f098"
             when "linux-aarch64" then "4a6888ec0fb455a96fcf23ed7f882d7b089936541964ffa4d8b866e97ece4639"
             else
               raise "Ombrac: Unsupported system #{os}-#{arch}"
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
