; LAYER 0 (Default) -----------------------------------------------------------;
LControl::CapsLock
CapsLock::LControl

#if GetKeyState("AppsKey", "P")
`::`
#if !GetKeyState("AppsKey", "P")
`::send {Esc}

; LAYER 1 (Navigation) --------------------------------------------------------;
#if GetKeyState("AppsKey", "P")
1::F1
2::F2
3::F3
4::F4
5::F5
6::F6
7::F7
8::F8
9::F9
0::F10
-::F11
=::F12

w::Up
a::Left
s::Down
d::Right

q::Home
e::End
z::PgUp
c::PgDn

[::Up
`;::Left
/::Down
'::Right

k::Home
,::End
l::PgUp
.::PgDn

; LAYER 2 (Mouse) -------------------------------------------------------------;
AppsKey & Up::
	MouseMove, 0, -5, , R
	return

AppsKey & Down::
	MouseMove, 0, 5, , R
	return

AppsKey & Left::
	MouseMove, -5, 0, , R
	return

AppsKey & Right::
	MouseMove, 5, 0, , R
	return

; LAYER 3 (Media) -------------------------------------------------------------;
#if GetKeyState("AppsKey", "P")
+c::Run Calc
+t::Run wt
