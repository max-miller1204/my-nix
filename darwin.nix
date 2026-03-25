{ pkgs, self, ... }: {
  environment.systemPackages = with pkgs; [
    vim
    ripgrep
    fd
    curl
    jq
  ];

  nix.settings.experimental-features = "nix-command flakes";
  nix.gc = {
    automatic = true;
    interval = { Weekday = 0; Hour = 3; Minute = 0; };
    options = "--delete-older-than 7d";
  };

  # Homebrew (declarative management)
  homebrew.enable = true;
  homebrew.enableZshIntegration = true;
  homebrew.onActivation = {
    autoUpdate = true;
    cleanup = "zap";
  };
  homebrew.brews = [
    "cosign"
    "direnv"
    "fastfetch"
    "llama.cpp"
    "mise"
    "podman"
    "poppler"
    "uv"
  ];
  homebrew.casks = [
    "aerospace"
    "balenaetcher"
    "claude"
    "claude-code"
    "codex"
    "font-jetbrains-mono-nerd-font"
    "karabiner-elements"
    "macdown-3000"
    "neovide-app"
    "pearcleaner"
    "raycast"
    "spotify"
    "utm"
    "wezterm"
    "zed"
  ];

  # macOS defaults
  system.defaults.dock.autohide = true;
  system.defaults.finder.AppleShowAllExtensions = true;
  system.defaults.finder.AppleShowAllFiles = true;
  system.defaults.LaunchServices.LSQuarantine = false;

  # User
  system.primaryUser = "max";
  users.users.max.home = "/Users/max";

  system.configurationRevision = self.rev or self.dirtyRev or null;
  system.stateVersion = 6;
  nixpkgs.hostPlatform = "aarch64-darwin";
}
