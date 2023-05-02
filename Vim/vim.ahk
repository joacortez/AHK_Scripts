#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetTitleMatchMode, 2


; ; Browsers
; GroupAdd, WinTestBrowser, ahk_exe chrome.exe
; GroupAdd, WinTestBrowser, ahk_exe opera.exe
; GroupAdd, WinTestBrowser, ahk_exe msedge.exe
; GroupAdd, WinTextBrowser, ahk_exe Todo.exe

; All windows

GroupAdd, WinTest, ahk_exe chrome.exe
GroupAdd, WinTest, ahk_exe opera.exe
GroupAdd, WinTest, ahk_exe msedge.exe
GroupAdd, WinTest, ahk_exe Notion.exe
GroupAdd, WinText, ahk_exe Todo.exe
GroupAdd, WinText, ahk_exe PowerToys.PowerLauncher.exe

GroupAdd, basic, ahk_exe Cron.exe
GroupAdd, basic, ahk_exe Stashpad.exe

; #If True

; VarSetCapacity(APPBARDATA, A_PtrSize=4 ? 36:48)
; #b::
;    NumPut(DllCall("Shell32\SHAppBarMessage", "UInt", 4 ; ABM_GETSTATE
;                                            , "Ptr", &APPBARDATA
;                                            , "Int")
;  ? 2:1, APPBARDATA, A_PtrSize=4 ? 32:40) ; 2 - ABS_ALWAYSONTOP, 1 - ABS_AUTOHIDE
;  , DllCall("Shell32\SHAppBarMessage", "UInt", 10 ; ABM_SETSTATE
;                                     , "Ptr", &APPBARDATA)
;    KeyWait, % A_ThisHotkey
;    Return

#If 
#IfWinActive ahk_group WinTest

modifiers_match_list := "{Enter}{Del}{BackSpace}{Esc}{Tab}{Up}{Down}{Right}{Home}{End}{PgUp}{PgDn}"
; modifiers_match_list := "{Enter}{Ctrl}{Shift}{Del}{BackSpace}{Esc}{Tab}{Up}{Down}{Left}{Right}{Home}{End}{PgUp}{PgDn}"
singlechar_match_list := "a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,x,y,z,ö,ä,ü,!,§,$,&,/,(,),=,?,+,#,-,_,.,:,,°,^,<,>,{,}"
; singlechar_match_list := "a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q, r, s, t, u, v, x, y, z, ö, ä, ü, !, §, $, &, /, (, ), =, ?, +, #, -, _, ., :, , °, ^, <, >, {, }"

; match lists for normal mode
normal_mode_match_list := "w, W, b, B, t, T, f, F"
; modifiers_match_list := "{Enter}{Ctrl}{Shift}{Del}{BackSpace}{Esc}{Tab}{Up}{Down}{Left}{Right}{Home}{End}{PgUp}{PgDn}"
input_options :=  "B C E"

; global insertModeCode = 1 << 0
global insertModeCode = 0
global normalModeCode = 1 << 1
global visualModeCode = 1 << 2
global changeModeCode = 1 << 3
global yankModeCode = 1 << 4
global deleteModeCode = 1 << 5
global innerModeCode = 1 << 6
global outerModeCode = 1 << 7

global currMode := insertModeCode

; toggles autohide feature of the taskbar on windows 11
toggleTaskbar()
{
    VarSetCapacity(APPBARDATA, A_PtrSize=4 ? 36:48)
    NumPut(DllCall("Shell32\SHAppBarMessage", "UInt", 4 ; ABM_GETSTATE
                                            , "Ptr", &APPBARDATA
                                            , "Int")
    ? 2:1, APPBARDATA, A_PtrSize=4 ? 32:40) ; 2 - ABS_ALWAYSONTOP, 1 - ABS_AUTOHIDE
    , DllCall("Shell32\SHAppBarMessage", "UInt", 10 ; ABM_SETSTATE
                                        , "Ptr", &APPBARDATA)
    KeyWait, % A_ThisHotkey
    Return
}

check_normal_mode()
{
    ; return (WinActive("ahk_group WinTest") and ((isInNormalMode == True) and (isInChangeMode != True) and (isInYankMode != True) and (isInVisualMode != True) and (isInDeleteMode != True)))
    return (WinActive("ahk_group WinTest") and ( currMode == normalModeCode))
    ; return (WinActive("ahk_group WinTest") and ( currMode != insertModeCode))
}

check_change_mode()
{
    ; return (WinActive("ahk_group WinTest") and ((isInNormalMode == True) and (isInChangeMode == True) and (isInYankMode != True) and (isInVisualMode != True) and (isInDeleteMode != True)))
    return (WinActive("ahk_group WinTest") and ( currMode == (changeModeCode | normalModeCode)))
}

check_yank_mode()
{
    ; return (WinActive("ahk_group WinTest") and ((isInNormalMode ==  True) and (isInChangeMode != True) and (isInYankMode == True) and (isInVisualMode != True) and (isInDeleteMode != True)))
    return (WinActive("ahk_group WinTest") and ( currMode == (yankModeCode | normalModeCode)))
}
check_visual_mode()
{
    ; return (WinActive("ahk_group WinTest") and ((isInNormalMode == True) and (isInChangeMode != True) and (isInYankMode != True) and (isInVisualMode == True) and (isInDeleteMode != True)))
    return (WinActive("ahk_group WinTest") and ( currMode == (visualModeCode | normalModeCode)))
}

check_delete_mode()
{
    ; return (WinActive("ahk_group WinTest") and ((isInNormalMode == True) and (isInChangeMode != True) and (isInYankMode != True) and (isInVisualMode != True) and (isInDeleteMode == True)))
    return (WinActive("ahk_group WinTest") and ( currMode == (deleteModeCode | normalModeCode)))
}

check_insert_mode()
{
    ; return (WinActive("ahk_group WinTest") and ((isInNormalMode != True) and (isInChangeMode != True) and (isInYankMode != True) and (isInVisualMode != True) and (isInDeleteMode != True)))
    return (WinActive("ahk_group WinTest") and ( currMode == insertModeCode))
}

check_inner_mode()
{
    return (WinActive("ahk_group WinTest") and ( currMode & innerModeCode))
}

check_outer_mode()
{
    return (WinActive("ahk_group WinTest") and ( currMode & outerModeCode))
}

change_to_normal_mode()
{
    global
    currMode := normalModeCode
}

change_to_change_mode()
{
    global
    currMode := normalModeCode
    currMode |= changeModeCode

    Return
}

change_to_yank_mode()
{
    global
    currMode := normalModeCode
    currMode |= yankModeCode

    Return
}

change_to_visual_mode()
{
    global
    currMode := normalModeCode
    currMode |= visualModeCode

    Return
}

change_to_delete_mode()
{
    global
    currMode = normalModeCode
    currMode |= deleteModeCode

    Return
}

change_to_insert_mode()
{
    global
    currMode := insertModeCode

    Return
}

change_to_inner_mode()
{
    global
    currMode |= innerModeCode

    Return
}

change_to_outer_mode()
{
    global
    currMode |= outerModeCode

    Return
}

change_out_inner_mode()
{
    global
    currMode &= ~innerModeCode

    Return
}

change_out_outer_mode()
{
    global
    currMode &= ~outerModeCode

    Return
}

; Functions
; vim implementation

nav_to_top()
{
    Send ^{Home}
    Return
}

nav_to_bottom()
{
    Send ^{End}
    Return
}

nav_to_EOL()
{
    Send {End}
    Return
}

nav_to_SOL()
{
    Send {Home}
    Return
}

highlight_until_EOL()
{
    Send +{End}
    return
}

highlight_until_SOL()
{
    Send +{Home}
    return
}

nav_to_prev_char(include)
{
    if (highlight_to_prev_char(include)) {
        Send {Left}
    }
}

nav_to_next_char(include)
{
    if (highlight_to_next_char(include)) {
        Send {Right}
    }
}

change_to_prev_char(include)
{
    if (highlight_to_prev_char(include)) {
        Send ^{x}
        change_to_insert_mode()
    }
}

change_to_next_char(include)
{
    if (highlight_to_next_char(include)) {
        Send ^{x}
        change_to_insert_mode()
    }
}

yank_to_next_char(include)
{
    if (highlight_to_next_char(include)) {
        Send ^{c}{Left}
        change_to_normal_mode()
    }
}

yank_to_prev_char(include)
{
    if (highlight_to_prev_char(include)) {
        Send ^{c}{Right}
        change_to_normal_mode()
    }
}

del_to_prev_char(include)
{
    if (highlight_to_prev_char(include)) {
        Send {Del}
        change_to_normal_mode()
    }
}

del_to_next_char(include)
{
    if (highlight_to_next_char(include)) {
        Send {Del}
        change_to_normal_mode()
    }
}

highlight_to_prev_char(include)
{
    ; FIXME select nearst char to string start not curr cursor position 
    ; TODO invert string to select nearest instance of char
    global
    ; isInNormalMode := False

    backup_mode := currMode
    
    ; currMode &= ~normalModeCode
    currMode := insertModeCode
    
    Input curr_char, B C L1 E, %modifiers_match_list%, %singlechar_match_list%
    backup := Clipboard
    Clipboard := ""
    ; copy until SOL
    highlight_until_SOL()
    Send ^c
    ClipWait
    
    sleep 10
    len := StrLen(Clipboard)
    index := InStr(Clipboard, curr_char, true)
    if (index != 0) {
        
        if (include == false) {
            index--
        }
        Send +{Right %index%}
        
        Clipboard := backup
        ; isInNormalMode := True
        ; currMode |= normalModeCode
        currMode := backup_mode
        Return True
    }else {
        ; Send {Right %len%}
        Send {Right}
    }
    
    Clipboard := backup
    ; isInNormalMode := True
    ; currMode |= normalModeCode
    currMode := backup_mode
    return False
}

highlight_to_next_char(include)
{
    global
    ; isInNormalMode := False
    ; currMode &= ~normalModeCode

    back_mode := currMode
    currMode := insertModeCode
    
    Input curr_char, B C L1 E, %modifiers_match_list%, %singlechar_match_list%
    ; Input, curr_char, L1, {LControl}{RControl}{LAlt}{RAlt}{LShift}{RShift}{LWin}{RWin}{AppsKey}{F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Left}{Right}{Up}{Down}{Home}{End}{PgUp}{PgDn}{Del}{Ins}{BS}{CapsLock}{NumLock}{PrintScreen}{Pause}

    backup := Clipboard
    Clipboard := ""
    ; copy until EOL
    highlight_until_EOL()
    Send ^c
    Send {Left}
    ClipWait
    
    sleep 10
    index := InStr(Clipboard, curr_char, true)
    if (index != 0) {
        if (include == true) {
            index--
        }
        Send +{Right %index%}
        
        Clipboard := backup
        ; isInNormalMode := True
        ; currMode |= normalModeCode
        currMode := backup_mode
        Return True
    }
    
    Clipboard := backup
    ; isInNormalMode := True
    ; currMode |= normalModeCode
    currMode := backup_mode
    Return False
}

save_spot()
{
    global spot
    backup := Clipboard
    Send +{End}
    Send ^c
    ClipWait
    
    StringLen, spot, Clipboard
    
    Send {Left}
    
    Clipboard := backup
    return
}


capitalize_words()
{
    backup := Clipboard

    Clipboard := ""                          ;Clear the clipboard
    Send ^{c}                                ;Select+Copy all text
    ClipWait                               ;Wait for clipboard
    formatted_text :=% Format("{:T}",Clipboard)  ;Format to Title Case
    Send %formatted_text%                                ;Paste over selected

    Clipboard := backup
Return
}

dec2bin(x)
{
    while x
		r:=1&x r,x>>=1

	return r
}

bin2dec(x)
{
    b:=StrLen(x),r:=0
	loop,parse,x
		r|=A_LoopField<<--b

	return r
}


find_number_forward(offset)
{
    backup := Clipboard
    Clipboard := ""

    highlight_until_EOL()
    Send ^{c}
    Clipwait
    Send {Left}

    position := RegExMatch(ClipBoard, "O)(((0b)?[0-9]+)|0x[A-F,0-9]+)\b", Match) - 1
    ; position := RegExMatch(ClipBoard, "O)\b(((0b)?[0-9]+)|0x[A-F,0-9]+)\b", Match) - 1

    Clipboard := backup

    ; no number found
    if (position < 0)
    {
        Return
    }

    ; move to numbor position
    Send {Right %position%}

    ; hexadecimial number
    if InStr(Match.0, "0x")
    {
        Send {Right 2}

        ; num := Format("{:X}", SubStr(Match.0, 3) + offset)
        num := Format("{:X}", Match.0 + offset)
        position := Match.Len() - 2

        Send +{Right %position%}

        Send %num%

        position := StrLen(num) + 2
        Send {Left %position%}
    }else 
    
    ; binary number
    if InStr(Match.0, "0b")
    {
        Send {Right 2}

        num := bin2dec(SubStr(Match.0, 3)) + offset
        num := dec2bin(num)
        
        position := Match.Len() - 2

        Send +{Right %position%}

        Send %num%
        position := StrLen(num) + 2
        Send {Left %position%}
    }
    else 
    {
        num := Match.0 + offset
        position := Match.Len()

        Send +{Right %position%}

        Send %num%

        position := StrLen(num)

        Send {Left %position%}
    }


    Return
}


move_left()
{
    Send {Left}
    Send +{Left}

    Return
}

move_right()
{
    Send {Right}
    Send +{Right}

    Return
}
^!Esc::
    if (check_normal_mode()) {
        MsgBox % "normal_mode"
    ; Return
}

else if (check_change_mode()) {
    MsgBox % "change_mode"
    ; Return
}

else if (check_yank_mode()) {
    MsgBox % "yank_mode"
    ; Return
}

else if (check_insert_mode()) {
    MsgBox % "insert_mode"
    ; Return
} else if (check_visual_mode()) {
    MsgBox % "visual_mode"
    ; Return
} else if (check_delete_mode()) {
    MsgBox % "delete_mode"
    ; Return
}
else if (check_inner_mode()){
    MsgBox % "inner_mode"
}
else if (check_outer_mode()){
    MsgBox % "outer_mode"
}

MsgBox, current mode is %currMode% 
Return

; Normal mode
#If
#if check_normal_mode()

; STUB block navigation for Notion
^+j::
    Send ^+{Down}
Return

^+k::
    Send ^+{Up}
Return
    
j::
    Send {Down}
Return

k::
    Send {Up}
Return

l::
    ; move_right()
    Send {Right}
Return

h::
    ; move_left()
    Send {Left}
Return

w::
    Send ^{Right}
return

b::
    Send ^{Left}
Return

0::
    Send {Home}
Return

$::
    Send {End}
Return

; STUB only one keystroke works
g::
    nav_to_top()
Return

+G::
    nav_to_bottom()
Return

t::
    nav_to_next_char(true)
return

+T::
    nav_to_prev_char(true)
return

f::
    nav_to_next_char(False)
return

+F::
    nav_to_prev_char(False)
return

p::
    SendRaw %Clipboard%
Return

u::
    Send ^{z}
Return

^R::
    Send ^{y}
Return

m::
    Send $$
    change_to_insert_mode()
Return

; NOTE moved to normal section
; i::
;     ; Send {Left} 
;     change_to_insert_mode()
; Return

; +I::
;     Send {Home}
;     change_to_insert_mode()
; Return

a::
    Send {Right}
    change_to_insert_mode()
Return

; +A::
;     Send {End}
;     change_to_insert_mode()
; Return

c::
    change_to_change_mode()
Return

v::
    change_to_visual_mode()
Return

; Select block in Notoin
+V::
    Send {Esc}
    change_to_visual_mode()
Return

y::
    change_to_yank_mode()
Return

d::
    change_to_delete_mode()
Return

^a::
    find_number_forward(1)
Return

^x::
    find_number_forward(-1)
Return

; STUB for moving in screen
z::
    Send {PgDn}
Return

; change mode
#If
#if check_change_mode()
; STUB

i::
    change_to_inner_mode()
Return    
    
a::
    change_to_outer_mode()
Return
    
w::
    Send ^+{Right}
    Send ^{x}
    change_to_insert_mode()
Return

b::
    Send ^+{Left}
    Send ^{x}
    change_to_insert_mode()
Return

c::
    Send {Home}+{End}^{x}
    
    change_to_insert_mode()
Return

0::
    Send +{Home}
    Send ^{x}
    change_to_insert_mode()
Return

$::
    Send +{End}
    Send ^{x}
    change_to_insert_mode()
Return

t::
    change_to_next_char(true)
Return

+T::
    change_to_prev_char(true)
Return

f::
    change_to_next_char(false)
Return

+F::
    change_to_prev_char(false)
Return

CapsLock::
    change_to_normal_mode()
Return

; yank mode
#If
#if check_yank_mode()
; STUB
i::
    change_to_inner_mode()
Return

a::
    change_to_outer_mode()
Return
    
y::
    Clipboard := ""
    ; Send +{End}
    ; Send ^c
    ; ClipWait
    
    ; spot := StrLen(Clipboard)
    
    Send {End}
    Send +{Home}
    Send ^{c}{End}
    ; Send {Left %spot%}
    ClipWait
    
    change_to_normal_mode()
Return

w::
    Send +^{Right}
    Send ^{c}{Left}
    change_to_normal_mode()
Return

b::
    Send +^{Left}
    Send ^{c}{Right}
    change_to_normal_mode()
Return

0::
    Send +{Home}
    Send ^{c}{Home}
    change_to_normal_mode()
Return

$::
    Send +{End}
    Send ^{c}{End}
    change_to_normal_mode()
Return

t::
    yank_to_next_char(true)
    change_to_normal_mode()
Return

+T::
    yank_to_prev_char(true)
    change_to_normal_mode()
Return

f::
    yank_to_next_char(False)
    change_to_normal_mode()
Return

+F::
    yank_to_prev_char(False)
    change_to_normal_mode()
Return

CapsLock::
    change_to_normal_mode()
Return

; visual Mode
#If
#if check_visual_mode()
; STUB
i::
    change_to_inner_mode()
    ; Send ^{Left}^+{Right}
Return

a::
    change_to_outer_mode()
Return

; STUB for notion
^+m::   
    Send  ^+{m}
    change_to_insert_mode()
Return

; STUB for notion
^+e::
    Send ^+{e}
Return

; STUB for notion
^e::
    Send ^{e}
Return

; Stub for notion
^+h::
    Send ^+{H}
Return

; STUB for notion
z::
    capitalize_words()
Return  

; STUB for notion
^b::
    Send ^{b}
Return

; STUB for notion
^j::
    Send ^{j}
    change_to_insert_mode()
Return

; STUB block navigation for notion
^+j::
    Send ^+{down}
return

^+k::
    Send ^+{up}
return

j::
    Send +{Down}
Return

k::
    Send +{Up}
Return

l::
    ; move_right()
    Send +{Right}
Return

h::
    ; move_left()
    Send +{Left}
Return

v::
    Send {Home}
    Send +{End}
Return

w::
    Send +^{Right}
Return

b::
    Send +^{Left}
Return

0::
    Send +{Home}
    change_to_normal_mode()
Return

$::
    Send +{End}
    change_to_normal_mode()
Return

t::
    highlight_to_next_char(true)
return

+T::
    highlight_to_prev_char(true)
return

f::
    highlight_to_next_char(False)
return

+F::
    highlight_to_prev_char(False)
return

y::
    Send ^{c}
    change_to_normal_mode()
Return

; !!!!!!
d::
; TODO change d to cut not delete
    ; Send {Del}
    Send ^{x}
    change_to_normal_mode()
Return

c::
    Send ^{x}
    change_to_insert_mode()
Return

p::
    Send %Clipboard%
Return

CapsLock::
    change_to_normal_mode()
Return

; add parenthesis and stuff

surround_selection(opener, closer)
{   
    backup := Clipboard
    Clipboard := ""
    
    Send ^{c}
    ClipWait
    len := StrLen(Clipboard)

    Send {Left}%opener%{Right %len%}%closer%
    

    Clipboard := backup

    return
}

(::
)::
8::
9::
    surround_selection("(", ")")
    change_to_insert_mode()
Return

{::
}::
7::
    surround_selection("{{}", "{}}")
    ; surround_selection("u", "o")
    change_to_insert_mode()
Return

[::
]::
ö::
ä::
    surround_selection("[","]")
    change_to_insert_mode()
Return

"::
2::
q::
    surround_selection("""", """")
    change_to_insert_mode()
Return

<::
>::
+Ö::
+Ä::
    surround_selection("<", ">")
    check_insert_mode()
Return

; +::
;     surround_selection("**", "**")
;     change_to_insert_mode()
; Return

m::
4::
    surround_selection("$$", "$$")
    change_to_insert_mode()
Return
; delete mode
#If
#if check_delete_mode()
    
d::
    Send {Home}
    Send +{End}
    Sleep 1
    Send {Del}
    Sleep 1
    Send {Down 2}{Enter}
return

w::
    Send +^{Right}
    Send {Del}
    change_to_normal_mode()
    
Return

b::
    Send +^{Left}
    Send {Del}
    change_to_normal_mode()
Return

0::
    Send +{Home}
    Send {Del}
    change_to_normal_mode()
Return

$::
    Send +{End}
    Send {Del}
    change_to_normal_mode()
Return

t::
    del_to_next_char(true)
    change_to_normal_mode()
Return

+T::
    del_to_prev_char(true)
    change_to_normal_mode()
Return

f::
    del_to_next_char(False)
    change_to_normal_mode()
Return

+F::
    del_to_prev_char(False)
    change_to_normal_mode()
Return

CapsLock::
    change_to_normal_mode()
Return

; insert mode / no mode
#If
#if check_insert_mode()
    
; !Up::
;     nav_to_prev_char(".")
; return

; !Down::
;     nav_to_next_char(".")
; return

CapsLock::
    ; Send +{Left}
    change_to_normal_mode()
Return

^!g::
    Send >
return

^!l::
    Send <
return

!^v::
    Send |
return

!^1::
    Send {{}
return

#If
#If check_outer_mode()

do_mode_action_outer()
{
    if (currMode & changeModeCode)
    {
        Send ^{x}
        change_to_insert_mode()
        Return
    }
    
    else if (currMode & deleteModeCode)
    {
        Send ^{Del}
    }
    
    else if (currMode & yankModeCode)
    {
        Send ^{c}
    }

    change_out_outer_mode()
    Return
}

highlight_to_next_char_outer(curr_char)
{
    global currMode

    backup_mode := currMode
    currMode := insertModeCode
    
    backup := Clipboard
    Clipboard := ""
    ; copy until EOL
    highlight_until_EOL()
    Send ^c
    Send {Left}
    ClipWait
    
    sleep 10
    index := InStr(Clipboard, curr_char, true)
    if (index != 0) {
        Send +{Right %index%}

        Clipboard := backup
        currMode := backup_mode
        Return True
    }
    
    Clipboard := backup
    currMode := backup_mode
    Return False
}

highlight_to_prev_char_outer(curr_char)
{
    global currMode
    
    backup_mode := currMode
    currMode := insertModeCode
    
    backup := Clipboard
    Clipboard := ""
    ; copy until SOL
    highlight_until_SOL()
    Send ^c
    ClipWait
    
    sleep 10
    len := StrLen(Clipboard)
    index := InStr(Clipboard, curr_char, true)
    if (index != 0) {
       index-- 
        Send +{Right %index%}
        
        Clipboard := backup
        currMode := backup_mode
        Return True
    }else {
        ; Send {Right %len%}
        Send {Right}
    }
    
    Clipboard := backup
    currMode := backup_mode
    return False
}


CapsLock::
    change_out_outer_mode()
    return

w::
    Send ^{Left}^+{Right}
    do_mode_action_outer()
    Return


b::
8::
9::
(::
)::
    ; Highlight bracket
    if (highlight_to_prev_char_outer("("))
    {
        Send {Left}
        highlight_to_next_char_outer(")")

        do_mode_action_outer()
        Return
    }
    change_out_outer_mode()
    Return

7::
0::
+B::
{::
}::
    ; Highlight brace
    if (highlight_to_prev_char_outer("{"))
    {
        Send {Left}
        highlight_to_next_char_outer("}")

        do_mode_action_outer()
        Return
    }
    change_out_outer_mode()
    Return


ö::
ä::
[::
]::
    ; Highlight square bracket
    if (highlight_to_prev_char_outer("["))
    {
        Send {Left}
        highlight_to_next_char_outer("]")

        do_mode_action_outer()
        Return
    }
    change_out_outer_mode()
    Return

"::
2::
q::
    ; Highlight double quote
    if (highlight_to_prev_char_outer(""""))
    {
        Send {Left}
        highlight_to_next_char_outer("""")

        do_mode_action_outer()
        Return
    }
    change_out_outer_mode()
    Return



#If
#If check_inner_mode()

do_mode_action_inner()
{
    if (currMode & changeModeCode)
    {
        Send ^{x}
        change_to_insert_mode()

        Return
    }
    
    else if (currMode & deleteModeCode)
    {
        Send ^{Del}
    }
    
    else if (currMode & yankModeCode)
    {
        Send ^{c}
    }

    change_out_inner_mode()
    Return
}

highlight_to_next_char_inner(curr_char)
{
    global currMode

    backup_mode := currMode
    currMode := insertModeCode
    
    backup := Clipboard
    Clipboard := ""
    ; copy until EOL
    highlight_until_EOL()
    Send ^c
    Send {Left}
    ClipWait
    
    sleep 10
    index := InStr(Clipboard, curr_char, true)
    if (index != 0) {
            index--
        Send +{Right %index%}

        Clipboard := backup
        currMode := backup_mode

        Return True
    }
    
    Clipboard := backup
    currMode := backup_mode
    Return False
}

highlight_to_prev_char_inner(curr_char)
{
    global currMode
    
    backup := Clipboard
    Clipboard := ""
    ; copy until SOL
    highlight_until_SOL()
    Send ^c
    ClipWait
    
    sleep 10
    len := StrLen(Clipboard)
    index := InStr(Clipboard, curr_char, true)
    if (index != 0) {
        
        Send +{Right %index%}
        
        Clipboard := backup
        Return True
    }else {
        ; Send {Right %len%}
        Send {Right}
    }
    
    Clipboard := backup
    return False
}


CapsLock::
    change_out_inner_mode()
    return

w::
    Send ^{Left}^+{Right}
    do_mode_action_inner()
    Return


b::
8::
9::
(::
)::
    ; Highlight bracket
    if (highlight_to_prev_char_inner("("))
    {
        Send {Left}
        highlight_to_next_char_inner(")")

        do_mode_action_inner()
        Return
    }
    change_out_inner_mode()
    Return

7::
0::
+B::
{::
}::
    ; Highlight brace
    if (highlight_to_prev_char_inner("{"))
    {
        Send {Left}
        highlight_to_next_char_inner("}")

        do_mode_action_inner()
        Return
    }
    change_out_inner_mode()
    Return


ö::
ä::
[::
]::
    ; Highlight square bracket
    if (highlight_to_prev_char_inner("["))
    {
        Send {Left}
        highlight_to_next_char_inner("]")

        do_mode_action_inner()
        Return
    }
    change_out_inner_mode()
    Return

"::
2::
    ; Highlight double quote
    if (highlight_to_prev_char_inner(""""))
    {
        Send {Left}
        highlight_to_next_char_inner("""")

        do_mode_action_inner()
        Return
    }
    change_out_inner_mode()
    Return


; disable unused keybindings
#If
#If (WinActive("ahk_group WinTest") and (currMode != insertModeCode))
*a::
*b::
*c::
*d::
*e::
*f::
*g::
*h::
*i::
*j::
*k::
*l::
*m::
*n::
*o::
*p::
*q::
*r::
*s::
*t::
*u::
*v::
*w::
*x::
*y::
*z::
0::
1::
2::
3::
4::
5::
6::
7::
8::
9::
`::
~::
!::
@::
#::
$::
%::
^::
&::
*::
(::
)::
-::
_::
=::
+::
[::
{::
]::
}::
\::
|::
:::
`;::
'::
"::
,::
<::
.::
>::
Space::
; CapsLock::
Return


i::
    ; Send {Left}
    change_to_insert_mode()
Return

+I::
    Send {Home}
    change_to_insert_mode()
Return

; a::
;     Send {Right}
;     change_to_insert_mode()
; Return

+A::
    Send {End}
    change_to_insert_mode()
Return

o::
    Send {End}{Enter}
    change_to_insert_mode()
Return

+O::
    Send {Home}{Enter}{Left}
    change_to_insert_mode()
Return

ö::
    Send {Down}
    Send {End}
    change_to_insert_mode()
Return

+Ö::
    Send {Up}
    Send {Home}
    change_to_insert_mode()
Return

CapsLock::
    change_to_normal_mode()
Return



#If

#b::
    toggleTaskbar()
Return

#IfWinActive ahk_group basic
CapsLock::
    Send {Esc}
Return

+CapsLock::
    Send {CapsLock}
Return