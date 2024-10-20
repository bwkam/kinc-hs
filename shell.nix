{pkgs ? import <nixpkgs> {}}:
(pkgs.buildFHSEnv {
  name = "shell";
  targetPkgs = pkgs:
    (with pkgs; [ninja gnumake gcc glibc.dev libGL.dev mlocate libudev-zero alsa-lib.dev libxkbcommon.dev cabal-install haskell-language-server ghc])
    ++ (with pkgs.xorg; [
      libX11.dev
      libXi.dev
      libXinerama.dev
      libXrandr.dev
      libXcursor.dev
      libXrender.dev
      libXrandr
      libXft
      xinput
      xlsatoms
      xorgproto
    ]);
  runScript = "fish";
})
.env
