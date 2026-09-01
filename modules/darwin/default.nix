{
  pkgs,
  homeDirectory,
  username,
  ...
}:

{
  system.primaryUser = username;
  system.stateVersion = 6;

  nix.package = pkgs.lix;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nixpkgs.hostPlatform = "aarch64-darwin";
  nixpkgs.config.allowUnfree = true;

  users.users.${username}.home = homeDirectory;

  programs.zsh.enable = true;

  environment.systemPackages = with pkgs; [
    curl
    fd
    git
    jq
    lazygit
    ripgrep
    starship
    tree
    uv
    wget
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
  ];

  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
      upgrade = true;
    };
    casks = [
      "ghostty"
      "raycast"
    ];
  };
}
