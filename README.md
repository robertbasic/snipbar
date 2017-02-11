# snipbar

A Vim plugin to show all the [UltiSnips](https://github.com/SirVer/ultisnips) snippets in a scratch buffer.

# Usage

Just call `:SnipBar` and it will open a scratch buffer to the right, 40 columns width, with all the snippets that are available for the current file.

Uses `UltiSnips#SnippetsInCurrentScope` to get the list of snippets.

Call `:SnipBar` again to close it.

Map it for even easier access, something like:

``` vim
nnoremap <F9> :SnipBar<CR>
```

# Why?

I don't know all the snippets I have available, so I wrote this small plugin to have a list of them always open.

Yes, I know I can also get the same list by doing `<c-tab>` in insert mode.

# Installation

Using [vim-plug](https://github.com/junegunn/vim-plug):

`Plug 'robertbasic/snipbar'`

# Configuration

There is nothing to configure.
