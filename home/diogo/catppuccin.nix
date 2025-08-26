{ inputs, ... }:
{
  imports = [ inputs.catppuccin.homeModules.catppuccin ];

  catppuccin = {
    enable = true;
    flavor = "frappe";
    accent = "pink";
    nvim.enable = false;
  };
}
