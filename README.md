# vim-file-header
If 0, **vim-file-header** will be disabled and wont do shit.
```vim
let g:file_header_enabled           = 1   " Default
```

Obviously set the author.
```vim
let g:file_header_author            = 'Set g:file_header_author in your .vimrc'
```

Align colons with each other.  If this is on, the titles (File, Last Change,
etc..) wont be highlighted, this is because the way Vim determines a title
is if at least the first character to be an upper case, and a colon to be
followed right after the title.

If you want the text to be aligned, see the `g:file_header_align_text` option.
```vim
let g:file_header_algin_colon       = 0   " Default
```

Aligns the text so it looks nice, but not the colons that way everything is
still highlighted.

Having both `g:file_header_align_colon = 1` and `g:file_header_align_text = 1`
is the same thing as just having `g:file_header_align_colon = 1`
```vim
let g:file_header_algin_text        = 1   " Default
```

The amount of space before a colon.  This will break the highlighting of the
titles.  Read `g:file_header_align_colon` for more information.
```vim
let g:file_header_space_pre_colon   = 0   " Default
```

The amount of space after a colon.  
```vim
let g:file_header_space_post_colon  = 1   " Default
```
For some reason, even if `g:file_header_space_post_colon = 0` results in one
space being added to the end of a colon..  (I think)

Extra info to add to header.  The key needs to start with an upper case.  Do
not include the colon in either the key or value.  It will be added
automatically.
```vim
let g:file_header_extra_info        = {}  " Default
```

```vim
let g:file_header_algin_colon       = 0   " Default
let g:file_header_algin_text        = 1   " Default
let g:file_header_space_pre_colon   = 0   " Default
let g:file_header_space_post_colon  = 1   " Default
let g:file_header_extra_info        = {}  " Default

" File:         file_header.vim
" Last Change:  05/15/2019
" Maintainer:   FrancescoMagliocco

let g:file_header_algin_colon       = 0   " Default
let g:file_header_algin_text        = 1   " Default
let g:file_header_space_pre_colon   = 0   " Default
let g:file_header_space_post_colon  = 1   " Default
let g:file_header_extra_info        = { 'Foo' : 'bar' }

" File:         file_header.vim
" Last Change:  05/15/2019
" Maintainer:   FrancescoMagliocco
" Foo:          bar
```

```vim
let g:file_header_algin_colon       = 0   " Default
let g:file_header_algin_text        = 1   " Default
let g:file_header_space_pre_colon   = 0   " Default
let g:file_header_space_post_colon  = 1   " Default
let g:file_header_extra_info        = { 'Foooooooooooooooo' : 'bar' }

" File:               file_header.vim
" Last Change:        05/15/2019
" Maintainer:         FrancescoMagliocco
" Foooooooooooooooo:  bar
```
Notice that with `g:file_header_align_text = 1`, even though the key in
`g:file_header_extra_info` is longer than the other titles, everything is still
aligned.

```vim
let g:file_header_algin_colon       = 0   " Default
let g:file_header_algin_text        = 1   " Default
let g:file_header_space_pre_colon   = 0   " Default
let g:file_header_space_post_colon  = 8
let g:file_header_extra_info        = { 'Foooooooooooooooo' : 'bar' }

" File:                     file_header.vim
" Last Change:              05/15/2019
" Maintainer:               FrancescoMagliocco
" Foooooooooooooooo:        bar
```
The 8 spaces are after the longest colon.

```vim
let g:file_header_algin_colon       = 0   " Default
let g:file_header_algin_text        = 0
let g:file_header_space_pre_colon   = 5
let g:file_header_space_post_colon  = 1   " Default
let g:file_header_extra_info        = { 'Foooooooooooooooo' : 'bar' }

" File     :  file_header.vim
" Last Change     :  05/15/2019
" Maintainer     :  FrancescoMagliocco
" Foooooooooooooooo     :  bar

let g:file_header_algin_colon       = 0   " Default
let g:file_header_algin_text        = 0
let g:file_header_space_pre_colon   = 5
let g:file_header_space_post_colon  = 8
let g:file_header_extra_info        = { 'Foooooooooooooooo' : 'bar' }

" File     :        file_header.vim
" Last Change     :        05/15/2019
" Maintainer     :        FrancescoMagliocco
" Foooooooooooooooo     :        bar

let g:file_header_algin_colon       = 1
let g:file_header_algin_text        = 0
let g:file_header_space_pre_colon   = 5
let g:file_header_space_post_colon  = 1   " Default
let g:file_header_extra_info        = { 'Foooooooooooooooo' : 'bar' }

" File                  :  file_header.vim
" Last Change           :  05/15/2019
" Maintainer            :  FrancescoMagliocco
" Foooooooooooooooo     :  bar

let g:file_header_algin_colon       = 1
let g:file_header_algin_text        = 0
let g:file_header_space_pre_colon   = 5
let g:file_header_space_post_colon  = 8
let g:file_header_extra_info        = { 'Foooooooooooooooo' : 'bar' }

" File                  :        file_header.vim
" Last Change           :        05/15/2019
" Maintainer            :        FrancescoMagliocco
" Foooooooooooooooo     :        bar
```

```vim
let g:file_header_algin_colon       = 1
let g:file_header_algin_text        = 0
let g:file_header_space_pre_colon   = 0   " Default
let g:file_header_space_post_colon  = 1   " Default
let g:file_header_extra_info        = { 'Foooooooooooooooo' : 'bar' }

" File             :  file_header.vim
" Last Change      :  05/15/2019
" Maintainer       :  FrancescoMagliocco
" Foooooooooooooooo:  bar
```

This just changes the format of the date shown beside "Last Change".  You can
include the time and even milliseconds if you want to.  You just need to know
the formats.  You can checkout the formats running `man date` in a terminal.
The default provides what your locales date format is set to.
```vim
let g:file_header_modified_format   = '%x'  " Default
```

If > 0, the header will be placed on the second line, that way if you have say
a modeline on the first line, it will still be on the first line.  I have plans
to make this feature better.  Right now it's really basic.
```vim
let g:file_header_insert_mode       = 0     " Default
```

**STILL GOTTA ADD THE REST**
