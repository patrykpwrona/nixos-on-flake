{ config, pkgs, ... }:
{
  ## Home manager settings
  home.stateVersion = "23.11"; # initial home-manager version, no need to touch
  programs.home-manager.enable = true;

  ## Home settings
  home = {
    username = "pw";
    homeDirectory = "/home/pw";
  };
  home.sessionVariables = {
    EDITOR = "vim";
  };
  
  ## Packages installed by home-manager
  home.packages = with pkgs; [
    hello
  ];

  ## Git global config
  programs.git = {
    enable = true;
    userName = "User Name";
    userEmail = "mail@mailserver";
    extraConfig = {
      pull = {
        rebase = true; # git pull = git pull --rebase
      };
    };
  };

  ## Wezterm terminal - actually it is only one config file, so home manager make no sense here
  programs.wezterm = {
    enable = true;
    extraConfig = ''
local wezterm = require 'wezterm'
local config = wezterm.config_builder()
-- # Config start
config.font_size = 16
config.window_background_opacity = 0.8
config.initial_rows = 25
config.initial_cols = 120
config.keys = {
  { key = 'LeftArrow', mods = 'ALT', action = wezterm.action.ActivateTabRelative(-1) },
  { key = 'RightArrow', mods = 'ALT', action = wezterm.action.ActivateTabRelative(1) },
  { key = 'LeftArrow', mods = 'CTRL|SHIFT', action = wezterm.action.MoveTabRelative(-1) },
  { key = 'RightArrow', mods = 'CTRL|SHIFT', action = wezterm.action.MoveTabRelative(1) },
  { key = 't', mods = 'CTRL', action = wezterm.action.SpawnTab 'CurrentPaneDomain' },
}
config.enable_scroll_bar = true
config.scrollback_lines = 5000
config.audible_bell = "Disabled"
config.enable_wayland = true
config.hide_mouse_cursor_when_typing = false

-- # Auto switch light / dark theme
-- wezterm.gui is not available to the mux server, so take care to
-- do something reasonable when this config is evaluated by the mux (?)
function get_appearance()
  if wezterm.gui then
    return wezterm.gui.get_appearance()
  end
  return 'Dark'
end
function scheme_for_appearance(appearance)
  if appearance:find 'Dark' then
    return 'iTerm2 Tango Dark'
  else
    -- return 'iTerm2 Tango Light'
    -- return 'Isotope (light) (terminal.sexy)'
    return 'One Light (base16)'
  end
end
config.color_scheme = scheme_for_appearance(get_appearance())

-- # Congfig end
return config
    '';
  };

  ## VS Code
  programs.vscode = {
    enable = true;
    enableUpdateCheck = false;
    enableExtensionUpdateCheck = false;
    mutableExtensionsDir = false;
    extensions = (with pkgs.vscode-extensions; [
        pkief.material-icon-theme # Prettier icons        
        eamodio.gitlens # Inline blame and other git stuff
        bbenoist.nix # Nix syntax
        samuelcolvin.jinjahtml # Better Jinja
        redhat.ansible # Ansible syntax, requires `ansible-lint` installed on system
        ms-python.python # Dependency for Redhat Ansible
        redhat.vscode-yaml # Dependency for Redhat Ansible
      ]) ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          # retrieve last commit message with one click
          name = "git-last-commit-message";
          publisher = "JanBn";
          version = "1.9.0";
          sha256 = "atINTAGN0RVYMiiz9LZyPt1YU1IIdlqCjptQo/SpoPM="; # set to anything, first rebuild fail tell you the correct one        
        }
    ];
    userSettings = {
      "window.zoomLevel" = 2;
      "editor.wordWrap" = "on";
      "workbench.iconTheme" = "material-icon-theme";
      "git.rebaseWhenSync" = true;
      "git.confirmSync" = false;
      "window.autoDetectColorScheme" = true;
      "window.autoDetectHighContrast" = true;
      "workbench.preferredHighContrastColorTheme" = "Default High Contrast Light";
      "redhat.telemetry.enabled" = false; # for redhat extensions
      "files.associations" = {
        "*.yml" = "ansible";
        "*.yaml" = "ansible";
      };
    };
    keybindings = [
      {
        key = "alt+right";
        command = "workbench.action.nextEditor";
      }
      {
        key = "alt+left";
        command = "workbench.action.previousEditor";
      }
    ];
  };
 
  ## Zoxide - cd replacemenet
  # Usage: `z` and `zi`
  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
  };

  ## Home-manager have to manage bash files for creating aliases (for zoxide)
  programs.bash = {
    enable = true;
  };
 
}
