#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#Hotstring EndChars -()[]{}:;'"/\?!`n `t$_^=+
#IfWinActive ahk_exe C:\Users\Joa Cortez\AppData\Local\Programs\Notion\Notion.exe
insertMath := "$$$$"

; #Hotstring O
:o:ßß::\blue{{}\boxed{{}+{enter 2}{}}{}}{up}
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
:oc:armat::\def\arraystretch{{}2.0{}}\begin{{}darray{}}{{}c|c{}}+{Enter}+{Enter}\end{{}darray{}}{up}
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

:c:ggf::gegebenenfalls

:c:DBB::Definitionbereich

:c:WBB::Wertebereich

:c:uaa::unter Andere

::#bk::$$\Bbb K$$

:*:#bkn::$$\Bbb K{^}{{}n, n{}}$${space}

::#bas::$$\mathcal B$$

::lam::$$\lambda$$

:*:#vec::$$\vec v$$

:*:#vex::$$\vec x$$

:*:#vea::$$\vec a$$

:*:#vef::$$\vec f$$

:*:#veb::$$\vec b$$

:*:#veg::$$\vec g$$

:*:#ve0::$${{}\vec 0{}}$$

::#r::$$\R$$

:*:#rn::$$\R {^}n$$

:*:#r2::$$\R {^}2$$

:*:#r3::$$\R {^}3$$

:*:#rm::$$\R {^}m$$

:*:#nnr::$$\R {^}{{}n, n{}}$$

:*:#nmr::$$\R {^}{{}n, m{}}$$

:*:#mnr::$$\R {^}{{}m, n{}}$$

::#impe::$$\underline Z$$

::#admit::$$\underline Y$$

::#delta::$$\Delta$$

::#seif::
    Send Sei ^+{e} f\colon D \to\R{enter}{space}
return

:*:#seifn::
    Send Sei ^+{e} f\colon D \to\R{^}n{enter}{space}
return

::#x0::$$\vec x_0$$

:*:#x00::$$x_0$${space}

::ppf::=>

:?:\dp::\displaystyle

#Hotstring ? C

::bbk::\Bbb K

:*:bbkn::\Bbb K{^}{{}n, n{}}

::bbcal::\mathcal B

::, , ::\ldots

::, ., ::{, } \ldots {, }

::summ0::\sum{^}n_{{}k=0{}}

::summ0i::\sum{^}n_{{}i=0{}}

::summ0j::\sum{^}n_{{}j=0{}}

::summ1::\sum{^}n_{{}k=1{}}

::summ1i::\sum{^}n_{{}i=1{}}

::summ1j::\sum{^}n_{{}j=1{}}

::summinf0::\sum{^}\infin _ {{}k=0{}}

::summinf1::\sum{^}\infin _ {{}k=1{}}

::likinf::\lim_{{}k\to\infin{}}

::livx::\lim_{{}\vec x \to

::lix::\lim_{{}x \to

::lik::\lim_{{}k \to

::likinf::\lim_{{}x \to \infin {}}

::linn::\lim_{{}n \to

::lin0::\lim_{{}n \to 0{}}

::litt::\lim_ {{}t \to

::liTT::\lim_ {{}T \to

::lit0::\lim_{{}t\to 0{}}

::litinf::\lim_{{}t \to \infin{}}

::lininf::\lim_{{}x \to \infin{}}

::int0inf::\int_0{^}\infin

::intab::\int_a{^}B

::int0b::\int_0{^}b

::\intinfin::\int_{{}-\infin{}}{^}\infin


::^-1::{^}{{}-1{}}
::^-2::{^}{{}-2{}}
::^-3::{^}{{}-3{}}
::^-4::{^}{{}-4{}}
::^-5::{^}{{}-5{}}
::^-6::{^}{{}-6{}}
::^-7::{^}{{}-7{}}
::^-8::{^}{{}-8{}}
::^-9::{^}{{}-9{}}

::mmur::{{}\mu_r{}}

::mmu0::{{}\mu_0{}}

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

#Hotstring * ?

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

::\ableitung::\frac{{}\partial f{}}{{}\partial{space}

::\oemga::\omega

::\omegat::\omega t

::\stext::\text{{}\small{space}

::\rot::\text{{}rot{}}

::\div::\text{{}div{}}

::\grad::\text{{}grad{}}

::gtt::^{left}\text{{}^{right}{}}{space}

::dtt::\text d{space}

::kk::^{left}$$^{right}$${space}

::k-k::^{left}$$^{right}$$-

::öö::+^{left}^{e}{right}{space}

::ää::+^{left}^{b}{right}^b{space}

::\laplace::\mathscr{{}L{}}

::\fourier::\mathscr{{}F{}}

::ccode::
    Send {enter}
    Send {`` 3} ^v
    Send ^+{up}
    Send {down}
return
::üü::
    Send ^a^b
    Send {right}
    Send {Enter}
return

#Hotstring * ? b0

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

::\textt::
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

!1::
    SendInput ^{end}
    SendInput {enter 2}
    SendInput /blockm
    SendInput ^+{up}
    SendInput {enter}
return

!2::
    Send ^+{2}Definition (
return
!3::
    Send ^+{3}Bemerkungen{enter}^+{6}
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
    Send ^{end}
    Send {enter}
return

^Enter::
    Send ^{home}
    Send {left}
    Sleep 1
    Send {enter}
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