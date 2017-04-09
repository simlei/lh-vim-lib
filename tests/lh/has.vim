"=============================================================================
" File:         tests/lh/has.vim                                  {{{1
" Author:       Luc Hermitte <EMAIL:luc {dot} hermitte {at} gmail {dot} com>
"		<URL:http://github.com/LucHermitte/lh-vim-lib>
" Version:      4.0.0.
let s:k_version = '400'
" Created:      03rd Apr 2017
" Last Update:  09th Apr 2017
"------------------------------------------------------------------------
" Description:
"       Unit tests for autoload/lh/has.vim
"
"------------------------------------------------------------------------
" History:      «history»
" TODO:         «missing features»
" }}}1
"=============================================================================

UTSuite [lh-vim-lib] Testing lh#has functions

runtime autoload/lh/has.vim

let s:cpo_save=&cpo
set cpo&vim

"------------------------------------------------------------------------
" Check lh#has#patch {{{1
" Vim 7.3-429 seems to misbehave, let's tests portable lh#has#patch wrapper.
" matchlist {{{2
function! s:check_matchlist(str, major, minor, patch)
  let [all, major, minor, patch; tail] = matchlist(a:str, '\v^patch-(\d+)\.(\d+)[.-](\d+)$')
  AssertEquals(major, a:major)
  AssertEquals(minor, a:minor)
  AssertEquals(patch, a:patch)
endfunction

function! s:Test_matchlist ()
  call s:check_matchlist('patch-7.3.831', 7, 3, 831)
  call s:check_matchlist('patch-7.3-831', 7, 3, 831)
  call s:check_matchlist('patch-7.2.295', 7, 2, 295)
  call s:check_matchlist('patch-7.2-295', 7, 2, 295)
endfunction

" printf {{{2
function! s:check_printf(ver, major, minor, patch)
  let ver = eval(printf('%d%02d', a:major, a:minor))
  AssertEquals(ver, a:ver)
endfunction

function! s:Test_printf()
  call s:check_printf(703, 7, 3, 831)
  call s:check_printf(703, 7, 3, 831)
  call s:check_printf(702, 7, 2, 295)
  call s:check_printf(702, 7, 2, 295)
endfunction

" }}}1
"------------------------------------------------------------------------
let &cpo=s:cpo_save
"=============================================================================
" vim600: set fdm=marker:
