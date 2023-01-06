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
#IfWinActive ahk_group WinTest



modifiers_match_list := "{Enter}{Del}{BackSpace}{Esc}{Tab}{Up}{Down}{Right}{Home}{End}{PgUp}{PgDn}"
; modifiers_match_list := "{Enter}{Ctrl}{Shift}{Del}{BackSpace}{Esc}{Tab}{Up}{Down}{Left}{Right}{Home}{End}{PgUp}{PgDn}"
singlechar_match_list := "a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q, r, s, t, u, v, x, y, z, ö, ä, ü, !, §, $, &, /, (, ), =, ?, +, #, -, _, ., :, , °, ^, <, >, {, }"

; match lists for normal mode
normal_mode_match_list := "w, W, b, B, t, T, f, F"
; modifiers_match_list := "{Enter}{Ctrl}{Shift}{Del}{BackSpace}{Esc}{Tab}{Up}{Down}{Left}{Right}{Home}{End}{PgUp}{PgDn}"
input_options :=  "B C E"

global isInChangeMode := False
global isInNormalMode := False
global isInYankMode := False
global isInVisualMode := False
global isInDeleteMode := False

check_normal_mode()
{
    return (WinActive("ahk_group WinTest") and ((isInNormalMode == True) and (isInChangeMode != True) and (isInYankMode != True) and (isInVisualMode != True) and (isInDeleteMode != True)))
}

check_change_mode()
{
    return (WinActive("ahk_group WinTest") and ((isInNormalMode == True) and (isInChangeMode == True) and (isInYankMode != True) and (isInVisualMode != True) and (isInDeleteMode != True)))
}

check_yank_mode()
{
    return (WinActive("ahk_group WinTest") and ((isInNormalMode ==  True) and (isInChangeMode != True) and (isInYankMode == True) and (isInVisualMode != True) and (isInDeleteMode != True)))
}
check_visual_mode()
{
    return (WinActive("ahk_group WinTest") and ((isInNormalMode == True) and (isInChangeMode != True) and (isInYankMode != True) and (isInVisualMode == True) and (isInDeleteMode != True)))
}

check_delete_mode()
{
    return (WinActive("ahk_group WinTest") and ((isInNormalMode == True) and (isInChangeMode != True) and (isInYankMode != True) and (isInVisualMode != True) and (isInDeleteMode == True)))
}

check_insert_mode()
{
    return (WinActive("ahk_group WinTest") and ((isInNormalMode != True) and (isInChangeMode != True) and (isInYankMode != True) and (isInVisualMode != True) and (isInDeleteMode != True)))
}

change_to_normal_mode()
{
    global
    isInNormalMode := True
    isInChangeMode := False
    isInYankMode := False
    isInVisualMode := False
    isInDeleteMode := False
}

change_to_change_mode()
{
    global
    isInNormalMode := True
    isInChangeMode := True
    isInYankMode := False
    isInVisualMode := False
    isInDeleteMode := False
}

change_to_yank_mode()
{
    global
    isInNormalMode := True
    isInChangeMode := False
    isInYankMode := True
    isInVisualMode := False
    isInDeleteMode := False
}

change_to_visual_mode()
{
    global
    isInNormalMode := True
    isInChangeMode := False
    isInYankMode := False
    isInVisualMode := True
    isInDeleteMode := False
}

change_to_delete_mode()
{
    global
    isInNormalMode := True
    isInChangeMode := False
    isInYankMode := False
    isInVisualMode := False
    isInDeleteMode := True
}

change_to_insert_mode()
{
    global
    isInNormalMode := False
    isInChangeMode := False
    isInYankMode := False
    isInVisualMode := False
    isInDeleteMode := False
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
    isInNormalMode := False
    
    backup := Clipboard
    Input curr_char, B C L1 E, %modifiers_match_list%, %singlechar_match_list%
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
        isInNormalMode := True
        Return True
    }else {
        ; Send {Right %len%}
        Send {Right}
    }
    
    Clipboard := backup
    isInNormalMode := True
    return False
}

highlight_to_next_char(include)
{
    global
    isInNormalMode := False
    
    backup := Clipboard
    Input curr_char, B C L1 E, %modifiers_match_list%, %singlechar_match_list%
    ; Input, curr_char, L1, {LControl}{RControl}{LAlt}{RAlt}{LShift}{RShift}{LWin}{RWin}{AppsKey}{F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Left}{Right}{Up}{Down}{Home}{End}{PgUp}{PgDn}{Del}{Ins}{BS}{CapsLock}{NumLock}{PrintScreen}{Pause}
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
        isInNormalMode := True
        Return True
    }
    
    Clipboard := backup
    isInNormalMode := True
    Return False
}

save_spot()
{
    global
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
    Return
}

else if (check_change_mode()) {
    MsgBox % "change_mode"
    Return
}

else if (check_yank_mode()) {
    MsgBox % "yank_mode"
    Return
}

else if (check_insert_mode()) {
    MsgBox % "insert_mode"
    Return
} else if (check_visual_mode()) {
    MsgBox % "visual_mode"
    Return
} else if (check_delete_mode()) {
    MsgBox % "delete_mode"
    Return
}

MsgBox % "not found"
Return

; Normal mode
#If
#if check_normal_mode()
    
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

; a::
;     Send {Right}
;     change_to_insert_mode()
; Return

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

y::
    change_to_yank_mode()
Return

d::
    change_to_delete_mode()
Return

; change mode
#If
#if check_change_mode()
; STUB

i::
    Send ^{Left}^+{Right}
    Send ^{x}

    change_to_insert_mode()
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
    Send ^{Left}^+{Right}
    Send ^{c}
    ClipWait

    change_to_normal_mode()
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
    Send ^{Left}^+{Right}
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

; STUB for notion
z::
    capitalize_words()
Return  

; STUB for notion
^b::
    Send ^{b}
Return

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

; disable unused keybindings
#If
#If (WinActive("ahk_group WinTest") and (isInNormalMode == True))
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

a::
    Send {Right}
    change_to_insert_mode()
Return

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
Return