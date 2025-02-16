class Babeld < Formula
  desc "Loop-avoiding distance-vector routing protocol"
  homepage "https://www.irif.univ-paris-diderot.fr/~jch/software/babel/"
  url "http://www.pps.jussieu.fr/~jch/software/files/babeld-1.9.1.tar.gz"
  sha256 "1e1b3c01dd929177bc8d027aff1494da75e1e567e1f60df3bb45a78d5f1ca0b4"
  head "https://github.com/jech/babeld.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "fb398b6cef7a5a407466ffa42f0d8a7dfdac6c7006f0846c79efa5009d3a81ec" => :mojave
    sha256 "232cec0735999bea52ddb43b14a49c79e82782092842c11bf757feddfb9c3fef" => :high_sierra
    sha256 "6cee560393876a17eb87afaae552743809b241761119dfb4183af91430932988" => :sierra
  end

  def install
    system "make", "LDLIBS=''"
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    shell_output("#{bin}/babeld -I #{testpath}/test.pid -L #{testpath}/test.log", 1)
    expected = <<~EOS
      Couldn't tweak forwarding knob.: Operation not permitted
      kernel_setup failed.
    EOS
    assert_equal expected, (testpath/"test.log").read
  end
end
