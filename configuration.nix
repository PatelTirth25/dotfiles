{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelParams = [ "quiet" "loglevel=3" ];

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

  hardware.graphics.enable = true;
  security.polkit.enable = true;

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    extraPackages = with pkgs; [
      swaylock
      wl-clipboard
      waybar
      swaybg
      rofi
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


  environment.systemPackages = with pkgs; [
    ntfs3g
    btop
    wget
    git
    kitty
    pywal
    nemo-with-extensions
    brightnessctl
    nwg-look
    bibata-cursors
    gnome-themes-extra
    adwaita-icon-theme
    papirus-icon-theme
    pavucontrol
    fastfetch
    gammastep
    grim
    slurp
    efibootmgr
    bluetui
    trash-cli
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.noto
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

