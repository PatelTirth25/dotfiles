{ config, pkgs, lib, ... }:

let
  configDirs = [
    "sway"
    "nvim"
    "kitty"
    "waybar"
    "rofi"
    "gammastep"
    "nwg-look"
    "swaylock"
  ];

  binFiles = [
    "screenshot"
    "battery"
    "bluetoothdevice"
    "clearcache"
    "connectwifi"
    "cpu_usage"
    "dateformat"
    "ram_usage"
    "startup"
    "timeformat"
    "tmux_start"
    "volume"
    "wallpaper"
    "wifiName"
  ];
in
{
  home.username = "tirth";
  home.homeDirectory = "/home/tirth";

  home.stateVersion = "26.05";

  programs.git.enable = true;
  programs.bash.enable = true;

  home.packages = with pkgs; [
    neovim
    ripgrep
    nil
    nixpkgs-fmt
    gcc
    nodejs
  ];

  xdg.configFile =
    builtins.listToAttrs (
      map (name: {
        name = name;
        value = {
          source = ./config/${name};
          recursive = true;
        };
      }) configDirs
    );

  home.file =
    builtins.listToAttrs (
      map (name: {
        name = ".local/bin/${name}";
        value = {
          source = ./bin/${name};
          executable = true;
        };
      }) binFiles
    );
}
