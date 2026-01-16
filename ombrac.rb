class Ombrac < Formula
  desc "Safe, fast, small TCP tunnel using Rust"
  homepage "https://github.com/ombrac/ombrac"
  license "Apache-2.0"
  version "0.7.1"

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
             when "x86_64-apple-darwin" then "3b1bdf5113d7f3da84d93d3b38b15e673de4511571625279b381c9ccda424544"
             when "aarch64-apple-darwin" then "4cb8be84f278c764a2a7b454c06abe5308f8091ad4d560bbab9292084f2751f2"
             when "x86_64-unknown-linux-gnu" then "4b486617a54610a12dda00590c85930e8d9564396bd0d35db6f750f563002019"
             when "aarch64-unknown-linux-gnu" then "9cc57c9481d3a45b5fe8d8d3133f5b94e44e9bfe28e1d850f9bebf889148941b"
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
