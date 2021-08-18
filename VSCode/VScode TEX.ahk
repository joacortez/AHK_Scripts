#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetTitleMatchMode, 2
GroupAdd, Gr, .tex - 

#IfWinActive ahk_group Gr
#Hotstring EndChars -()[]{}:;'"/\?!`n `t

; #Hotstring C
:c:dhh::das heißt
return
:c:zzb::zum Beispiel
return
:c:iA::im Allgemeinen
return
:c:idR::in der Regel
return

#Hotstring c ? *
::kk::
Send ^{left}
Sleep 1
Send $
Sleep 1
Send ^{right}
Send $
Send {space}
return

!^1::
Send {{}
return

^!v::
Send |
return

^!enter::
Send {esc}{end}
Sendraw \\
Send {enter}
return


