#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetTitleMatchMode, 2
GroupAdd, Gr, .java - 
GroupAdd, Gr, .js - 

#IfWinActive ahk_group Gr
#Hotstring EndChars -()[]{}:;'"/\?!`n `t


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



!^#::Send {#}
return
!^v::Send |
return
!^1::Send {{}
return

+!d::
Send /**
Sleep 15
Send {enter}
return




