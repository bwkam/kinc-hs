{
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  description = "shell";
  outputs = {
    nixpkgs,
    self,
    ...
  }: let
    supportedSystems = ["x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin"];
    forEachSupportedSystem = f:
      nixpkgs.lib.genAttrs supportedSystems (system:
        f rec {
          pkgs = import nixpkgs {inherit system;};
          # devDeps = map (x: x.dev or x) (with pkgs; [glibc libGL alsa-lib libxkbcommon libudev-zero]);
          devDeps = with pkgs;
            [
              # glibc
              libGL
              alsa-lib
              libxkbcommon
              libudev-zero
            ]
            ++ (with xorg; [
              libX11
              libXi
              libXinerama
              libXrandr
              libXcursor
              libXrender

              libXft
              xinput
              xlsatoms
              xorgproto
            ]);
          deps = with pkgs;
            [cabal-install ghc haskell-language-server nil ninja gnumake gcc mlocate cabal-install haskell-language-server ghc] ++ devDeps;
        });
  in {
    devShells = forEachSupportedSystem ({
      pkgs,
      deps,
      devDeps,
    }: {
      default = pkgs.mkShell {
        buildInputs = deps;
        shellHook = ''
          export LD_LIBRARY_PATH=${builtins.concatStringsSep ":" (map (x: "${x}/lib") devDeps)}:./:$LD_LIBRARY_PATH
        '';
      };
    });
  };
}
