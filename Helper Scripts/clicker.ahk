#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.



Esc::
mloop = 1 ; Tell the ^!z Loop to stop
Exitapp
return

f::
Loop, 400
{
  Sleep, 10
  MouseClick, left, , , 1
  Send {Del}
  if mloop = 1
  {
    mloop = 0
    break
  }
}
return