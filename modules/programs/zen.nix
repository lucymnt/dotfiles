{ config, pkgs, inputs, ... }:
{
  imports = [
    inputs.zen-browser.homeModules.default
  ];
  
  programs.zen-browser = {
    enable = true;
    policies = {
      DisableTelemetry = true;
      DisableAppUpdate = true;
      AutofillAddressEnabled = true;
      DisableFeedbackCommands = true;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      DontCheckDefaultBrowser = true;
    };
    profiles.default = {
      userChrome = builtins.readFile ../../dotfiles/zen/userChrome.css;
   #  userContent = builtins.readFile ../../dotfiles/zen/userContent.css;
      settings = {
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "zen.theme.enabled" = false;
      };
    };
  };
}


