{ pkgs ? import <nixpkgs> { }
, poetry2nix ? pkgs.callPackage ./poetry2nix { inherit pkgs; }
, ... }:

let
  name = "hello_poetry2nix";
  rev = "dc017559ca0d728b11a157e96278d224a7a5f26c";
  hash = "sha256-mkOUUkuaA3z5zHECXlmcIk7sjGGmdbZyju180KviHw8=";

  src = pkgs.fetchFromGitHub {
    inherit rev hash;

    owner = "wilsonehusin";
    repo = "hello-poetry2nix";
  };
in poetry2nix.mkPoetryApplication {
  inherit name src;

  patches = [ ./patches/hello-folks.patch ];

  pname = name;
  version = rev;
  projectDir = src;

  overrides = poetry2nix.defaultPoetryOverrides.extend
    (self: super: {
      comtypes = super.comtypes.overridePythonAttrs
      (
        old: {
          buildInputs = (old.buildInputs or [ ]) ++ [ super.setuptools ];
        }
      );
    });
}
