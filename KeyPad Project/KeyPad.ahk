#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#Hotstring EndChars -()[]{}:;'"/\?!`n `t$_^=+
#IfWinActive ahk_exe Notion.exe
#if (GetKeyState("NumLock","T"))

copyClip()
{
    Save := ClipboardAll, Clipboard := ""
    SendInput, {ctrl down}c{ctrl up}
    ClipWait % Wait
    Clip := Clipboard, Clipboard := Save
    Send {Right}
    Return Clip
}

printVar(var)
{
    SendRaw, %var%
}

^F9::
    temp_f9 := copyClip()
return

F9::
    printVar(temp_f9)
return

^F10::
    temp_f10 := copyClip()
return

F10::
    printVar(temp_f10)
return

^F11::
    temp_f11 := copyClip()
return

F11::
    printVar(temp_f11)
return

^F12::
    temp_f12 := copyClip()
return

F12::
    printVar(temp_f12)
return

showMsg(key)
{
    MsgBox, nombre %nombre%
}