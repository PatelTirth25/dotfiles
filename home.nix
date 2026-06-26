{ config, pkgs, inputs, lib, ... }:

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
    "helix"
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
  imports = [
    inputs.zen-browser.homeModules.beta
  ];

  home.username = "tirth";
  home.homeDirectory = "/home/tirth";
  home.stateVersion = "26.05";

  programs.git.enable = true;
  programs.bash.enable = true;

  programs.zen-browser = {
    enable = true;
    setAsDefaultBrowser = true;
  };

    programs.tmux = {
        enable = true;
        shortcut = "b"; 
        keyMode = "vi";

        plugins = with pkgs.tmuxPlugins; [
            {
                plugin = tmux-fzf;
                extraConfig = ''
                '';
            }
        ];
    };

    programs.fzf = {
        enable = true;
        enableBashIntegration = true;
        enableZshIntegration = true; # If you use Zsh
        # Optional tmux pop-up window settings for fzf queries
        tmux.enableShellIntegration = true;
    };

  home.packages = with pkgs; [
    helix
    opencode
    vim
    neovim
    ripgrep
    nil
    nixpkgs-fmt
    gcc
    nodejs
    clang-tools
    basedpyright
    black
    typescript-language-server
    typescript
    prettierd
    lua-language-server
    stylua
    rust-analyzer
    rustfmt
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
