; LAYER 0 (Default) -----------------------------------------------------------;
LControl::CapsLock
CapsLock::LControl

; LAYER 1 (Navigation) --------------------------------------------------------;
>+1::F1
>+2::F2
>+3::F3
>+4::F4
>+5::F5
>+6::F6
>+7::F7
>+8::F8
>+9::F9
>+0::F10
>+-::F11
>+=::F12

>+w::send {Up}
>+a::send {Left}
>+s::send {Down}
>+d::send {Right}

>+[::send {Up}
>+;::send {Left}
>+/::send {Down}
>+'::send {Right}

>+q::send {Home}
>+e::send {End}

>+k::send {Home}
>+,::send {End}

>+z::send {PgUp}
>+c::send {PgDn}

>+l::send {PgUp}
>+.::send {PgDn}

; LAYER 2 (Mouse) -------------------------------------------------------------;
AppsKey & w::
	MouseMove, 0, -5, , R
	return

AppsKey & a::
	MouseMove, -5, 0, , R
	return

AppsKey & s::
	MouseMove, 0, 5, , R
	return

AppsKey & d::
	MouseMove, 5, 0, , R
	return

; LAYER 3 (Media) -------------------------------------------------------------;
