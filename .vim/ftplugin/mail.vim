" set fileencoding=utf-8
set nohlsearch
"permet de faire des lignes de 60 caracteres
set tw=60
" pas de fold dans les mails par defaut.
set foldmethod=manual
" enlever les commentaires
set comments+=n:\|
"autocmd BufRead .followup,.article*,.letter,/tmp/mutt*,*.txt,.signature*,signature* set comments=fs1:/*,mb:*,ex:*/,://,b:#,:%,:XCOMM,n:>,fb:-,n:\|

set noautoindent

" pour insert le followup automatiquement.
nnoremap ;fu /Newsgroups<CR>wlDp/Followup-To:<CR>/: <CR>plD
"pour aller au debut du message
nnoremap ;vide gg<CR>/^$<CR>
" nnoremap ;par ;vide<CR>:.,$normal vgq<CR>
" nnoremap ;par :exec '.,$g/^.\{'.&tw.'\}.\+$/normal V)gq'<CR>
" /^.\{75\}.\+$<CR>v/\.$<CR>gqj


nnoremap ;é :silent! %s//é/g<CR>
nnoremap ;' :silent! %s//'/g<CR>
nnoremap ;oe :silent! %s//oe/g<CR>
nnoremap ;MM :silent! %s/\r//g<CR>gg
nnoremap ;redu  :silent! %s/\(^[> ]\+\)\(\n^[> ]\+$\)\+/\1/<CR>
nnoremap ;rmsig G:silent! /^>[> ]*-- $<CR>:.,$g/^>[> ]*/d<CR>
nnoremap ;rmyahoo G:silent! /^>[> ]*=====$<CR>:.,$g/^>[> ]*/d<CR>
" pour elever le reste des quotes
nnoremap <C-S> :.,$g/^>[ >]\?/d<CR>i
"pour aller a la prochaine quote vide.
" autocmd BufRead .followup,.article*,.letter,/tmp/mutt* map! <C-S> <ESC>md/^\(>[ >]\+\\|\)$<CR>C
map! <C-S> <ESC>j/^\(>[ >]*\\|\)$<CR>C
map! <C-T> <esc>g`da

vnoremap <buffer> ;snip dO> [snip]<Esc>
vnoremap <buffer> ;... dO> [...]<Esc>

" signatures.
" efface la signature courante
nnoremap ;sig  mS/^-- $<CR>V}c-- <esc>:r!~/bin/signature.pl<CR>`S
nnoremap ;cord mS/^-- $<CR>V}c-- <CR>Cordialement,<CR>    Sébastien MICHEL<ESC>`Sl
nnoremap ;ami mS/^-- $<CR>V}c-- <CR>Amicalement,<CR>    Sébastien MICHEL<ESC>`Sl
nnoremap ;amap mS/^From: <CR>:s/^From: .*/From: Sebastien MICHEL <amap@falguerolles.org>/<CR>/^-- $<CR>V}c-- <CR>Amapement,<CR>    Sébastien MICHEL<CR>AMAP Casso Lebres - Arcs St Cyprien<ESC>`Sl
nnoremap ;talc mS/^-- $<CR>V}c-- <ESC>:r ~/.signature.cord<CR>`Sl
nnoremap ;rega mS/^-- $<CR>V}c-- <CR>Regards,<CR>    Sébastien MICHEL<ESC>`Sl
nnoremap ;salu mS/^-- $<CR>V}c-- <CR>Dans l'attente de votre réponse je vous prie d'agréer mes salutations distinguées,<CR>    Sébastien MICHEL<ESC>`Sl
inoremap ;sig	<esc>;sig
inoremap ;amap	<esc>;amap
noremap! ;rega	<esc>;rega
noremap! ;salu	<esc>;salu
noremap! ;cord	<esc>;cord
noremap! ;amap	<esc>;amap
noremap! ;talc	<esc>;talc
nnoremap ;cv :normal i;cv<cr>
nnoremap ;was gg/^Subject<CR>2wi[was: <ESC><END>a ]<ESC>0wli 
nnoremap ;tip gg/^Subject<CR>2wi[tip] <ESC>:normal ;vide<CR>
noremap! ;cv Vous trouverez mon CV au format html attaché à ce mail ainsi que sur mon site web: http://michoux.born2frag.org/CV/

