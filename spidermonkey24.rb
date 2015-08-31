require 'formula'

class Spidermonkey24 < Formula
  desc "Mozilla's JavaScript engine release 24"
  homepage 'https://developer.mozilla.org/en/docs/SpiderMonkey'
  url 'http://ftp.mozilla.org/pub/mozilla.org/js/mozjs-24.2.0.tar.bz2'
  sha1 'ce779081cc11bd0c871c6f303fc4a0091cf4fe66'

  option 'with-check', "Run the test suite during install ~10min"

  def install
    chdir "./js/src/"
    system "./configure", "--disable-debug", "--prefix=#{prefix}"
    system "make", "JS_THREADSAFE=1"
    system "make", "check" if build.with? 'check'
    system "make", "install"
  end

  test do
    `#{bin}/js24 -e 'print(Math.PI)'`.chomp == '3.141592653589793'
  end
end
