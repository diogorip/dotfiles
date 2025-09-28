{
  system.defaults = {
    dock = {
      autohide = true;
      tilesize = 35;
      orientation = "left";
      show-recents = false;
      minimize-to-application = true;
      mru-spaces = false;
      persistent-apps = [
        { app = "/Applications/Zen.app"; }
        { app = "/System/Applications/Mail.app"; }
        { app = "/nix/store/2j3fp70magmwbrfzvmqkf3wlb2b4lr2p-ghostty-bin-1.2.0/Applications/Ghostty.app"; }
        { app = "/nix/store/v6kar0dsqx37vbkbjmglacd0lscbbh85-vesktop-1.5.8/Applications/Vesktop.app"; }
        { app = "/System/Applications/System Settings.app"; }
      ];
    };

    NSGlobalDomain = {
      AppleShowScrollBars = "WhenScrolling";
      AppleShowAllExtensions = true;
      AppleShowAllFiles = true;
      NSAutomaticQuoteSubstitutionEnabled = false;
      NSAutomaticDashSubstitutionEnabled = false;
      NSAutomaticSpellingCorrectionEnabled = false;
      NSAutomaticCapitalizationEnabled = false;
      NSScrollAnimationEnabled = true;
    };

    WindowManager = {
      EnableStandardClickToShowDesktop = false;
    };

    screensaver = {
      askForPassword = true;
      askForPasswordDelay = 0;
    };

    finder = {
      ShowPathbar = true;
      FXEnableExtensionChangeWarning = false;
      AppleShowAllExtensions = true;
      AppleShowAllFiles = true;
      FXRemoveOldTrashItems = true;
      ShowHardDrivesOnDesktop = true;
    };

    CustomUserPreferences."com.apple.finder" = {
      ShowExternalHardDrivesOnDesktop = true;
      ShowHardDrivesOnDesktop = true;
      ShowMountedServersOnDesktop = true;
      ShowRemovableMediaOnDesktop = true;
      _FXSortFoldersFirst = true;
      FXDefaultSearchScope = "SCcf";
      WarnOnEmptyTrash = false;
    };

    loginwindow = {
      GuestEnabled = false;
      SHOWFULLNAME = false;
    };

    controlcenter = {
      BatteryShowPercentage = true;
      Bluetooth = false;
      Display = false;
      FocusModes = false;
      NowPlaying = false;
      Sound = false;
    };
  };

  system.activationScripts.postActivate.text = ''
    #!/usr/bin/env bash
    set -e

    sudo chflags nohidden /Volumes
    chflags nohidden "$HOME/Library"
    sudo dscacheutil -flushcache
    sudo killall -HUP mDNSResponder

    killall Dock Finder SystemUIServer WindowManager || true
  '';
}
