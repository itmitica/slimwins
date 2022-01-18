#SingleInstance force
#MaxHotkeysPerInterval 500
#UseHook
#InstallKeybdHook
SetKeyDelay, -1

LWin & RCtrl::
RCtrl & LWin::
  Send, ^!{Tab}
return

LWin & RShift::
RShift & LWin::
  Send, #{Tab}
return

$<#<^;::
  Send, ^#{d}
return

$<#<^p:: 
  Send, ^#{F4}
return