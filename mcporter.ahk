#InstallKeybdHook
#UseHook on
#SingleInstance,Force

CoordMode,Mouse,Screen

global mousek := false

^!r::Reload

#h::
  mousek := !mousek
  if (mousek)
    MsgBox % "mouse mode for keyboard is: " . mousek
return

; left
f::
  if (mousek)
    MouseMove, -8,0,0,R
  else
    Send, f
return

d::
  if (mousek)
    MouseMove, -24,0,0,R
  else
    Send, d
return

s::
  if (mousek)
    MouseMove, -72,0,0,R
  else
    Send, s
return

a::
  if (mousek)
    MouseMove, -216,0,0,R
  else
    Send, a
return

; right
j::
  if (mousek)
    MouseMove, 8,0,0,R
  else
    Send, j
return

k::
  if (mousek)
    MouseMove, 24,0,0,R
  else
    Send, k
return

l::
  if (mousek)
    MouseMove, 72,0,0,R
  else
    Send, l
return

$;::
  if (mousek)
    MouseMove, 216,0,0,R
  else
    Send, {;}
return

; up, from left
r::
  if (mousek)
    MouseMove, 0,-8,0,R
  else
    Send, r
return

e::
  if (mousek)
    MouseMove, 0,-24,0,R
  else
    Send, e
return

w::
  if (mousek)
    MouseMove, 0,-72,0,R
  else
    Send, w
return

q::
  if (mousek)
    MouseMove, 0,-216,0,R
  else
    Send, q
return

; up, from right
u::
  if (mousek)
    MouseMove, 0,-8,0,R
  else
    Send, u
return

i::
  if (mousek)
    MouseMove, 0,-24,0,R
  else
    Send, i
return

o::
  if (mousek)
    MouseMove, 0,-72,0,R
  else
    Send, o
return

p::
  if (mousek)
    MouseMove, 0,-216,0,R
  else
    Send, p
return

; down, from left
v::
  if (mousek)
    MouseMove, 0,8,0,R
  else
    Send, v
return

c::
  if (mousek)
    MouseMove, 0,24,0,R
  else
    Send, c
return

x::
  if (mousek)
    MouseMove, 0,72,0,R
  else
    Send, x
return

z::
  if (mousek)
    MouseMove, 0,216,0,R
  else
    Send, z
return

; down, from right
m::
  if (mousek)
    MouseMove, 0,8,0,R
  else
    Send, m
return

$,::
  if (mousek)
    MouseMove, 0,24,0,R
  else
    Send, {,}
return

$.::
  if (mousek)
    MouseMove, 0,72,0,R
  else
    Send, {.}
return

$/::
  if (mousek)
    MouseMove, 0,216,0,R
  else
    Send, {/}
return

