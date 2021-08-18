#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetTitleMatchMode, 2
GroupAdd, Gr, .c - 
GroupAdd, Gr, .ino - 


#IfWinActive ahk_group Gr ahk_exe Code.exe
#Hotstring EndChars -()[]{}:;'"/\?!`n `t

; !^p::Send {End}{;}!{Enter}
; return
; !^g::Send >
; return
; !^l::Send <
; return
; !^o::Send |
; return

#Hotstring c ? *
::ü::{{}
return
::Ü::{esc}{End}{{}{enter}
return

::ö::[
return
::ä::]
return

::Ö::<
return
::Ä::>
return

::#::{esc}{end}{;}{enter}
return

::ß::->
return

::ppoi::->
return

::iinncc::{#}include <>{left}
return


!^#::Send {#}
return

^!v::Send |
return

^!1::Send {{}
return

+!d::
Send /**{enter}
return


