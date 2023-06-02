#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetTitleMatchMode, 2
GroupAdd, Gr, Visual Studio Code

; #IfWinActive ahk_group Gr
#IfWinActive ahk_group Gr ahk_exe Code.exe
#Hotstring EndChars -()[]{}:;'"/\?!`n `t

#Hotstring c ? *
:*?c:ü::{{}   
Return
; ::ü::{{}

::Ü::{}}
Return

::ö::[
Return

::ä::]
Return

::Ö::<
Return

::Ä::>
Return

; !^#::
; Send {#}
; return

; ü::
;     Send {{}
; Return

; +U::
;     Send {}}
; Return

^!v::
Send |
return

^!1::
Send {{}
return

CapsLock::
    Send {Esc}
Return