{ pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    initContent = ''
      source <(fzf --zsh)
      echo -e "\e[35m"
      /bin/cat <<'EOF'
        ╱|、
       (˚ˎ。7
       |、˜〵
       じしˍ,)ノ
      EOF
      echo -e "\e[0m"
    '';

    envExtra = ''
      ${
        if pkgs.stdenv.hostPlatform.isDarwin then
          ''export SSH_AUTH_SOCK=~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock''
        else
          ''''
      }
    '';

    shellAliases = {
      cat = "bat";
      cd = "z";
      cp = "cp -iv";
      mv = "mv -iv";
      rm = "rm -rfv";
      mkdir = "mkdir -pv";
      p = "cd ~/Developer/";
      dl = "cd ~/Downloads/";
      f = "open -a Finder";
      ls = "eza";
      g = "git";
      lg = "lazygit";
      grep = "rg";
      find = "fd";
    };
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.bat.enable = true;

  programs.eza = {
    enable = true;
    git = true;
  };

  programs.fd.enable = true;

  programs.ripgrep = {
    enable = true;

    arguments = [
      "--max-columns=150"
      "--max-columns-preview"
      "--glob=!.git/*"
      "--smart-case"
    ];
  };
}
