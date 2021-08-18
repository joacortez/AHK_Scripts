#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


!3::
WinGetTitle, Title, A
MsgBox, The active window is "%Title%".
return

!2::
WinGetClass, class, A
MsgBox, The active window's class is "%class%".
return

^-::MsgBox % "The active window's ID is " WinExist("A")
return

Esc::Exitapp
return