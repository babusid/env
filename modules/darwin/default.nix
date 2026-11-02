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
    basedpyright
    clang-tools
    curl
    fd
    git
    jq
    lazygit
    llvmPackages.openmp
    marksman
    nodejs
    pre-commit
    ripgrep
    ruff
    rustup
    starship
    tree
    ty
    uv
    wget
    zig
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
  ];

  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = false;
      cleanup = "none";
      upgrade = false;
    };
    brews = [
      "opencode"
    ];
    casks = [
      "ghostty"
      "raycast"
      "codex"
      "claude-code"
    ];
  };
}
