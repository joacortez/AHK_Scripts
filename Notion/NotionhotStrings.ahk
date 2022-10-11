#SingleInstance, force
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#Hotstring EndChars -()[]{}:;'"/\?!`n `t$_^=+
#IfWinActive ahk_exe Notion.exe
; #IfWinActive ahk_exe C:\Users\joaco\AppData\Local\Programs\Notion\Notion.exe
insertMath := "$$$$"
enables := "not asigned"

winCheck := "ahk_exe Notion.exe"

modifiers_match_list := "{Enter}{Del}{BackSpace}{Esc}{Tab}{Up}{Down}{Right}{Home}{End}{PgUp}{PgDn}"
; modifiers_match_list := "{Enter}{Ctrl}{Shift}{Del}{BackSpace}{Esc}{Tab}{Up}{Down}{Left}{Right}{Home}{End}{PgUp}{PgDn}"
singlechar_match_list := "a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,x,y,z,ö,ä,ü,!,§,$,&,/,(,),=,?,+,#,-,_,.,:,,°,^,<,>,{,}"

; match lists for normal mode
normal_mode_match_list := "w,W,b,B,t,T,f,F"
; modifiers_match_list := "{Enter}{Ctrl}{Shift}{Del}{BackSpace}{Esc}{Tab}{Up}{Down}{Left}{Right}{Home}{End}{PgUp}{PgDn}"
input_options :=  "B C E"

global isInChangeMode := False
global isInNormalMode := False
global isInYankMode := False
global isInDeleteMode := False


check_normal_mode()
{
    return (WinActive("ahk_exe Notion.exe") and ((isInNormalMode == True) and (isInChangeMode != True) and (isInYankMode != True) and (isInVisualMode != True) and (isInDeleteMode != True)))
}

check_change_mode()
{
    return (WinActive("ahk_exe Notion.exe") and ((isInNormalMode == True) and (isInChangeMode == True) and (isInYankMode != True) and (isInVisualMode != True) and (isInDeleteMode != True)))
}

check_yank_mode()
{
    return (WinActive("ahk_exe Notion.exe") and ((isInNormalMode ==  True) and (isInChangeMode != True) and (isInYankMode == True) and (isInVisualMode != True) and (isInDeleteMode != True)))
}
check_visual_mode()
{
    return (WinActive("ahk_exe Notion.exe") and ((isInNormalMode == True) and (isInChangeMode != True) and (isInYankMode != True) and (isInVisualMode == True) and (isInDeleteMode != True)))
}

check_delete_mode()
{
    return (WinActive("ahk_exe Notion.exe") and ((isInNormalMode == True) and (isInChangeMode != True) and (isInYankMode != True) and (isInVisualMode != True) and (isInDeleteMode == True)))
}

check_insert_mode()
{
    return (WinActive("ahk_exe Notion.exe") and ((isInNormalMode != True) and (isInChangeMode != True) and (isInYankMode != True) and (isInVisualMode != True) and (isInDeleteMode != True)))
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

nav_to_prev_char()
{
    backUp := Clipboard

    if (highlight_to_prev_char())
    {
        Send {Left}
    }

    Clipboard := backUp
}


nav_to_next_char()
{
    backUp := Clipboard

    if (highlight_to_prev_char())
    {
        Send {Right}
    }

    Clipboard := backUp
}



change_to_prev_char()
{
    if (highlight_to_prev_char())
    {
        Send ^{x}
    }
}


change_to_next_char()
{
    if (highlight_to_next_char())
    {
        Send ^{x}
    }
}



highlight_to_prev_char()
{
    Input curr_char, B C L0 E,%modifiers_match_list%, %singlechar_match_list%
    Clipboard := ""
    ; copy until EOL
    highlight_until_SOL()
	Send ^c
    Send {Left}
    ClipWait 

	sleep 10
    len := StrLen(Clipboard)
    index := InStr(Clipboard, curr_char, true)
    if (index != 0)
    {
        Send {ShiftDown}
        Send {Right %index%}
        Send {ShiftUp}
       Return True 
    }
    Else
    {
        Send {Right %len%}
        return False
    }

    return False
}


highlight_to_next_char()
{
    Input curr_char, B C L0 E,%modifiers_match_list%, %singlechar_match_list%
    Clipboard := ""
    ; copy until EOL
    highlight_until_EOL()
	Send ^c
    Send {Left}
    ClipWait 

	sleep 10
    index := InStr(Clipboard, curr_char, true)
    if (index != 0)
    {
        Send {ShiftDown}
        Send {Right %index%}
        Send {ShiftUp}

        Return True
    }

    Return False
}



!Esc::
    if (check_normal_mode())
    {
        MsgBox % "normal_mode"
        Return
    }
    
   else if (check_change_mode())
    {
        MsgBox % "change_mode"
        Return
    }

    else if (check_yank_mode())
    {
        MsgBox % "yank_mode"
        Return
    }
    
    else if (check_insert_mode())
    {
        MsgBox % "insert_mode"
        Return
    }
    else if (check_visual_mode())
    {
        MsgBox % "visual_mode"
        Return
    }
    else if (check_delete_mode())
    {
        MsgBox % "delete_mode"
        Return
    }
    
    
    MsgBox % "not found"
    Return




; Normal mode 
#If
#If check_normal_mode()

j:: 
    Send {Down}
Return 

k:: 
    Send {Up}
Return 

l:: 
    Send {Right}
Return 

h:: 
    Send {Left}
Return 

w::
    Send ^{Right}
return 

b::
     Send ^{Left}
Return

t::
    nav_to_next_char()
return 

+T::
    nav_to_prev_char()
return

p::
    Send %Clipboard%
Return

i::
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

c::
    change_to_change_mode()
Return

y::
    change_to_yank_mode()
Return

d::
    change_to_delete_mode()
Return

; change mode
#If
#If check_change_mode()
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

CapsLock::
    change_to_normal_mode()
Return


; yank mode
#If
#If check_yank_mode()

y::
    Send {Esc}
    Send ^{c}{Esc}
    change_to_normal_mode()
Return

w::
    Send +^{Right}
    Send ^{c}{Esc}
    change_to_normal_mode()
Return

b::
    Send +^{Left}
    Send ^{c}{Esc}
    change_to_normal_mode()
Return

CapsLock::
    change_to_normal_mode()
Return

; visual Mode
#If
#If check_visual_mode()
w::
    Send +^{Right}

Return

b::
    Send +^{Left}
Return

y::
    Send ^{c}
    change_to_normal_mode()
Return

; !!!!!!
d::
    Send {Del}
    change_to_insert_mode()
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
    


; delete mode 
#If
#If check_delete_mode()

d::
    Send {Esc}
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

CapsLock::
    change_to_normal_mode()
Return


; insert mode / no mode 
#If
#If check_insert_mode()




!Left::
    nav_to_prev_char()
Return

!Right::
    nav_to_next_char()
return

; !Up::
;     nav_to_prev_char(".")
; return

; !Down::
;     nav_to_next_char(".")
; return

CapsLock::
    change_to_normal_mode()
Return





; change blocks functions

; make entire block bold
make_block_bold()
{
    Send ^a^b{end}
    return
}

; add a new block
add_block_below()
{
    ; Send {esc}
    ; Sleep 10
    ; Send {enter}
    ; Sleep 10
    ; Send {enter}
    Send ^a
    Sleep, 1
    Send {end}
    Sleep, 1
    Send {enter}
    return
}

add_block_above()
{
    Send {esc}
    Send {up}
    Sleep 1
    Send {enter}
    Sleep 1
    Send {enter}
    return
}

; Replace functions
replace()
{
    Send {backspace}{{}
    return
}

wait1()
{
    Send {backspace}{{}
    KeyWait F1, D, T30
    Send {}}{space}
    return
}

wait2()
{
    Send {backspace}{{}
    KeyWait F1, D, T30
    Send {}}{{}
    return
}

; wait2()
; {
;     Send {backspace}{{}
;     enables := "short"
;     return
; }

; d::
; If (enables = "short" or enables = "long")
;     {
;         keywait, d
; keywait, d, d t0.5 ; Increase the "t" value for a longer timeout.
; if errorlevel
; {
;     ; pretend that nothing happened and forward the single "d"
;     Send nota working
;     return
; }
; ; A double "d" has been detected, act accordingly.
; Send {}}{{}
; enables = ""
; }
; Else
; {
; Send %enables%
; }
; return

; #Hotstring O
:o:ßß::\green{{}\boxed{{}+{enter 2}{}}{}}{up}
return

:*:gst::^{left}\text{{}\small ^{right}{}}{space}

; #Hotstring O C
writeMat(type)
{
    Send \begin{{}%type%{}}+{Enter}+{Enter}\end{{}%type%{}}{up}
    return
}

:oc:ali::
    writeMat("aligned")
return
:oc:mat::
    writeMat("matrix")
return
:oc:vmat::
    writeMat("vmatrix")
return
:oc:Vmat::
    writeMat("Vmatrix")
return
:oc:bmat::
    writeMat("bmatrix")
return
:oc:Bmat::
    writeMat("Bmatrix")
return
:oc:pmat::
    writeMat("pmatrix")
return
:oc:cmat::
    writeMat("dcases")
return
:oc:rmat::
    writeMat("drcases")
return
:oc:smat::
    writeMat("smallmatrix")
return
:oc:cdmat::
    writeMat("CD")
return

:oc:armat::\def\arraystretch{{}1.5{}}\begin{{}darray{}}{{}|cc|{}}\hline+{Enter}+{Enter}\\ \hline\end{{}darray{}}{up}
return

:oc:truthmat::\newcommand{{}\do{}}[1]{{}\llbracket {#}1 \rrbracket{}}+{Enter}\def\arraystretch{{}1.5{}}\begin{{}darray{}}{{}c|c||c{}}+{Enter}\\+{Enter} \hline\end{{}darray{}}{up}{home}
return

#Hotstring C
:c:ONB::Orthornormalbasis

:c:BBS::Betriebssystem

:c:BMM::Betriebsmitteln

:c:bmm::Betriebsmittel

:c:EW::Eigenwerte

:c:ew::Eigenwert

:c:EV::Eigenvektoren

:c:ev::Eigenvektor

:c:dhh::das heißt

:c:ffalls::, &\text{{}falls {}}

:c:ffür::, &\text{{}für {}}

:c:zzb::zum Beispiel

:c:iA::im Allgemeinen

:c:idR::in der Regel

:c:GDW::genau dann wenn

:c:ggf::gegebenenfalls

:c:DBB::Definitionbereich

:c:WBB::Wertebereich

:c:uaa::unter Andere

:c*:diffbar::differenzierbar
    
::#bk::$$\Bbb K$$

:*:#bkn::$$\Bbb K{^}{{}n, n{}}$${space}

::#bas::$$\mathcal B$$

::#lam::$$\lambda$$

:*:#vec::$$\vec v$$

:*:#vex::$$\vec x$$

:*:#vea::$$\vec a$$

:*:#vef::$$\vec f$$

:*:#veb::$$\vec b$$

:*:#veg::$$\vec g$$

:*:#vep::$$\vec p$$

:*:#ve0::$${{}\vec 0{}}$$

::#r::$$\R$$

:*:#rn::$$\R {^}n$$

:*:#r2::$$\R {^}2$$

:*:#r3::$$\R {^}3$$

:*:#rm::$$\R {^}m$$

:*:#nnr::$$\R {^}{{}n, n{}}$$

:*:#nmr::$$\R {^}{{}n, m{}}$$

:*:#mnr::$$\R {^}{{}m, n{}}$$

:*:#inn::$$n \in \N$$

::#impe::$$\underline Z$$

::#admit::$$\underline Y$$

:c:#delta::$$\delta$$

:c:#Delta::$$\Delta$$

:c:#sigma::$$\sigma$$

:c:#Sigma::$$\Sigma$$

::#phi::$$\varphi$$

::#tau::$$\tau$$

::#Gamma::$$\Gamma$$

::#gamma::$$\gamma$$

::#seif::
    Send Sei ^+{e} f\colon D \to\R{enter}{space}
return

:*:#seifn::
    Send Sei ^+{e} f\colon D \to\R{^}n{enter}{space}
return

::#x0::$$\vec x_0$$

:*:#x00::$$x_0$${space}

::#q0::$$q_0$$

::#alpha::$$\alpha$$

::#beta::$$\beta$$

::#gamma::$$\gamma$$

::#omega::$$\omega$$

::#pi::$$\pi$$

::#N::$$\N$$

::#R::$$\R$$

::ppf::=>

:?:\dp::\displaystyle

#Hotstring ? C

::bbk::\Bbb K

:*:bbkn::\Bbb K{^}{{}n, n{}}

::bbcal::\mathcal B

::,,::\ldots

::,.,::{,} \ldots {,}

::\summk::\sum_{{}k=

::\summ0::\sum{^}n_{{}k=0{}}

::\summ0i::\sum{^}n_{{}i=0{}}

::\summ0j::\sum{^}n_{{}j=0{}}

::\summ1::\sum{^}n_{{}k=1{}}

::\summ1i::\sum{^}n_{{}i=1{}}

::\summ1j::\sum{^}n_{{}j=1{}}

::\summkn::\sum{^}n_{{}k=1{}}

::\summinf0::\sum{^}\infin _ {{}k=0{}}

::\summinf1::\sum{^}\infin _ {{}k=1{}}

::\summinfin::\sum{^}\infin _ {{}k=-\infin{}}

::\likinf::\lim_{{}k\to\infin{}}

::\livx::\lim_{{}\vec x \to

::\lix::\lim_{{}x \to

::\lik::\lim_{{}k \to

::\likinf::\lim_{{}x \to \infin {}}

::\linn::\lim_{{}n \to

::\lin0::\lim_{{}n \to 0{}}

::\litt::\lim_ {{}t \to

::\liTT::\lim_ {{}T \to

::\lit0::\lim_{{}t\to 0{}}

::\litinf::\lim_{{}t \to \infin{}}

::\liTinf::\lim_{{}T \to \infin{}}

::\lininf::\lim_{{}x \to \infin{}}

::\int0inf::\int_0{^}\infin

::\intab::\int_a{^}b

::\int0b::\int_0{^}b

::\int0t::\int_0{^}t

::\intinfin::\int_{{}-\infin{}}{^}\infin

::\notin::\not \in{space}

::\ablf::\frac{{}\partial f{}}{{}\partial{space}

::\abl::
    Send \frac{{}\partial{space}
    KeyWait F1, D, T30
    Send {}}{{}\partial{space}
return

:*?:\card::\text{{}card{}}

::\pto:::\rightharpoonup

::\Q::\mathbb Q

::\NFA::(Q, \Sigma, \Delta, S, F)

::\DFA::(Q, \Sigma, \delta, q_0, F)

::\PDA::(Q, \Sigma, \Gamma, \square, \Delta, q_0, F)

::\G::(V, \Sigma, P, S)

::\renew::\renewcommand

::\newcomm::\newcommand{{}\do{}}{{}
::\newcomm1::\newcommand{{}\do{}}[1]{{}
::\newcomm2::\newcommand{{}\do{}}[2]{{}
::\newcomm3::\newcommand{{}\do{}}[3]{{}

::^-1::{^}{{}-1{}}
::^-2::{^}{{}-2{}}
::^-3::{^}{{}-3{}}
::^-4::{^}{{}-4{}}
::^-5::{^}{{}-5{}}
::^-6::{^}{{}-6{}}
::^-7::{^}{{}-7{}}
::^-8::{^}{{}-8{}}
::^-9::{^}{{}-9{}}
::^-x::{^}{{}-x{}}
::^-y::{^}{{}-y{}}
::^-t::{^}{{}-t{}}

::mmur::{{}\mu_r{}}

::mmu0::{{}\mu_0{}}

::\mun::{{}\mu_n{}}

::\mup::{{}\mu_p{}}

::epsr::{{}\varepsilon_r{}}

::eps0::{{}\varepsilon_0{}}

::esps::\varepsilon

::rr0::{{}r_0{}}

::2ppi::{{}2\pi{}}

::vvec::\vec v

::vvex::\vec x

::vvey::\vec y

::vee::\vec e_

::vveF::\vec F_{{}{}}{left}

::vvef::\vec f

::vveg::\vec g

::vver::\vec r

::vves::\vec s

::vvea::\vec a

::vveb::\vec b

::vve0::\vec 0

::vvex0::{{}\vec x_0{}}

::dda::{{}\text d \vec A{}}

::dds::{{}\text d \vec s{}}

::ddrho::{{}\text d \rho{}}

::ddphi::{{}\text d \varphi{}}

::ddt::{{}\text d t{}}

::ddx::{{}\text d x{}}

::ddz::{{}\text d z{}}

::ntor::\to\R{^}n

::nton::\to\R{^}{{}n, n{}}

::nton::\to\R{^}{{}n, n{}}

::mtor::\to\R{^}m

::ntom::\to\R{^}{{}n, m{}}

::mton::\to\R{^}{{}m, n{}}

::rtor::\to\R

::[\to::[ \ \to

::\ordnung::\sqsubseteq

::\L::\mathcal{{}L{}}[

::\F::\mathcal{{}F{}}[

::\P::\mathcal{{}P{}}

::\A::\mathcal{{}A{}}

::\inI::\in I

::\inR::\in R

::\inA::\in A

::\inB::\in B

::\inD::\in D

::\inM::\in M

::\inP::\in P

::\inV::\in V

::\inN::\in N

::\inn::\in\N

::inrr::\in\R

::inrn::\in\R{^}n

::inrm::\in\R{^}m

::innrn::\in\R{^}{{}n, n{}}

::inmrm::\in\R{^}{{}m, m{}}

::innrm::\in\R{^}{{}n, m{}}

::inmrn::\in\R{^}{{}m, n{}}

::subrr::\sub\R

::subr2::\sub\R{^}2

::subr3::\sub\R{^}3

::subrn::\sub\R{^}n

::subnrn::\sub\R{^}{{}n, n{}}

::ttan::\tan(

::ssin::\sin(

::ccos::\cos(

::ssix::\sin(x)

::ccox::\cos(x)

::ttax::\tan(x)

::ssiv::\sin(\varphi)

::ccov::\cos(\varphi)

::ttav::\tan(\varphi)

::x0::{{}x_0{}}

:c:Dx::{{}\Delta x{}}

::y0::{{}y_0{}}

:c:Dy::{{}\Delta y{}}

::q0::{{}q_0{}}

::lam::\lambda

#Hotstring * ? C0

::^--::
    Send {^}{{}-
    KeyWait Space, D
    Send {}}
return

::\lvert::\, \vert\, 

::\limm::\lim_{{}

::\impe::{{}\underline Z{}}

::\admit::{{}}\underline Y{}}

::\strom::{{}\underline I{}}

::\span::{{}\underline U{}}

::\oemga::\omega

::\delta0::\delta_0

::\omega0::\omega_0

::t0::t_0

::z0::z_0

:c?:toin::tion

:?:schlat::schalt

::ppmos::p{-}MOSFET

::nnmos::n{-}MOSFET

::mostt::MOS{-}Transistor

::mmoss::MOSFET

::npntt::npn{-}Transistor

::pnptt::pnp{-}Transistor

; :c?:funktoin::funktion

; :c?:Funktoin::Funktion

::\omegat::\omega t

::\stext::\text{{}\small{space}

::\rot::\text{{}rot{}}

::\div::\text{{}div{}}

::\grad::\text{{}grad{}}

::gtt::^{left}\text{{}^{right}{}}{space}

::dtt::\text d{space}

::kk::^{left}$$^{right}$${space}

::k-k::^{left}$$^{right}$$-

:c:K'K::^{left}$$^{right}{'}$${space}

::((::\Big (
::))::\Big )

::öö::
    Send +^{left}
    Sleep, 1
    Send ^{e}
    Sleep, 1
    Send {End}
    Sleep, 1
    Send {space}
Return

; ::ää::
;     Send +^{left}
;     Sleep, 1
;     Send ^{b}
;     Sleep, 1
;     Send {right}
;     Sleep, 1
;     Send {space}
; Return

::ää::+^{left}^{b}{right}^{b}{space}

::ä,ä::+^{left}^{b}{right}^{b}, {space}

::ccode::
    Send {enter}
    Send {`` 3} ^v
    Send ^+{up}
    Send {down}
return

::üü::
    make_block_bold()
    Send {enter}
return

::++::
    make_block_bold()
    Send {Enter}
    Send ^+{5}
return

; ::üü::
;     Send ^a^b
;     ; Send ^{Right}
;     Send {End}
;     Send {Enter}
; return

; ::î::{^}i

#Hotstring * ? b0

::\textt::
    replace()
return

::\boldd::
    replace()
return

::\bluee::
    replace()
return

::\greenn::
    replace()
return

::\orangee::
    replace()
return

::\purplee::
    replace()
return

::\redd::
    replace()
return

::\cancell::
    replace()
return

::\xcancell::
    replace()
return

::\overlinee::
    replace()
return

::\underlinee::
    replace()
return

::\sqrtt::
    replace()
return

::\brakett::
    replace()
return

::\overbracee::
    replace()
return

::\underbracee::
    replace()
return

::\doo::
    replace()
return

::\brakett::
    replace()
return

::__::
    wait1()
return

::^^::
    wait1()
return

::\fracc::
    wait2()
return

::\dfracc::
    wait2()
return

::\dii::
    wait2()
return

::\binomm::
    wait2()
return

::\dbinomm::
    wait2()
return

; #Hotkey

F2::
    Send {&}{=}{Space}
return

F3::
    Send \\ \hline+{enter}
return

F4::
    Send {&}\coloneqq{space}
return

!1::
    SendInput ^{end}{right}
    SendInput {enter 2}
    SendInput /blockeq
    SendInput ^+{up}
    SendInput {enter}
return

!2::
    Send ^+{2}Definition (
return
!3::
    Send ^+{3}Bemerkungen{enter}^+{5}
return

!4::
    Send /call{enter}
    Sleep 1
    Send MMerkzettel
    Sleep 1
    Send +^{left}^{b}{right}^{b}{enter}
    Sleep 1
    Send ^+{up}
return
!5::
    Send /call{enter}
    Sleep 1
    Send BBemerkung
    Sleep 1
    Send +^{left}^{b}{right}^{b}{enter}
    Sleep 1
    Send ^+{up}
return

F7::
    Send {Home}{BackSpace}
   make_block_bold()
    Send {Enter}
    Send ^+{5}
    
return

^+ß::
    Send /turncallout{enter}
return

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

^y::
    Send {esc}
    Sleep 1
    Send {delete}
    Sleep 1
    Send {down 2}{enter}
return

+Enter::
    add_block_below()
return
; +Enter::
;     Send ^{end}
;     Sleep, 1
;     Send {enter}
; return

^Enter::
    add_block_above()
return

+^Enter::
    Send +{Enter}
return

^!Enter::
    Send {End}\\
    Send +{enter}
return

!+Enter::
    Send ^{enter}
return

^!F1::
    Send (\vec x)
return

^!F2::
    Send (x, y)
return

^!F3::
    Send (x, y, z)
return

^!t::
    Send (t)
return

^!x::
    Send (x)
return

^!y::
    Send (y)
return

^!w::
    Send (\omega)
return

^!s::
    Send (s)
return

^!u::
    Send $$u(t)$${space}
return

F6::
    Send &=
return

^!space::
    send {space}
return



; disable unused keybindings
#If
#If WinActive("ahk_exe Notion.exe") and (isInNormalMode == True)
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
CapsLock::
Return