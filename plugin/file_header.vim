" File:         file_header.vim
" Last Change:  05/27/2019
" Maintainer:   FrancescoMagliocco

if exists('g:file_header_enabled') && !g:file_header_enabled
  finish
endif

if v:version < 801
  echohl errorMsg
  echomsg 'Vim needs to be atleast version 8.1 to use this plugin'
  echohl None
endif

let g:loaded_file_header            = 1
let g:file_header_enabled           = get(g:, 'file_header_enabled', 1)
let g:file_header_author            = get(
      \ g:, 'file_header_author', 'Set g:file_header_author in your .vimrc')
let g:file_header_align_colon       = get(g:, 'file_header_align_colon', 0)
let g:file_header_align_text        = get(g:, 'file_header_align_text', 1)
let g:file_header_space_pre_colon   = get(g:, 'file_header_space_pre_colon', 0)
let g:file_header_space_post_colon  = get(g:, 'file_header_space_post_colon', 1)
let g:file_header_modified_format   = get(
      \ g:, 'file_header_modified_format', '%x')

" 0 - If text is on line 1, push that text down and insert header
" 1 - If text is on line 1, put header after that text, i.e line 2
let g:file_header_insert_mode       = get(g:, 'file_header_insert_mode', 0)
let g:file_header_expand_str        = get(g:, 'file_header_expand_str', '<afile>:t')
let g:file_header_author_text       = get(
      \ g:, 'file_header_author_text', 'Maintainer')
let g:file_header_file_text         = get(g:, 'file_header_file_text', 'File')
let g:file_header_last_change_text  = get(
      \ g:, 'file_header_last_change_text', 'Last Change')
let g:file_header_extra_info        = get(g:, 'file_header_extra_info', {})
let g:file_header_line_after_header = get(
      \ g:, 'file_header_line_after_header', 1)

" 0 Means all lines
" Min is 3
let g:file_header_lines_check       = get(g:, 'file_header_lines_check', 10)

command! InsertHeader call FileHeader#InsertHeader()
command! UpdateHeader call FileHeader#UpdateHeader()

augroup file_header
  autocmd!
  autocmd BufWrite * call FileHeader#UpdateHeader()
augroup END
