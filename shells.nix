{ pkgs, ... }: {
  default = pkgs.mkShell {
    packages = with pkgs; [
      nixd
      nixpkgs-fmt

      bash-language-server
      shfmt
    ];
  };
}