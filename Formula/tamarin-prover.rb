class TamarinProver < Formula
  desc "Automated security protocol verification tool"
  homepage "https://tamarin-prover.github.io/"
  url "https://github.com/tamarin-prover/tamarin-prover/archive/1.6.1.tar.gz"
  sha256 "2405a94d40c59030409889af1e8490617aefdd8b3cdc1bfb55a0f75b7e590d77"
  head "https://github.com/tamarin-prover/tamarin-prover.git", branch: "master"

  bottle do
    root_url "https://github.com/tamarin-prover/tamarin-prover/releases/download/1.6.1"
    sha256 cellar: :any_skip_relocation, big_sur:      "a886014d7c2345bc2f2ea1836dd9bf1199435fcec54963f8e07e80e13fe857c6"
    sha256 cellar: :any_skip_relocation, catalina:     "b8a142ad4961d0beb06c9c4912baacca6deb7870016a22183e40dc259e60d500"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "c8fb1f445c9973a62376dd16ff711e019a00e0df3fb71d2b9afefa26fecc8ffe"
  end

  depends_on "haskell-stack" => :build
  depends_on "zlib" => :build unless OS.mac?
  depends_on "ocaml" => :build
  depends_on "graphviz"
  depends_on macos: :yosemite
  depends_on "kahiroka/tap/maude"
  depends_on "ghc" => :build

  # doi "10.1109/CSF.2012.25"
  # tag "security"

  def install
    # Let `stack` handle its own parallelization
    jobs = ENV.make_jobs
    #system "stack", "-j#{jobs}", "setup", "ghc-8.10.7"
    args = ["--system-ghc", "--skip-ghc-check"]
    unless OS.mac?
      args << "--extra-include-dirs=#{Formula["zlib"].include}" << "--extra-lib-dirs=#{Formula["zlib"].lib}"
    end
    ENV["PATH"] = "/opt/homebrew/bin:" + ENV["PATH"]
    system "stack", "-j#{jobs}", *args, "install", "--flag", "tamarin-prover:threaded"

    # `ocaml` building under linuxbrew needs to be single core.
    ENV.deparallelize
    system "make", "sapic"

    bin.install Dir[".brew_home/.local/bin/*"]
  end

  test do
    system "#{bin}/tamarin-prover", "test"
  end
end
