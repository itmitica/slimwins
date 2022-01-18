#Include general_settings.ahk

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