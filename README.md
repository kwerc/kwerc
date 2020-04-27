# kwerc

Welcome to kyle's werc, a reimagination of Uriel's
[werc](http://werc.cat-v.org/) web framework written in
[es shell](https://wryun.github.io/es-shell/).

## Features

* Productive. Build powerful, scalable web apps as easily as writing
  shell scripts. Literally -- es is shell! Pipe together Unix tools like
  sed and grep or virtually any command line programs to build complex
  functions with very little code. And with far more intelligent design
  than Bourne/bash and other shells, es is fun and reliable.
* Easy to learn. Don't know es? No problem (almost no one does). Es is
  extremely simple. If you know Bourne shell or bash or rc, you already
  know most of es. Check out the
  [es paper](https://wryun.github.io/es-shell/paper.html) for a complete
  description of the language in just 10 pages.
* Hackable. kwerc is around 500 lines of es. Easily integrate with your
  favourite database (want to take advantage of es's powerful I/O
  redirection? try storing data in a plain text file tree or mount a
  database as a FUSE filesystem), code in any language, etc. Even es
  itself can be modified and extended on the fly.
* Powerful. Besides standard shell features, es is extensible and
  functional with support for first class functions, lexical scope,
  exceptions, and rich return values. Need more? kwerc ships with the
  blazing fast [mawk](https://invisible-island.net/mawk/) interpreter
  you can use inline from es. Or, again, easily integrate your favourite
  language (note some languages come with a significant performance hit
  when invoked from shell).
* Fast. Fits in a ~75MB ramdisk including a complete set of statically
  compiled Unix command line tools
  ([9base](https://tools.suckless.org/9base/)). Works in a cluster. Ships
  with (currently primitive) Redis database integration.
* Secure. kwerc has strong protections against shell injections. Es's
  quoting rules and overall sane syntax avoid security bugs that are
  common in other shells. And of course, there is no better security
  feature than simplicity. kwerc is simple by design and implementation,
  and software built with kwerc does more with less code and less bugs.
  Additionally, kwerc is fully self-contained and can be run in a
  read-only chroot or jail.
* Portable. Should run on any sane Unix (someday it may run on Plan 9 or
  Inferno as well). No external dependencies. 100% statically compiled.

## Dependencies

Everything is included in vendor/. You just need C and Golang (>=1.11)
compilers to build. I use `musl-gcc -static`. It is highly recommended
to build statically for maximum performance (including any external
programs you run from kwerc).

A simple `make` will compile the vendor dependencies and put them in the
right place. You don't need to run `make install` (in fact, you can't)
-- everything is self-contained in the kwerc directory.

On Debian:
```
# apt install musl-tools golang-go
$ make
```

Here is a brief overview of these dependencies:
* es: The es interpreter. This one's pretty important. Though if you
  really want you could port kwerc to rc or another shell pretty easily.
* 9base: Various Plan 9 tools ported to Unix. These aren't POSIX but
  they're fairly close so with a few modifications to kwerc you could
  use your system binaries or sbase or busybox or so instead. You will
  want these to be statically compiled for maximum performance.
* mawk: A fast awk interpreter. You should be able to replace this with
  any awk interpreter -- just change $awk in your kwerc config.
* jq: A JSON parser, used for ORY auth. Optional.
* bat: An HTTP client (like curl), used for ORY auth. Optional.
* redli: A Redis client, used by es/resdis.es. Optional.
* cgd: A CGI web server. You can use something else instead if
  you prefer -- documentation forthcoming.

## Usage

`./bin/cgd -c es/kwerc.es`

Now visit http://localhost:3333 and you should be greeted with a
beautiful empty page. You can check the page source and make sure there
is some html there.

Next up: building an actual web app. Documentation coming soon. For now,
[werc's documentation](http://werc.cat-v.org/) is somewhat applicable.

## FQA

Q. CGI? Isn't that slow?

A. https://www.mail-archive.com/werc9@googlegroups.com/msg00202.html

Q. Static binaries? Aren't those huge/insecure/slow?

A. https://sta.li/faq/

## Status

kwerc is very much a work in progress. It is not production ready. There
are probably bugs. There may be security or performance issues. There
will be changes that break things. There may be dramatic design changes.
And as you've probably noticed, there is insufficient documentation.

There should be a stable 1.0 release sometime in 2020. This release will
power a large production app that will undergo stability, security, and
performance testing.

Features coming soon:
* Authentication
* File uploads
* Redis integration
* Caching
* PWA support
* Documentation
* ???

## Contact

m@kfarwell.org

## IWP9

I will be at [IWP9](http://iwp9.org/). Find me if you have kwerc-related
ideas or feedback or want to hack on kwerc.

## Donate

[Just Send The Money](https://github.com/sponsors/kfarwell)

## License

kwerc is distributed under the ISC license. See LICENSE for details.

Dependencies under vendor/ have their own licenses. Read them.

## Thanks & History

kwerc is dedicated to the memory of Uriel.

kwerc is based on [werc](http://werc.cat-v.org/), created by Uriel with
contributions from Garbeam, Kris Maglione, sqweek, soul9, mycroftiv,
maht, yiyus, cinap_lenrek, khm and many others.

kwerc incorporates many of the changes from Garbeam's werc fork,
[swerc](https://git.suckless.org/swerc).

Thanks as well to everyone involved with the various dependency projects
under vendor/.

Ideas for kwerc come from a variety of projects where I've employed
werc, including VRLFP, Tokumei, Gelato Labs, and werchan. Thanks to
everyone involved and especially to Keefer Rourke.
