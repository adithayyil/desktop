{ ... }:

{
  programs.nvf = {
    enable = true;

    settings.vim = {
      viAlias = false;
      vimAlias = true;

      theme = {
        enable = true;
        name = "catppuccin";
        style = "latte";
      };

      lsp.enable = true;

      languages = {
        nix.enable = true;
        rust.enable = true;
        python.enable = true;
        bash.enable = true;
      };

      treesitter.enable = true;

      telescope.enable = true;

      autocomplete.nvim-cmp.enable = true;

      options = {
        number = true;
        relativenumber = true;
        tabstop = 2;
        shiftwidth = 2;
        expandtab = true;
        clipboard = "unnamedplus";
        mouse = "a";
      };
    };
  };
}
