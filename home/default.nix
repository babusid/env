{
  homeDirectory,
  username,
  ...
}:

{
  imports = [
    ./neovim.nix
  ];

  home.username = username;
  home.homeDirectory = homeDirectory;
  home.stateVersion = "25.05";

  programs.home-manager.enable = true;

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  xdg.configFile."starship.toml".source = ../starship.toml;
  xdg.configFile."ghostty/config".source = ../ghostty_config;
  xdg.configFile."ghostty/themes/everforest-dark".source = ../ghostty_theme;

  home.sessionVariables = {
    EDITOR = "nvim";
  };
}
