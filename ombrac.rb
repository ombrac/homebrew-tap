class Ombrac < Formula
  desc "Safe, fast, small TCP tunnel using Rust"
  homepage "https://github.com/ombrac/ombrac"
  license "Apache-2.0"
  version "0.5.1"

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
             when "x86_64-apple-darwin" then "ae0fa3a2270def0664b82abe4b5c49b280b4694870dc49866c7582418c7da93e"
             when "aarch64-apple-darwin" then "a897183a9115d3b09df36b3fc6e709fe0179aac23c99d99449ec0ed2a13f539c"
             when "x86_64-unknown-linux-gnu" then "6d686b2bebd2065f2cce01d16fbb0f206bb72abb557ccebfd22427966738eb58"
             when "aarch64-unknown-linux-gnu" then "f704d32c98d42621f57b890d7adf6638efc430ade686159f7de5bf909462e37b"
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
