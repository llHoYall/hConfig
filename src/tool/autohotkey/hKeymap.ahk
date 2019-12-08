; LAYER 0 (Default) -----------------------------------------------------------;
LControl::CapsLock
CapsLock::LControl

#if GetKeyState("AppsKey", "P")
`::`
#if !GetKeyState("AppsKey", "P")
`::Esc

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
AppsKey & Up::MouseMove, 0, -10, , R
AppsKey & Left::MouseMove, -10, 0, , R
AppsKey & Down::MouseMove, 0, 10, , R
AppsKey & Right::MouseMove, 10, 0, , R

#if GetKeyState("AppsKey", "P")
VK19 & w::MouseMove, 0, -5, , R
VK19 & a::MouseMove, -5, 0, , R
VK19 & s::MouseMove, 0, 5, , R
VK19 & d::MouseMove, 5, 0, , R

VK19 & q::MouseClick, left
VK19 & e::MouseClick, right

VK19 & z::Send, {WheelDown}
VK19 & c::send, {WheelUp}

; LAYER 3 (Media) -------------------------------------------------------------;
#if GetKeyState("AppsKey", "P")
+c::Run Calc
+t::Run wt
