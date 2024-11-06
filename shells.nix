{ pkgs, ... }: {
  default = pkgs.mkShell {
    packages = with pkgs; [
      nixd
      nixpkgs-fmt

      gcc
      rustc
      cargo
      rustfmt
      clippy
      rust-analyzer
    ];

    RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
  };
}