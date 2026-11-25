{
  description = "CLI tools presentation";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    presenterm.url = "github:mfontanini/presenterm";
  };

  outputs =
    {
      self,
      nixpkgs,
      unstable,
      flake-utils,
      presenterm,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };
        unstable-pkgs = import unstable {
          inherit system;
        };
      in
      {
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            presenterm.packages.${system}.default
            unstable-pkgs.xan
            dust
            yq-go
            mdfried
            eza
            duf
            bat
            btop
            ripgrep
            fd
            atuin
            delta
            jq
            fzf
            viu
            fastfetch
            glow
            cht-sh
            wiper
            bluetui
            zellij
            just
            python314Packages.weasyprint
          ];
          shellHook = ''
            alias prez="presenterm -xX cli-tools.md --config-file option.yml --publish-speaker-notes"
          '';
        };

      }
    );
}
