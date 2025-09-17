{
  pkgs,
  lib,
  ...
}:
let
  policies = {
    policies = {
      AppAutoUpdate = false;
      DisableAppUpdate = true;
      ManualAppUpdateOnly = true;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      DisableTelemetry = true;
      DontCheckDefaultBrowser = true;
      OfferToSaveLogins = false;
      NoDefaultBookmarks = true;
      Cookies = {
        Allow = [
          "https://bsky.app"
          "https://github.com"
          "https://steamcommunity.com"
          "https://steampowered.com"
          "https://1password.com"
          "https://1password.eu"
          "https://google.com"
          "https://youtube.com"
          "https://cloudflare.com"
          "https://twitch.tv"
          "https://apple.com"
          "https://icloud.com"
          "https://instagram.com"
          "https://porkbun.com"
          "https://ovh.com"
          "https://ovh.pt"
          "https://ovhcloud.com"
          "https://amazon.es"
          "https://hetzner.com"
          "https://mistral.ai"
          "https://codeberg.org"
          "https://revolut.com"
          "https://luvsick.gg"
          "http://10.100.0.1"
        ];
      };
      SanitizeOnShutdown = {
        Cache = true;
        Cookies = true;
        FormData = true;
      };
      DisableFirefoxAccounts = true;
      DNSOverHTTPS = {
        Enabled = true;
        ProviderURL = "https://security.cloudflare-dns.com/dns-query";
        Fallback = true;
        Locked = true;
      };
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
        EmailTracking = true;
      };
      HttpsOnlyMode = "force_enabled";
      SkipTermsOfUse = true;
      Extensions = {
        Install = [
          "https://addons.mozilla.org/firefox/downloads/latest/1password-x-password-manager/latest.xpi"
          "https://addons.mozilla.org/firefox/downloads/latest/betterttv/latest.xpi"
          "https://addons.mozilla.org/firefox/downloads/latest/catppuccin-web-file-icons/latest.xpi"
          "https://addons.mozilla.org/firefox/downloads/latest/clearurls/latest.xpi"
          "https://addons.mozilla.org/firefox/downloads/latest/return-youtube-dislikes/latest.xpi"
          "https://addons.mozilla.org/firefox/downloads/latest/sponsorblock/latest.xpi"
          "https://addons.mozilla.org/firefox/downloads/latest/steam-database/latest.xpi"
          "https://addons.mozilla.org/firefox/downloads/latest/styl-us/latest.xpi"
          "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi"
        ];
      };
      SearchEngines = {
        Add = [
          {
            Name = "Qwant";
            IconURL = "https://www.qwant.com/favicon.ico";
            URLTemplate = "https://www.qwant.com/?q={searchTerms}";
            Alias = "qwant";
            SuggestURLTemplate = "https://api.qwant.com/api/suggest/?q={searchTerms}";
          }
        ];
        Default = "Qwant";
      };
    };
  };
in

{
  home.activation.installFirefoxPolicies = lib.mkIf (pkgs.stdenv.hostPlatform.isDarwin) (
    lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      mkdir -p "/Applications/Zen.app/Contents/Resources/distribution"
      echo '${builtins.toJSON policies}' > "/Applications/Zen.app/Contents/Resources/distribution/policies.json"
    ''
  );
}
