{
  description = "Nix Planet Website";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    flake-utils.url = "github:numtide/flake-utils";
  };

  inputs.flake-compat.url = "https://flakehub.com/f/edolstra/flake-compat/1.tar.gz";

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
      in {
        packages = with pkgs; rec {
          planetNixSite = stdenv.mkDerivation {
            name = "socal-nix-site";
            src = ./.;
            buildInputs = with pkgs; [
              zola
            ];
            buildCommand = ''
              cd $src
              mkdir -p $out
              zola build --output-dir $out/public
            '';
          };

          default = planetNixSite;
        };
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            zola
            alejandra
          ];
        };
      }
    );
}
