{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelParams = [
    "quiet"
    "loglevel=0"
  ];

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  time.timeZone = "Asia/Kolkata";

  # Enable the X11 windowing system.
  # services.xserver.enable = true;

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
  };

  # services.flatpak.enable = false;


  nixpkgs.config.allowUnfree = true;

  hardware.graphics.enable = true;
  security.polkit.enable = true;


  systemd.user.services.polkit-gnome-authentication-agent-1 = {
    description = "polkit-gnome-authentication-agent-1";
    wantedBy = [ "graphical-session.target" ];
    wants = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 30;
    };
  };

  programs.sway = {
    enable = true;
    xwayland.enable = true;
    wrapperFeatures.gtk = true;
    extraPackages = with pkgs; [
      swaylock
      waybar
      swaybg
      rofi
      kitty
      pywal
      nemo-with-extensions
      nwg-look
      bibata-cursors
      gnome-themes-extra
      adwaita-icon-theme
      papirus-icon-theme
      slurp
      grim
      gammastep
    ];
  };

  programs.zsh.enable = true;

  programs.waybar = {
    enable = true;
  };

  services.displayManager.ly.enable = true;

  services.xserver.xkb.layout = "us";

  services.printing.enable = true;

  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
    wireplumber.enable = true;
  };

  services.libinput.enable = true;
  services.gvfs.enable = true;

  users.users.tirth = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "input" "audio" "networkmanager" ];
    packages = with pkgs; [
      tree
    ];
    shell = pkgs.zsh;
  };

  # programs.firefox.enable = true;

  programs.nix-ld.enable = true;

  xdg.portal = {
    enable = true;

    extraPortals = with pkgs; [
      xdg-desktop-portal
      xdg-desktop-portal-wlr
      xdg-desktop-portal-gtk
    ];

  };


  xdg.portal.config.common.default = lib.mkForce [ "gtk" ];

  environment.localBinInPath = true;

  environment.sessionVariables = {
    MOZ_ENABLE_WAYLAND = "1";
  };

  environment.systemPackages = with pkgs; [
    alsa-tools
    wl-clipboard
    wf-recorder
    ntfs3g
    btop
    wget
    git
    brightnessctl
    pavucontrol
    fastfetch
    zip
    unzip
    efibootmgr
    bluetui
    trash-cli
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.noto
    corefonts
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  system.stateVersion = "26.05";

}

