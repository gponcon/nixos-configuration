# Chargé par le flake dans la section home-manager

{ config, lib, pkgs, ...}:
{
  home.username = "gponcon";
  home.homeDirectory = "/home/gponcon";
  home.packages = with pkgs; [

    # Bureautique graphique
    libreoffice
    obsidian
    hunspell
    hunspellDicts.fr-moderne
    #thunderbird
    #gv
    #ghostscript

    # Outils CLI
    presenterm
    asciidoc-full
    asciidoctor
    aspellDicts.fr
    ranger

    # Développement, administration
    vscode
    zellij
    python3Full
    ccrypt
    btop
    duf
    bat
    gparted
    findutils # locate

    # Réseau
    nmap
    filezilla
    #nettools

    # Outils Bac Pro
    klavaro
    fritzing
    ngspice # Simulateur elec
    qucs-s # Schéma elec + simulation

    # Productivité, multimédia
    inkscape
    geeqie
    gimp
    evince

    # Tweak
    powerline
    powerline-fonts
  ];

  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 1800;
    enableSshSupport = true;
  };

  # A mettre dans un fichier à part
  # Conf complète : https://github.com/jagajaga/my_configs/blob/master/.nixpkgs/vimrc.nix
  programs.vim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      ctrlp-vim
      emmet-vim
      fzf-vim
      fzfWrapper
      gruvbox
      lightline-vim
      lightline-gruvbox-vim
      mini-completion
      nerdtree
      nerdtree-git-plugin
      #vim-airline
      vim-gitgutter
      vim-lastplace
      vim-nix
    ];
    settings = { ignorecase = true; };
    extraConfig = ''
      set mouse=a

      " Set utf8 as standard encoding and en_US as the standard language
      set encoding=utf8

      " Use Unix as the standard file type
      set ffs=unix,dos,mac

      " Enable syntax highlighting
      syntax enable

      " Set 7 lines to the cursor - when moving vertically using j/k
      set so=7

      " 1 tab == 2 spaces
      set shiftwidth=2
      set tabstop=2
      set shiftround                  "Round spaces to nearest shiftwidth multiple
      set nojoinspaces                "Don't convert spaces to tabs
 
      set ai "Auto indent
      set si "Smart indent
      set wrap "Wrap lines

      " Visual mode pressing * or # searches for the current selection
      " Super useful! From an idea by Michael Naumann
      vnoremap <silent> * :call VisualSelection('f')<CR>
      vnoremap <silent> # :call VisualSelection('b')<CR>

      " Always show the status line
      set laststatus=2

      " Format the status line
      "set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l

      " Gruvbox (theme)
      set termguicolors
      set background=dark
      let g:gruvbox_italic=1
      colorscheme gruvbox

      " Airline options
      "let g:airline#extensions#tabline#enabled = 1 
      "let g:airline_powerline_fonts = 1

      let g:lightline = {
      \ 'colorscheme': 'jellybeans',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }
   '';
  };

  # VIM spell files
#  let
#    nvim-spell-fr-utf8-dictionary = builtins.fetchurl {
#      url = "http://ftp.vim.org/vim/runtime/spell/fr.utf-8.spl";
#      sha256 = "abfb9702b98d887c175ace58f1ab39733dc08d03b674d914f56344ef86e63b61";
#    };
#    nvim-spell-fr-utf8-suggestions = builtins.fetchurl {
#      url = "http://ftp.vim.org/vim/runtime/spell/fr.utf-8.sug";
#      sha256 = "0294bc32b42c90bbb286a89e23ca3773b7ef50eff1ab523b1513d6a25c6b3f58";
#    };
#  in
#  {
#    home.file."${config.xdg.configHome}/nvim/spell/fr.utf-8.spl".source = nvim-spell-fr-utf8-dictionary;
#    home.file."${config.xdg.configHome}/nvim/spell/fr.utf-8.sug".source = nvim-spell-fr-utf8-suggestions;
#  }

  # Déjà dans la conf globale, à étudier
  #programs.zsh = {
  #  enable = true;
  #  enableCompletion = true;
  #  autosuggestion.enable = true;
  #  syntaxHighlighting.enable = true;
  #  shellAliases = {
  #    ll = "ls -l";
  #    update = "sudo nixos-rebuild switch";
  #  };
  #  history.size = 10000;
  #  promptInit = "source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
  #  shellInit = ''
  #    export MANPAGER="less -M -R -i --use-color -Dd+R -Du+B -DHkC -j5";
  #  '';
  #};

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "25.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
