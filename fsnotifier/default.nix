{ lib
, stdenv
, fetchFromGitHub
, fetchpatch
}:

stdenv.mkDerivation rec {
  version = "1.0.0";
  pname = "fsnotifier";

  buildPhase = ''
    mkdir -p $out/bin

    $CC -O2 -Wall -Wextra -Wpedantic -D "VERSION=\"${version}\"" -std=c11 main.c inotify.c util.c -o fsnotifier

    cp fsnotifier $out/bin/fsnotifier
  '';

  src = ./src;
}
