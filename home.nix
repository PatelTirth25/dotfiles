{ config, pkgs, ... }:

{
	home.username = "tirth";
	home.homeDirectory = "/home/tirth";
	programs.git.enable = true;
	home.stateVersion = "26.05";
	programs.bash = {
		enable = true;
	};

    xdg.configFile."sway".source = ./config/sway;
    xdg.configFile."nvim".source = ./config/nvim;
    xdg.configFile."kitty".source = ./config/kitty;
    xdg.configFile."waybar".source = ./config/waybar;
    xdg.configFile."rofi".source = ./config/rofi;
    xdg.configFile."gammastep".source = ./config/gammastep;
    xdg.configFile."nwg-look".source = ./config/nwg-look;
    xdg.configFile."swaylock".source = ./config/swaylock;

    home.packages = with pkgs; [
        neovim
        ripgrep
        nil
        nixpkgs-fmt
        gcc
        nodejs
    ];
}
