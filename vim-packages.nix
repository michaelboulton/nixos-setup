{ vimrc, pkgs ? import <nixpkgs> { } }:

let

  nvim-parinfer = pkgs.vimUtils.buildVimPlugin {
    name = "nvim-parinfer";
    src = pkgs.fetchFromGitHub {
      owner = "gpanders";
      repo = "nvim-parinfer";
      rev = "82bce5798993f4fe5ced20e74003b492490b4fe8";
      sha256 = "1dzhlaxxf6cf6jcd2a5y97y7li6wkwjhg1q7rny3lkwrf2kxyp0f";
    };
  };

  glyph-palette = pkgs.vimUtils.buildVimPlugin {
    name = "glyph-palette";
    src = pkgs.fetchFromGitHub {
      owner = "lambdalisue";
      repo = "glyph-palette.vim";
      rev = "c9b21e745b4fc11c410afbf4aa9dbe938c3d09c0";
      sha256 = "0jbabnmlr9w4hy2390sm2qxyzlazvlhm87iq5gdw1mcca65gphjq";
    };
  };

  fern-preview = pkgs.vimUtils.buildVimPlugin {
    name = "fern-preview";
    src = pkgs.fetchFromGitHub {
      owner = "yuki-yano";
      repo = "fern-preview.vim";
      rev = "74f2c1c45eb48fe9b7e4aa87032f053808944e17";
      sha256 = "1pq5zppw4ki6hyrqlj56cfwnx3b0ar43wpqsdb3x8f7bbpwr0y4l";
    };
  };

  fern-hijack = pkgs.vimUtils.buildVimPlugin {
    name = "fern-hijack";
    src = pkgs.fetchFromGitHub {
      owner = "lambdalisue";
      repo = "fern-hijack.vim";
      rev = "5989a1ac6ddffd0fe49631826b6743b129992b32";
      sha256 = "14pcvc38qmligkvi4ybxji6wbsayr1y6dpbhads1kh5j9ivd7x6f";
    };
  };

  fern-nerdfont = pkgs.vimUtils.buildVimPlugin {
    name = "nerdfont";
    src = pkgs.fetchFromGitHub {
      owner = "lambdalisue";
      repo = "nerdfont.vim";
      rev = "bdf3fecf42f6d913819fbc6a15fc802c90b195ea";
      sha256 = "1djkfaxr0msank3mvkicrdqa7d6j11apn6xa9mis1djmdar513hl";
    };
  };

  fern-renderer-nerdfont = pkgs.vimUtils.buildVimPlugin {
    name = "fern-renderer-nerdfont";
    src = pkgs.fetchFromGitHub {
      owner = "lambdalisue";
      repo = "fern-renderer-nerdfont.vim";
      rev = "e11156d85e1413fd3286317fc86fef5b5fbf545c";
      sha256 = "1nkcrq3k8zx6g950w6l0y5sqb70p9d8ysb91c82ibrvakqhi9fgp";
    };
  };

  coc-clojure = pkgs.vimUtils.buildVimPlugin {
    name = "coc-clojure";
    src = pkgs.fetchFromGitHub {
      owner = "NoahTheDuke";
      repo = "coc-clojure";
      rev = "774754bf41583845422a28d9a68f7e13502b28a4";
      sha256 = "1j1ypqc1h83r1yblkiyvknrx1df1r720rhi74zlgran1riwwihan";
    };
  };

  coc-conjure = pkgs.vimUtils.buildVimPlugin {
    name = "coc-conjure";
    src = pkgs.fetchFromGitHub {
      owner = "jlesquembre";
      repo = "coc-conjure";
      rev = "921ae16a8c137db8b4709f1b54d6c8e3a2f3546d";
      sha256 = "0pshckc97lyw8v31f3p82lxin9c7xgcsy91zx89i8fbbwpvf7zph";
    };
  };


  buildInputs = with pkgs; [
    git
    universal-ctags
    fd
    bat
    delta
    fzf
    patdiff

    mitscheme
    shellcheck
    rust-analyzer

    # For formatting
    clang
    bazel-buildtools
    go
    stylua
    nixpkgs-fmt
    shfmt
    fnlfmt
    zprint

    # Too many dependencies
    #ripgrep-all
    ripgrep

    (python310.withPackages (ps: [
      ps.pynvim
      ps.yamllint
      ps.pyflakes
      ps.pylint

      ps.black
    ]))

    nodejs
    (with nodePackages; [
      prettier
      diagnostic-languageserver
    ])

    neovim
    (neovim.override {
      vimAlias = true;
      configure = {
        packages.myPlugins = with pkgs.vimPlugins; {
          start = [
            (nvim-treesitter)
            nvim-treesitter-context
            nvim-ts-rainbow
            nvim-ts-autotag

            vim-airline
            vim-airline-themes
            vim-colorschemes
            vim-devicons
            glyph-palette

            fern-vim
            fern-renderer-nerdfont
            fern-nerdfont
            fern-hijack
            fern-preview
            # Not as good as fern
            # coc-explorer

            vim-lastplace
            vim-gitgutter
            vim-fugitive
            vim-bazel
            vim-nix
            fzf-vim
            plenary-nvim
            ultisnips
            auto-session

            vim-autoformat

            undotree

            nvim-autopairs
            vim-closetag
            nvim-parinfer

            vim-commentary

            vim-visual-multi

            vim-dispatch
            vim-dispatch-neovim

            coc-nvim
            coc-go
            coc-yaml
            coc-json
            coc-fzf
            coc-tabnine
            coc-pyright
            coc-ultisnips
            coc-snippets
            coc-highlight
            coc-clojure
            coc-diagnostic
            coc-lua

            # I don't find the git completions useful
            #coc-git

            # Not useful as the clojure lsp provides better results and integrates with coc already
            #coc-conjure
            coc-lua
            coc-rust-analyzer

            toggleterm-nvim
            which-key-nvim

            # lisp
            conjure
            vim-sexp
            vim-sexp-mappings-for-regular-people
            vim-repeat
            vim-surround
            aniseed
          ];
          opt = [ ];
        };
        customRC = vimrc;
      };
    }
    )
  ];

in

{ inherit buildInputs; }
