{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      supportedSystems = [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
    in
    {
      packages = forAllSystems (
        system:
        let
          pkgs = import nixpkgs { system = system; config = { allowUnfree = true; };  };
        in
        {
          jetbrains = pkgs.callPackage ./jetbrains { };
          fsnotifier = pkgs.callPackage ./fsnotifier { };
        }
      );

      formatter = forAllSystems (
        system:
        nixpkgs.legacyPackages.${system}.nixpkgs-fmt
      );

    };
}
