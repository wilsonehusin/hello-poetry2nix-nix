{ pkgs ? import <nixpkgs> { }
, poetry2nix ? pkgs.callPackage ./poetry2nix { inherit pkgs; }
, ... }:

let
  name = "hello_poetry2nix";
  rev = "4431812218e1963fd34f4d9d22dcd688a4c33fb4";
  hash = "sha256-iHqzA/HJ+vb7O5vpGpA1eR3BcoGDPE2QOqQQpOp0zFQ=";

  src = pkgs.fetchFromGitHub {
    inherit rev hash;

    owner = "wilsonehusin";
    repo = "hello-poetry2nix";
  };
in poetry2nix.mkPoetryApplication {
  inherit name src;

  pname = name;
  version = rev;
  projectDir = src;
}
