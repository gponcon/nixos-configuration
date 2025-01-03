{ pkgs, ... }: {
  # Conf complète : https://github.com/jagajaga/my_configs/blob/master/.nixpkgs/vimrc.nix
  programs.vim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      #vim-airline
      ctrlp-vim
      emmet-vim
      fzf-vim
      fzfWrapper
      gruvbox
      lightline-gruvbox-vim
      lightline-vim
      mini-completion
      nerdtree
      nerdtree-git-plugin
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
}
