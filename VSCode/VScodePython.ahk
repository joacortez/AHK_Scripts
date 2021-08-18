#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetTitleMatchMode, 2

GroupAdd, TitlesP, ahk_exe C:\Users\Joa Cortez\AppData\Local\Programs\Microsoft VS Code\Code.exe
GroupAdd, TitlesP, ("/\.py/")
#IfWinActive .py -  ahk_exe Code.exe
#Hotstring EndChars -()[]{}:;'"/\?!`n `t

#Hotstring c ? *
::ü::{{}

::Ü::{}}

::ö::[

::ä::]

::Ö::<

::Ä::>

::ß::->


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



