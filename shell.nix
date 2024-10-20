{ pkgs ? import <nixpkgs> {} }:

let
  neovimConfig = pkgs.neovimUtils.makeNeovimConfig {
    extraLuaPackages = p: with p; [
      p.magick # for image rendering
    ];
    extraPython3Packages = p: with p; [
      pynvim
      jupyter-client
      cairosvg # for image rendering
      ipython
      nbformat
    ];
    extraPackages = p: with p; [
      imageMagick # for image rendering
    ];
    withNodeJs = true;
    withRuby = true;
    withPython3 = true;
    customRC = "luafile ~/.config/nvim/init.lua";
  };

  neovim-custom = pkgs.wrapNeovimUnstable
    (pkgs.neovim-unwrapped.overrideAttrs (oldAttrs: {
      buildInputs = oldAttrs.buildInputs ++ [ pkgs.tree-sitter ];
    })) neovimConfig;

in pkgs.mkShell {
  buildInputs = with pkgs; [
    neovim-custom
    python3Packages.jupytext
  ];
}
