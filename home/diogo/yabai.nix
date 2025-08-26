{ pkgs, lib, ... }:
{
  home.file.".yabairc" = lib.mkIf pkgs.stdenv.hostPlatform.isDarwin {
    text = ''
      #!/usr/bin/env sh

      # globals
      yabai -m config mouse_follows_focus on
      yabai -m config split_ratio 0.50

      # space
      yabai -m config layout bsp
      yabai -m config top_padding 8
      yabai -m config bottom_padding 8
      yabai -m config left_padding 8
      yabai -m config right_padding 8
      yabai -m config window_gap 8
      yabai -m config external_bar main:0:0

      # space 1: web
      yabai -m space 1 --label web
      yabai -m rule --add app="Twilight" space=web
      yabai -m rule --add app="Safari" space=web

      # space 2: dev
      yabai -m space 2 --label dev
      yabai -m rule --add app="kitty" space=dev
      yabai -m rule --add app="Xcode" space=dev

      # space 3: misc
      yabai -m space 3 --label misc --layout stack
      yabai -m rule --add app="Notes" space=misc
      yabai -m rule --add app="Sketch Beta" space=misc
      yabai -m rule --add app="Steam" space=misc
      yabai -m rule --add app="Reminders" space=misc

      # space 4: display 2
      yabai -m space 4 --label stack --layout stack
      yabai -m rule --add app="Vesktop" space=stack
      yabai -m rule --add app="Signal" space=stack
      yabai -m rule --add app="Messages" space=stack
      yabai -m rule --add app="Mail" space=stack
      yabai -m rule --add app="WhatsApp" space=stack
      yabai -m rule --add app="Podcasts" space=stack
      yabai -m rule --add app="Music" space=stack
      yabai -m rule --add app="Thunderbird" space=stack

      # don't manage
      yabai -m rule --add label="System Settings" app="^System Settings$" manage=off
      yabai -m rule --add label="About This Mac" app="^System Information$" title="About This Mac" manage=off
      yabai -m rule --add label="Software Update" title="Software Update" manage=off
      yabai -m rule --add label="Safari" app="^Safari$" title="^(General|(Tab|Website|Profile|Extension|Feature Flag)s|AutoFill|Se(arch|curity)|Privacy|Advanced|Developer)$" manage=off
      yabai -m rule --add label="Finder" app="^Finder$" manage=off
      yabai -m rule --add label="App Store" app="^App Store$" manage=off
      yabai -m rule --add label="Activity Monitor" app="^Activity Monitor$" manage=off
      yabai -m rule --add label="Calculator" app="^Calculator$" manage=off
      yabai -m rule --add label="Dictionary" app="^Dictionary$" manage=off
      yabai -m rule --add label="1Password" app="^1Password$" manage=off
      yabai -m rule --add label="FaceTime" app="^FaceTime$" manage=off
    '';
  };
}
