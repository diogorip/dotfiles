{ config, ... }:
{
  programs.vesktop = {
    inherit (config.sys.profiles.graphical) enable;
    settings = {
      discordBranch = "canary";
      transparencyOption = "acrylic";
      disableSmoothScroll = false;
      hardwareAcceleration = true;
      arRPC = true;
      appBadge = true;
    };
    vencord.settings = {
      plugins = {
        AppleMusicRichPresence = {
          enabled = true;
          refreshInterval = 5;
          largeImageType = "Album";
          smallImageType = "Artist";
          largeTextString = "{album}";
          smallTextString = "{artist}";
          enableButtons = false;
          nameString = "Apple Music";
          detailsString = "{name}";
          stateString = "{artist} · {album}";
          enableTimestamps = true;
          activityType = 2;
        };
        FakeNitro.enabled = true;
        FixYoutubeEmbeds.enabled = true;
        FixSpotifyEmbeds.enabled = true;
        FixImagesQuality.enabled = true;
        FixCodeblockGap.enabled = true;
        ForceOwnerCrown.enabled = true;
        FriendsSince.enabled = true;
        ImageZoom.enabled = true;
        LastFMRichPresence = {
          enabled = true;
          hideWithActivity = false;
          hideWithSpotify = true;
          shareUsername = false;
          shareSong = true;
          statusName = "";
          nameFormat = "artist";
          useListeningStatus = true;
          missingArt = "lastfmLogo";
          showLastFmLogo = true;
        };
        MessageLogger = {
          enabled = true;
          collapseDeleted = true;
          deleteStyle = "text";
          ignoreBots = false;
          ignoreSelf = true;
          logEdits = true;
          logDeletes = true;
          inlineEdits = true;
        };
        NSFWGateBypass.enabled = true;
        PlatformIndicators.enabled = true;
        ReviewDB.enabled = true;
        RoleColorEverywhere.enabled = true;
        SecretRingToneEnabler.enabled = true;
        ShikiCodeblocks.enabled = true;
        ShowHiddenChannels.enabled = true;
        ShowHiddenThings.enabled = true;
        SpotifyControls = {
          enabled = true;
          hoverControls = true;
        };
        SpotifyCrack = {
          enabled = true;
          noSpotifyAutoPause = true;
          keepSpotifyActivityOnIdle = false;
        };
        StreamerModeOnStream.enabled = true;
        TextReplace = {
          enabled = true;
          stringRules = [
            {
              find = "://bsky.app/";
              replace = "://fxbsky.app/";
            }
            {
              find = "://instagram.com/";
              replace = "://ddinstagram.com/";
            }
            {
              find = "://www.instagram.com/";
              replace = "://ddinstagram.com/";
            }
            {
              find = "://reddit.com/";
              replace = "://rxddit.com/";
            }
            {
              find = "://www.reddit.com/";
              replace = "://rxddit.com/";
            }
            {
              find = "://tiktok.com/";
              replace = "://tfxktok.com/";
            }
            {
              find = "://vm.tiktok.com/";
              replace = "://vm.vxtiktok.com/";
            }
            {
              find = "://twitter.com/";
              replace = "://fxtwitter.com/";
            }
            {
              find = "://x.com/";
              replace = "://fxtwitter.com/";
            }
          ];
        };
        TypingIndicator = {
          enabled = true;
          includeMutedChannels = false;
          includeCurrentChannel = true;
          indicatorMode = 3;
        };
        TypingTweaks = {
          enabled = true;
          alternativeFormatting = true;
          showRoleColors = true;
          showAvatars = true;
        };
        UserMessagesPronouns.enabled = true;
        USRBG.enabled = true;
        WhoReacted.enabled = true;
        NoTrack = {
          enabled = true;
          disableAnalytics = true;
        };
        Settings.enabled = true;
        ClearURLs.enabled = true;
      };
    };
  };
}
