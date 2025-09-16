{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    withNodeJs = true;
    plugins = with pkgs.vimPlugins; [
      catppuccin-nvim
      nvim-cmp
      cmp-buffer
      cmp-nvim-lsp
      cmp-path
      conform-nvim
      gitsigns-nvim
      lualine-nvim
      mini-nvim
      nvim-lspconfig
      nvim-navic
      nvim-tree-lua
      plenary-nvim
      telescope-file-browser-nvim
      telescope-fzf-native-nvim
      telescope-nvim
      which-key-nvim
      nvim-treesitter.withAllGrammars
    ];
    extraPackages = with pkgs; [
      nixd
      nil
      vtsls
      vue-language-server
      docker-language-server
      docker-compose-language-service
      yaml-language-server
      bash-language-server
      lua-language-server
      astro-language-server
      tailwindcss-language-server
      emmet-language-server
      terraform-ls
      gopls
    ];

    extraLuaConfig = ''
      ${builtins.readFile ./init.lua}
      vim.cmd("colorscheme catppuccin")
    '';
  };

  home.file = {
    ".vimrc".text = builtins.readFile ./.vimrc;
  };
}
