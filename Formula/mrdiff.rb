class Mrdiff < Formula
  desc "Do they differ, and where — images, PDFs, Word, fonts, archives, folders, URLs, sites, SSH, and text"
  homepage "https://mr-tabata.github.io/MrDiff/"
  url "https://github.com/MR-TABATA/MrDiff/releases/download/v0.7.1/mrdiff-0.7.1-macos.zip"
  sha256 "06904233cc9e1f8c115e70b70daec2bbc7e0939e7c6bf4f293847cffcde068e7"
  version "0.7.1"
  license "MIT"

  depends_on :macos => :ventura # Package.swift の platforms（.v13）と同じ

  def install
    # バイナリ 1 つでは動かない。SPM のリソースバンドルが実行ファイルの隣に要る
    # （scripts/release.sh の注記）。両方を libexec に置き、bin にはリンクだけ張る。
    libexec.install "mrdiff", "MrDiff_MrDiffCore.bundle"
    bin.install_symlink libexec/"mrdiff"
  end

  test do
    (testpath/"a.txt").write "one\n"
    (testpath/"b.txt").write "two\n"
    assert_match "changed", shell_output("#{bin}/mrdiff --exit-code a.txt b.txt", 1)
    assert_match "No differences", shell_output("#{bin}/mrdiff a.txt a.txt")
  end
end





