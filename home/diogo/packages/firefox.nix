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
          "https://bdiogo.app"
          "https://github.com"
          "https://steamcommunity.com"
          "https://steampowered.com"
          "https://1password.com"
          "https://1password.eu"
          "https://google.com"
          "https://youtube.com"
          "https://proton.me"
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
          "https://kagi.com"
          "https://luvsick.gg"
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
          "https://addons.mozilla.org/firefox/downloads/latest/refined-github-/latest.xpi"
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
            Name = "Kagi";
            IconURL = "https://kagi.com/favicon.ico";
            URLTemplate = "https://kagi.com/search?q={searchTerms}";
            Alias = "kagi";
            SuggestURLTemplate = "https://kagi.com/api/autosuggest?q={searchTerms}";
          }
          {
            Name = "Startpage";
            IconURL = "https://www.startpage.com/sp/cdn/favicons/favicon--light.ico";
            URLTemplate = "https://www.startpage.com/sp/search?query={searchTerms}";
            Alias = "startpage";
            SuggestURLTemplate = "https://www.startpage.com/osuggestions?q={searchTerms}";
          }
          {
            Name = "Qwant";
            IconURL = "https://www.qwant.com/favicon.ico";
            URLTemplate = "https://www.qwant.com/?q={searchTerms}";
            Alias = "qwant";
            SuggestURLTemplate = "https://api.qwant.com/api/suggest/?q={searchTerms}";
          }
        ];
        Default = "Kagi";
      };
    };
  };
in

{
  home.activation.installFirefoxPolicies = lib.mkIf (pkgs.stdenv.hostPlatform.isDarwin) (
    lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      mkdir -p "/Applications/Twilight.app/Contents/Resources/distribution"
      echo '${builtins.toJSON policies}' > "/Applications/Twilight.app/Contents/Resources/distribution/policies.json"
    ''
  );
}
