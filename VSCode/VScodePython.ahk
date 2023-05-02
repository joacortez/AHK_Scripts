#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetTitleMatchMode, 2

; GroupAdd, TitlesP, ahk_exe C:\Users\Joa Cortez\AppData\Local\Programs\Microsoft VS Code\Code.exe
; GroupAdd, TitlesP, ("/\.py/")
; #IfWinActive .py -  ahk_exe Code.exe

GroupAdd, Gr, .py  
GroupAdd, Gr, Interactive
#IfWinActive ahk_group Gr ahk_exe Code.exe

#Hotstring EndChars -()[]{}:;'"/\?!`n `t

#Hotstring c ? *
::ü::{{}
return
; ::Ü::{esc}{End}{{}{enter}
::Ü::{End}{{}{enter}
return

::ö::[
return
::ä::]
return

::Ö::<
return
::Ä::>
return
::ß::{end} ->{space}


::#::{end}{:}{enter}
return

::sse.::self.

!^#::
Send {#}
return

^!v::
Send |
return

^!1::
Send {{}
return



