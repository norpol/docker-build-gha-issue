{
  description = "Nhost Hasura Storage";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };

        name = "docker-build-gha-issue";
        version = "0.0.0-dev";
      in
      {

        packages = flake-utils.lib.flattenTree rec {
          docker-image = pkgs.dockerTools.buildImage {
            inherit name;

            tag = version;
            created = "now";

            fromImage = pkgs.dockerTools.pullImage {
              imageName = "ubuntu";
              imageDigest =
                "sha256:7708743264cbb7f6cf7fc13e915faece45a6cdda455748bc55e58e8de3d27b63";
              finalImageName = "ubuntu";
              finalImageTag = "mantic-20231011";
              sha256 = "sha256-ZwRao5S9LJAb/lCojS2jNhHbMwk05GUOrYMJ5w0Miow=";
              os = "linux";
              arch = "aarch64";
            };
          };

          default = docker-image;

        };

      }



    );


}
