#!/bin/bash

# install packages listed in packages file
apt install -y $(cat packages | xargs)

mv --backup=numbered ~/.vimrc ~/vimrc

cat > ~/.vimrc<<EOF
" encoding dectection
set fileencodings=utf-8,gb2312,gb18030,gbk,ucs-bom,cp936,latin1

" enable filetype dectection and ft specific plugin/indent
filetype plugin indent on

" enable syntax hightlight and completion
syntax on

" search
set incsearch
"set highlight 	" conflict with highlight current line
set ignorecase
set smartcase

" editor settings
set history=1000
set nocompatible
set nofoldenable                                                    " disable folding"
set confirm                                                         " prompt when existing from an unsaved file
set backspace=indent,eol,start                                      " More powerful backspacing
set t_Co=256                                                        " Explicitly tell vim that the terminal has 256 colors "
set mouse=v                                                         " use mouse in visual mode
set report=0                                                        " always report number of lines changed                "
set nowrap                                                          " dont wrap lines
set scrolloff=5                                                     " 5 lines above/below cursor when scrolling
set number                                                          " show line numbers
set showmatch                                                       " show matching bracket (briefly jump)
set showcmd                                                         " show typed command in status bar
set title                                                           " show file in titlebar
set laststatus=2                                                    " use 2 lines for the status bar
set matchtime=2                                                     " show matching bracket for 0.2 seconds
set matchpairs+=<:>                                                 " specially for html
" set relativenumber

" Default Indentation
set autoindent
set smartindent                                                     " indent when
set tabstop=4                                                       " tab width
set softtabstop=4                                                   " backspace
set shiftwidth=4                                                    " indent width
" set textwidth=79
" set smarttab
set expandtab                                                       " expand tab to space
EOF

# install oh-my-zsh
yes | sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

mv --backup=numbered ~/.zshrc ~/zshrc

cat > ~/.zshrc<<EOF
# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
zstyle ':omz:update' frequency 30

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
COMPLETION_WAITING_DOTS="true"

# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="mm/dd/yyyy"

# Which plugins would you like to load?
# Add wisely, as too many plugins slow down shell startup.
plugins=(git dotenv colored-man-pages command-not-found fzf thefuck tmux)

source "$HOME/.oh-my-zsh/oh-my-zsh.sh"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

export EDITOR='vim'

# Compilation flags
# export ARCHFLAGS="-arch x86_64"
EOF

# install fuzzy finder 
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
yes | ~/.fzf/install

# install the latest thefuck from pypi
pip3 install thefuck

echo "excluded_search_path_prefixes = ['/mnt/']" >> ~/.config/thefuck/settings.py

# set zsh as default shell
chsh -s $(which zsh)

