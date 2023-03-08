{
  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };
  
  outputs = inputs @ {self, flake-parts, ...}: flake-parts.lib.mkFlake {inherit inputs;} {
    systems = ["x86_64-linux"];
    perSystem = {pkgs, ...}: {
      packages = {
        a = pkgs.writeText "a" ''
          ${./foo}
          ${./bar}
        '';
        b = pkgs.writeText "b" ''
          ${self}/foo
          ${self}/bar
        '';
      };
    };
  };
}
