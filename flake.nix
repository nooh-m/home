{
  description = "Home Manager Configuration";

  inputs = rec {
    # Specs And Variables
    vars.url = "github:nooh-m/variables";

    # Stable Nixpkgs
    stable.follows = "vars/stable"; # Use the same nixpkgs as vars repo

    # Home manager
    stable-home.follows = "vars/stable-home";

    rose-pine-hyprcursor = {
      url = "github:ndom91/rose-pine-hyprcursor";
      inputs.nixpkgs.follows = "stable";
    };
  };

  outputs = {
    self,
    stable,
    stable-home,
    ...
  } @ inputs: let
    inherit (self) outputs;
    # Supported systems for your flake packages, shell, etc.
    systems = [
      "aarch64-linux"
      "i686-linux"
      "x86_64-linux"
      "aarch64-darwin"
      "x86_64-darwin"
    ];
    # This is a function that generates an attribute by calling a function you
    # pass to it, with each system as an argument
    forAllSystems = stable.lib.genAttrs systems;
  in {
    # Formatter for your nix files, available through 'nix fmt'
    # Other options beside 'alejandra' include 'nixpkgs-fmt'
    # formatter = forAllSystems (system: stable.legacyPackages.${system}.alejandra);

    # Reusable home-manager modules you might want to export
    # These are usually stuff you would upstream into home-manager
    # homeManagerModules = import ./modules/home-manager;

    # Standalone home-manager configuration entrypoint
    # Available through 'home-manager --flake .#your-username@your-hostname'
    homeConfigurations = {
      haam = stable-home.lib.homeManagerConfiguration {
        pkgs = stable.legacyPackages.x86_64-linux;
        extraSpecialArgs = {inherit inputs outputs;};
        modules = [
          ./home/haam.nix
        ];
      };
    };
  };
}
