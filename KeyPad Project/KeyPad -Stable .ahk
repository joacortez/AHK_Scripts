#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#Hotstring EndChars -()[]{}:;'"/\?!`n `t$_^=+
; #IfWinActive ahk_exe Notion.exe

copyClip(){
    SendInput ^{c}
    ClipWait, 1,1
    Send {right}
    return %Clipboard%
}

printVar(var){
    SendRaw, %var%
}

; ^!F1::
; Send (\vec x)
; return

; ^!F2::
; Send (x,y)
; return

; ^!F3::
; Send (x,y,z)
; return

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