#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#Hotstring EndChars -()[]{}:;'"/\?!`n `t$_^=+
#IfWinActive ahk_exe Notion.exe
; #if (GetKeyState("NumLock","T"))

save_section := "vars"
config_file_name := "C:\Users\joaco\Desktop\keypad_config.ini"

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


; load variables
IniRead, temp_f9, %config_file_name%, %save_section%, f9
IniRead, temp_f10, %config_file_name%, %save_section%, f10
IniRead, temp_f11, %config_file_name%, %save_section%, f11
IniRead, temp_f12, %config_file_name%, %save_section%, f12



^F9::
    temp_f9 := copyClip()
    IniWrite, %temp_f9%, %config_file_name%, %save_section%, f9
return

F9::
    printVar(temp_f9)
return

^F10::
    temp_f10 := copyClip()
    IniWrite, %temp_f10%, %config_file_name%, %save_section%, f10
return

F10::
    printVar(temp_f10)
return

^F11::
    temp_f11 := copyClip()
    IniWrite, %temp_f11%, %config_file_name%, %save_section%, f11
return

F11::
    printVar(temp_f11)
return

^F12::
    temp_f12 := copyClip()
    IniWrite, %temp_f12%, %config_file_name%, %save_section%, f12
return

F12::
    printVar(temp_f12)
return

showMsg(key)
{
    MsgBox, nombre %nombre%
}