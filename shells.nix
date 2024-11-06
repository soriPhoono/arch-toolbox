{ pkgs, ... }: {
  default = pkgs.mkShell {
    packages = with pkgs; [
      nixd
      nixpkgs-fmt

      bash-language-server
    ];

    RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
  };
}