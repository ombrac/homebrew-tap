# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class Ombrac < Formula
  desc "Safe, fast, small TCP tunnel using Rust"
  homepage ""
  url "https://github.com/ombrac/ombrac/releases/download/v0.3.2/ombrac-aarch64-apple-darwin.tar.gz"
  sha256 "6eed20358e14fb91daaaf1f464c1fef66ee41c6f32d55c6ce27ce93665506d9b"
  license "Apache-2.0"

  # depends_on "cmake" => :build

  # Additional dependency
  # resource "" do
  #   url ""
  #   sha256 ""
  # end

  def install
    bin.install "ombrac-client"
    bin.install "ombrac-server"
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test ombrac`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system bin/"program", "do", "something"`.
    system "false"
  end
end
