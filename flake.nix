{
  description = "Helm Charts validation environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages.${system};
      in {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            # Task runner
            go-task

            # Helm ecosystem
            kubernetes-helm
            chart-testing
            helm-docs

            # YAML/JSON processing
            python3Packages.yq # kislyuk/yq (jq wrapper for YAML)
            jq

            # Validation tools
            cocogitto
            actionlint
            pluto

            # Security scanning
            grype
            syft
            trivy
          ];
        };

        # Default formatter for 'nix fmt'
        formatter = pkgs.nixpkgs-fmt;
      });
}
