{ pkgs ? import <nixpkgs> {} }:

let
  collectionsc = (import ./nix/collectionsc.nix) {
    inherit (pkgs) stdenv fetchFromGitHub cmake pkgconfig cpputest;
  };
in
  pkgs.mkShell {
    buildInputs = [ pkgs.pkgconfig ];
    CPATH = "${pkgs.fuse3}/include/fuse3:${pkgs.libzip.dev}/include:${collectionsc}/include";
    LIBRARY_PATH = "${pkgs.fuse3}/lib:${pkgs.libzip.dev}/lib:${collectionsc}/lib";
    PKG_CONFIG_PATH = "${pkgs.fuse3}/lib/pkgconfig:${pkgs.libzip.dev}/lib/pkgconfig:${collectionsc}/lib/pkgconfig";
  }
