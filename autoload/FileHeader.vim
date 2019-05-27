" File:         FileHeader.vim
" Last Change:  05/27/2019
" Maintainer:   FrancescoMagliocco

if (exists('g:file_header_enabled') && !g:file_header_enabled)
      \ || !exists('g:loaded_file_header')
      \ || exists('g:loaded_FileHeader')
  finish
endif
let g:loaded_FileHeader = 1

let s:dict  = 
      \ {
      \   'File'        : expand(g:file_header_expand_str),
      \   'Last Change' : strftime(g:file_header_modified_format),
      \   'Author'      : g:file_header_author
      \ }

function! s:GetSection(sec, ...)
  let l:dict = 
        \ {
        \   'File'        : g:file_header_file_text,
        \   'Last Change' : g:file_header_last_change_text,
        \   'Author'      : g:file_header_author_text
        \ }
  let l:Func = function(
        \ (a:0 ? 'filter' : 'get'),
        \ [[l:dict, a:sec, a:sec], [l:dict, 'v:val ==# a:sec']][a:0])
  let l:Func = function(
        \ (a:0 ? 'keys' : 'substitute'),
        \ [[l:Func(), ':', '', 'g'], [l:Func()]][a:0])

  return l:Func()
  "return
  "return keys(filter(
  "      \ {
  "      \   'File'        : g:file_header_file_text,
  "      \   'Last Change' : g:file_header_last_change_text,
  "      \   'Author'      : g:file_header_author_text
  "      \ }, 'v:val ==# a:sec'))[0]
  "return substitute(get(
  "      \ {
  "      \   'File'        : g:file_header_file_text,
  "      \   'Last Change' : g:file_header_last_change_text,
  "      \   'Author'      : g:file_header_author_text
  "      \ }, a:sec, a:sec), ':', '', 'g')
endfunction

let s:min_lines = 3

function! s:HasHeader(...)
  " We could use a for loop and then break out of it when a match is found
  "   resulting in the whole file not being searched through.  This would
  "   probably be more efficient.
  " Not sure how I feel about how I formatted this..
  return len(filter(
        \ getline(1, !g:file_header_lines_check
        \   ? line('$')
        \   : g:file_header_lines_check < s:min_lines
        \     ? s:min_lines
        \     : g:file_header_lines_check),
        \ "v:val =~# '^.\\+\\("
        \ . g:file_header_file_text
        \ . '\|' . g:file_header_last_change_text
        \ . '\|' . g:file_header_author_text . "\\)\\s*:'"))
endfunction

function! s:GetMaxLen()
  let l:max = 0
  for l:i in extend(map(
        \ keys(s:dict), 's:GetSection(v:val)'), keys(g:file_header_extra_info))
    let l:len = len(l:i)
    if l:len <= l:max | continue | endif
    let l:max = l:len
  endfor

  return l:max
endfunction

function! FileHeader#InsertHeader()
  if s:HasHeader()
    echohl warningMsg
    echomsg 'There is already a header!'
    echomsg 'Use :UpdateHeader to update...  The header.'
    echohl None
    return
  endif

  let l:max = s:GetMaxLen() + 1
  let l:colon =
        \ repeat(' ', g:file_header_space_pre_colon) . ':'
        \ . repeat(' ', g:file_header_space_post_colon)
  let l:repeat  = "repeat(' ', l:max - len(s:GetSection(v:key))) . "
  "let l:pat     = "repeat(' ', l:max - len(v:key)) . l:colon . v:val"
  let l:pat     = 'l:colon . '
  let l:pat     =
        \ g:file_header_align_colon
        \   ? l:repeat . l:pat
        \   : g:file_header_align_text
        \     ? l:pat . l:repeat
        \     : l:pat
  let l:dict  = map(extend(
        \ {
        \   'File'        : expand(g:file_header_expand_str),
        \   'Last Change' : strftime(g:file_header_modified_format),
        \   'Author'      : g:file_header_author
        \ }, g:file_header_extra_info), 's:GetSection(v:key) . ' . l:pat . 'v:val')

  let l:comment = split(&commentstring, '%s')
  if empty(l:comment)
    echohl errorMsg
    echomsg "Can't figure out how to start a comment!"
    echomsg 'No header inserted'
    echohl None
    finish
  endif

  let l:has_end = len(l:comment) > 1
  " Because we split l:comment, l:comment is now a list even if the pattern
  "   used for the split wasn't found.  
  let l:start   = l:comment[0]
  let l:end     = ([l:has_end ? l:comment[-1] : '', ''])[0:
        \ g:file_header_line_after_header ? -1 : 0]
  let l:comment =
        \ (len(l:start) > 1 ? ' ' . strpart(l:start, 1) : l:start) . ' '

  let l:lines = map(
        \ values(l:dict),
        \ "index([l:start, l:end], v:val) >= 0 ? v:val : '"
        \   . l:comment . "' . v:val")

  if append(g:file_header_insert_mode > 0, l:has_end
        \ ? insert(add(l:lines, l:end), l:start)
        \ : g:file_header_line_after_header
        \   ? add(l:lines, '')
        \   : l:lines)
    echohl errorMsg
    echomsg 'Failed to insert header!'
    echohl None
  endif
endfunction

" FIXME All but the info provided via the g:file_header_extra_info dict will be
"   updated
function! FileHeader#UpdateHeader()
  if !s:HasHeader() || !&modified | return | endif
  
  for l:i in range(1,
        \ !g:file_header_lines_check
        \   ? line('$')
        \   : g:file_header_lines_check < s:min_lines
        \     ? s:min_lines
        \     : g:file_header_lines_check)

    let l:line = getline(l:i)
    let l:list = matchlist(
          \ l:line,
          \ '^.*\(' . escape(g:file_header_file_text, '.')
          \   . '\|' . g:file_header_last_change_text
          \   . '\|' . g:file_header_author_text . '\)\s*:\s*\(.\+$\)')
    if empty(l:list) | continue | endif
    if setline(l:i, substitute(
          \ l:line, l:list[2], s:dict[s:GetSection(l:list[1], 1)[0]], 'g'))
      echohl errorMsg
      echomsg 'Failed to update header!'
      echohl None
      break
    endif
  endfor
endfunction
