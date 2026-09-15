{ config, pkgs, inputs, lib, ... }:


let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
  wlctl = inputs.wlctl.packages.${pkgs.system}.default;

  configDirs = [
    "sway"
    "kitty"
    "waybar"
    "rofi"
    "gammastep"
    "nwg-look"
    "swaylock"
    "helix"
  ];


  homeFiles = [
    ".zshrc"
  ];

  binFiles = [
    "screenshot"
    "battery"
    "bluetoothdevice"
    "clearcache"
    "connectwifi"
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
    inputs.spicetify-nix.homeManagerModules.spicetify
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


  programs.spicetify = {
    enable = true;

    enabledExtensions = with spicePkgs.extensions; [
      adblockify
      shuffle
    ];

  };

  programs.tmux = {
    enable = true;
    shortcut = "b";
    keyMode = "vi";

    plugins = with pkgs.tmuxPlugins; [
      {
        plugin = tmux-fzf;
        extraConfig = ''
          set -sg escape-time 10
          setw -g mode-keys vi
          set -as terminal-features ",*:RGB"
        '';
      }
    ];
  };

  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    tmux.enableShellIntegration = true;
  };


  programs.zed-editor = {
    enable = true;
    installRemoteServer = true;
  };

  home.packages = with pkgs; [
    brave
    neovim
    telegram-desktop
    qbittorrent
    helix
    opencode
    vim
    ripgrep
    nil
    nixpkgs-fmt
    gcc
    onlyoffice-desktopeditors
    mpv
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
    cargo
    clippy
    vscode
    chromium
    wlctl
  ];

  xdg.configFile =
    builtins.listToAttrs (
      map
        (name: {
          name = name;
          value = {
            source = ./config/${name};
            recursive = true;
          };
        })
        configDirs
    );

  home.file =
    (builtins.listToAttrs (
      map
        (name: {
          name = name;
          value = {
            source = ./home/${name};
          };
        })
        homeFiles
    ))
    //
    (builtins.listToAttrs (
      map
        (name: {
          name = ".local/bin/${name}";
          value = {
            source = ./bin/${name};
            executable = true;
          };
        })
        binFiles
    ));

}
