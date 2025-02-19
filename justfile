update:
    nix flake update

clean:
    rm -rf ./nixos.qcow2
    rm -rf ./nixos-efi-vars.fd
    - unlink ./result

build-vm:
    just --justfile {{ justfile() }} clean
    echo 'Building The Virulized Machine'
    nixos-rebuild build-vm-with-bootloader --flake ".#vm"

run-vm:
    just --justfile {{ justfile() }} clean
    just --justfile {{ justfile() }} build-vm
    ./result/bin/run-nixos-vm

switch:
    nh os switch . -H laptop

build:
    nh os build . -H laptop

test:
    nh os build . -H laptop

home-switch:
    home-manager switch --flake .#haam -b backup3
