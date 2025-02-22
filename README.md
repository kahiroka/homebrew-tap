# Tamarin Prover Homebrew tap

This is a [Homebrew](https://brew.sh/) [tap](https://docs.brew.sh/Taps) for the [Tamarin prover](https://tamarin-prover.github.io).

## Installing

Install Homebrew and run

```
brew update
brew install kahiroka/tap/tamarin-prover
```

## Building bottles for Tamarin
Homebrew formulae can include compiled binaries, which it calls "bottles". To build a new bottle (perhaps for a new operating system or Tamarin release):

1. `brew install --build-bottle tamarin-prover/tap/tamarin-prover`
2. `brew bottle tamarin-prover --keep-old --root-url=https://github.com/tamarin-prover/tamarin-prover/releases/download/VERSION` where VERSION is the current release, e.g, 1.6.0, and note the output it gives you with the bottle SHA and tag,
3. Rename the bottle to use a single hyphen (e.g., `tamarin-prover--1.4.1.mojave.bottle.tar.gz` to `tamarin-prover-1.4.1.mojave.bottle.tar.gz`). Homebrew should give you the relevant output on the command line to update in the `tamarin-prover.rb` formula. If not, on Linux, run sha256sum on the renamed file, and use the result to replace the bottle hash from previous item. On macOS, use `shasum -a 256 <filename>`.
4. Add binaries to the GitHub release.
5. Update the `tamarin-prover.rb` formula with the bottle SHA and tag, in the bottle section.

New installs will then use this bottle.

## Building bottles for dependencies
To build a new bottle (perhaps for a new operating system or Maude/libbuddy release):

1. `brew install --build-bottle tamarin-prover/tap/maude` or `brew install --build-bottle tamarin-prover/tap/libbuddy`
2. `brew bottle maude --keep-old --root-url=https://raw.githubusercontent.com/tamarin-prover/binaries/HEAD/dependencies` or `brew bottle lib buddy --keep-old --root-url=https://raw.githubusercontent.com/tamarin-prover/binaries/HEAD/dependencies`, and note the output it gives you with the bottle SHA and tag,
3. Rename the bottle to use a single hyphen. Homebrew should give you the relevant output on the command line to update in the `maude.rb` or `libbuddy.rb` formula. If not, on Linux, run sha256sum on the renamed file, and use the result to replace the bottle hash from previous item. On macOS, use `shasum -a 256 <filename>`.
4. Submit a separate pull request for https://github.com/tamarin-prover/binaries/ containing the new binaries for maude or lib buddy.
5. Update the `maude.rb` or `libbuddy.rb` formula with the bottle SHA and tag, in the bottle section.
