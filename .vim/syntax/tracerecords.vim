
" Vim syntax file for browsing aplog files
" copyright (C) 2012, sebastien michel <sebastien.michel@intel.com>


if exists("b:current_syntax")
 finish
endif

syn match aplogDelimit '4cb49ba8[[:space:]]*\(Start\|End\)'
syn match aplogActivity 'SCREEN_ON\|ScreenOnOffReceiver !!!'
syn match aplogTrace 'processNextBroadcast'
syn match aplogThread '^\([[:digit:]]\+[[:space:]]\+\)\{3\}\<18\>'
syn match aplogIntent 'Process cur broadcast\|processNextBroadcast: .* broadcasts, .* ordered broadcasts'
syn match aplogAnr '\(am_anr\|ANR\|DebugAnr\|commitText on inactive InputConnection\)'
syn match aplogFailure 'am_failed_to_pause\|NOT RESPONDING\|Application is not responding\|Input event dispatching timed out\|Process : Sending signal\|binder: [[:digit:]]*:[[:digit:]]* transaction failed [[:digit:]]*'
syn match aplogCalltrace 'Call Trace\|FATAL EXCEPTION\|KERNEL  : .* send sigkill\|am_proc_died\|WIN DEATH'
syn match aplogTimeout 'updateLights: delaying screen on due to notification queue\|Cancelling BROADCAST_TIMEOUT_MSG'
syn match aplogDataFilename '^\.\/.*[^/]$'
syn match aplogSymlink '^\.\/.* -> .*$' contains=aplogSymlinkTarget,aplogSymlinkArrow,aplogSymlinkName
syn match aplogSymlinkName '^\S*' contained
syn match aplogSymlinkTarget '\S*$' contained
syn match aplogSymlinkArrow '->' contained


hi def link aplogActivity   Function
hi def link aplogThread    Label
hi def link aplogIntent     Macro
hi def link aplogAnr	    Error
hi def link aplogFailure	Error
hi def link aplogCalltrace	Error
hi def link aplogComment	Comment
hi def link aplogDelimit	PmenuSel
hi def link aplogTimeout    Label
hi def link aplogTrace      Constant
hi def link aplogDataFilename  PreProc
hi def link aplogSymlinkName   Identifier
hi def link aplogSymlinkTarget PreProc
"set iskeyword=@,.,/,48-57,_,192-255
set tabstop=12
set nowrap
Fp ^[[:digit:]]\+[[:space:]]\+[[:digit:]]\+[[:space:]]\+[[:digit:]]\{4\}[[:digit:]]\+[[:space:]]\+
