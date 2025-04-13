class Ombrac < Formula
  desc "Safe, fast, small TCP tunnel using Rust"
  homepage "https://github.com/ombrac/ombrac"
  license "Apache-2.0"
  version "0.5.3"

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
             when "x86_64-apple-darwin" then "91d15a3db89c306c720ce602f698ad811e960541d7b8918f90ef47d0e9ff2bec"
             when "aarch64-apple-darwin" then "45b97bbc2cd7715d3b9295a6c84164d07ed8e0ffb46bfa32188f378c0f40c48b"
             when "x86_64-unknown-linux-gnu" then "19a1e966520641127ac0ceb44029cd49395e60b5abfbec2f5b49b78cfb7a03d1"
             when "aarch64-unknown-linux-gnu" then "b2e571552ff5c42f5ee6d40bb4c96180ac8290b6cddb8f1aff8ed4c646b229bb"
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
