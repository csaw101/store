let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd ~/code/scandiweb/test-app
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
let s:shortmess_save = &shortmess
if &shortmess =~ 'A'
  set shortmess=aoOA
else
  set shortmess=aoO
endif
badd +1 ~/code/scandiweb/test-app/src/App.js
badd +119 ~/code/scandiweb/test-app/src/components/Product.js
badd +57 ~/code/scandiweb/test-app/src/components/Products.js
badd +81 ~/code/scandiweb/test-app/src/components/Cart.js
badd +17 ~/code/scandiweb/test-app/src/components/CartProduct.js
badd +23 src/styles/Sizes.css
badd +24 src/components/Sizes.js
badd +22 src/components/Colors.js
badd +24 ~/code/scandiweb/test-app/src/styles/CartProduct.css
argglobal
%argdel
tabnew +setlocal\ bufhidden=wipe
tabnew +setlocal\ bufhidden=wipe
tabrewind
edit ~/code/scandiweb/test-app/src/components/Products.js
let s:save_splitbelow = &splitbelow
let s:save_splitright = &splitright
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd w
wincmd _ | wincmd |
split
1wincmd k
wincmd w
let &splitbelow = s:save_splitbelow
let &splitright = s:save_splitright
wincmd t
let s:save_winminheight = &winminheight
let s:save_winminwidth = &winminwidth
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
exe 'vert 1resize ' . ((&columns * 85 + 86) / 172)
exe '2resize ' . ((&lines * 20 + 22) / 44)
exe 'vert 2resize ' . ((&columns * 86 + 86) / 172)
exe '3resize ' . ((&lines * 20 + 22) / 44)
exe 'vert 3resize ' . ((&columns * 86 + 86) / 172)
argglobal
balt ~/code/scandiweb/test-app/src/components/Product.js
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let &fdl = &fdl
let s:l = 51 - ((29 * winheight(0) + 20) / 41)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 51
normal! 039|
wincmd w
argglobal
if bufexists(fnamemodify("src/components/Sizes.js", ":p")) | buffer src/components/Sizes.js | else | edit src/components/Sizes.js | endif
if &buftype ==# 'terminal'
  silent file src/components/Sizes.js
endif
balt src/components/Colors.js
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let &fdl = &fdl
let s:l = 13 - ((12 * winheight(0) + 10) / 20)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 13
normal! 042|
wincmd w
argglobal
if bufexists(fnamemodify("src/components/Colors.js", ":p")) | buffer src/components/Colors.js | else | edit src/components/Colors.js | endif
if &buftype ==# 'terminal'
  silent file src/components/Colors.js
endif
balt src/components/Sizes.js
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let &fdl = &fdl
let s:l = 16 - ((7 * winheight(0) + 10) / 20)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 16
normal! 020|
wincmd w
exe 'vert 1resize ' . ((&columns * 85 + 86) / 172)
exe '2resize ' . ((&lines * 20 + 22) / 44)
exe 'vert 2resize ' . ((&columns * 86 + 86) / 172)
exe '3resize ' . ((&lines * 20 + 22) / 44)
exe 'vert 3resize ' . ((&columns * 86 + 86) / 172)
tabnext
edit ~/code/scandiweb/test-app/src/components/Cart.js
let s:save_splitbelow = &splitbelow
let s:save_splitright = &splitright
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd w
let &splitbelow = s:save_splitbelow
let &splitright = s:save_splitright
wincmd t
let s:save_winminheight = &winminheight
let s:save_winminwidth = &winminwidth
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
exe 'vert 1resize ' . ((&columns * 85 + 86) / 172)
exe 'vert 2resize ' . ((&columns * 86 + 86) / 172)
argglobal
balt ~/code/scandiweb/test-app/src/components/CartProduct.js
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let &fdl = &fdl
let s:l = 87 - ((21 * winheight(0) + 20) / 41)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 87
normal! 023|
wincmd w
argglobal
if bufexists(fnamemodify("~/code/scandiweb/test-app/src/components/CartProduct.js", ":p")) | buffer ~/code/scandiweb/test-app/src/components/CartProduct.js | else | edit ~/code/scandiweb/test-app/src/components/CartProduct.js | endif
if &buftype ==# 'terminal'
  silent file ~/code/scandiweb/test-app/src/components/CartProduct.js
endif
balt ~/code/scandiweb/test-app/src/components/Cart.js
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let &fdl = &fdl
let s:l = 22 - ((10 * winheight(0) + 20) / 41)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 22
normal! 019|
wincmd w
exe 'vert 1resize ' . ((&columns * 85 + 86) / 172)
exe 'vert 2resize ' . ((&columns * 86 + 86) / 172)
tabnext
edit ~/code/scandiweb/test-app/src/styles/CartProduct.css
argglobal
balt src/styles/Sizes.css
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let &fdl = &fdl
let s:l = 24 - ((23 * winheight(0) + 20) / 41)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 24
normal! 06|
tabnext 1
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0 && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20
let &shortmess = s:shortmess_save
let s:sx = expand("<sfile>:p:r")."x.vim"
if filereadable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &g:so = s:so_save | let &g:siso = s:siso_save
set hlsearch
nohlsearch
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
