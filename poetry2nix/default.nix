{ pkgs ? import <nixpkgs> { }
, ... }:

let
  src = pkgs.fetchFromGitHub {
    owner = "nix-community";
    repo = "poetry2nix";
    rev = "2023.12.111047";
    sha256 = "sha256-QSGP2J73HQ4gF5yh+MnClv2KUKzcpTmikdmV8ULfq2E=";
  };
in import src { inherit pkgs; }
