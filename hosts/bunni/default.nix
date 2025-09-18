{
  sys = {
    profiles.graphical.enable = true;
    services.yabai.enable = true;
  };

  system.primaryUser = "diogo";

  security.pam.services.sudo_local.touchIdAuth = true;
}
