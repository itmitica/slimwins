#SingleInstance,Force
I_Icon = knews.ico
IfExist, %I_Icon%
Menu, Tray, Icon, %I_Icon%
;return
SetDefaultMouseSpeed, 0
CoordMode,Mouse,Screen

applicationname=mc-hanger

Gosub,READINI
  
shiftkeys=
keys=

sw := A_ScreenWidth
sh := A_ScreenHeight
opty := sh * 4/5
optw := 300
opth := 30
optx := sw - 1.33*optw 

Gui,+Owner +AlwaysOnTop -Resize -SysMenu -MinimizeBox -MaximizeBox -Disabled -Caption -Border -ToolWindow
Gui,Margin,0,0
Gui,Color,2E3440
Gui,Font,CE5E9F0 S12 W400,JuliaMono Medium
Gui,Add,Text,Vlock,%A_Space%x%A_Space%x%A_Space%x
Gui,Add,Text,Vtext x+0,MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
Gui,Show,X%optx% Y%opty% W%optw% H%opth% NoActivate,%applicationname%
GuiControl,,text,
WinSet,Transparent,210,%applicationname%

Gosub,LockState

Loop
{
  oldkeys=%keys%
  keys=
  Loop,%keyarray0%
  {
    key:=keyarray%A_Index%
    StringTrimRight,key,key,1
    GetKeyState,state,%key%,P
    If state=D
      keys=%keys% %key%
  }
  StringTrimRight,keys,keys,0
  If keys=%oldkeys%
    Continue

  oldshiftkeys=%shiftkeys%
  shiftkeys=%keys%
  StringReplace,shiftkeys,shiftkeys,LWin
  StringReplace,shiftkeys,shiftkeys,RWin
  StringReplace,shiftkeys,shiftkeys,LCtrl
  StringReplace,shiftkeys,shiftkeys,RCtrl
  StringReplace,shiftkeys,shiftkeys,LShift
  StringReplace,shiftkeys,shiftkeys,RShift
  StringReplace,shiftkeys,shiftkeys,LAlt
  StringReplace,shiftkeys,shiftkeys,RAlt
  StringReplace,shiftkeys,shiftkeys,AltGr
  StringReplace,shiftkeys,shiftkeys,%A_SPACE%,,All  
  If shiftkeys=
  If oldshiftkeys<>
    Continue

  If keys<>
  {
    GuiControl,,text, %A_Space%%A_Space%%A_Space%%keys%
    SetTimer,STATUSOFF,4000
  }

}


STATUSOFF:
GuiControl,,text,
SetTimer,STATUSOFF,Off
Return


READINI:
IfNotExist,%applicationname%.ini
{
  inifile=%inifile%`nAppsKey`nLWin`nRWin`nLCtrl`nRCtrl`nLShift`nRShift`nLAlt`nRAlt`nAltGr
  inifile=%inifile%`nPrintScreen`nCtrlBreak`nPause`nBreak`nHelp`nBrowser_Back`nBrowser_Forward`nBrowser_Refresh`nBrowser_Stop`nBrowser_Search`nBrowser_Favorites`nBrowser_Home`nVolume_Mute`nVolume_Down`nVolume_Up`nMedia_Next`nMedia_Prev`nMedia_Stop`nMedia_Play_Pause`nLaunch_Mail`nLaunch_Media`nLaunch_App1`nLaunch_App2
  inifile=%inifile%`nF1`nF2`nF3`nF4`nF5`nF6`nF7`nF8`nF9`nF10`nF11`nF12`nF13`nF14`nF15`nF16`nF17`nF18`nF19`nF20`nF21`nF22`nF23`nF24
  inifile=%inifile%`nJoy1`nJoy2`nJoy3`nJoy4`nJoy5`nJoy6`nJoy7`nJoy8`nJoy9`nJoy10`nJoy11`nJoy12`nJoy13`nJoy14`nJoy15`nJoy16`nJoy17`nJoy18`nJoy19`nJoy20`nJoy21`nJoy22`nJoy23`nJoy24`nJoy25`nJoy26`nJoy27`nJoy28`nJoy29`nJoy30`nJoy31`nJoy32`nJoyX`nJoyY`nJoyZ`nJoyR`nJoyU`nJoyV`nJoyPOV
  inifile=%inifile%`nSpace`nTab`nEnter`nEscape`nBackspace`nDelete`nInsert`nHome`nEnd`nPgUp`nPgDn`nUp`nDown`nLeft`nRight`nScrollLock`nCapsLock
  inifile=%inifile%`nNumLock`nNumpadDiv`nNumpadMult`nNumpadAdd`nNumpadSub`nNumpadEnter`nNumpadDel`nNumpadIns`nNumpadClear`nNumpadDot`nNumpad0`nNumpad1`nNumpad2`nNumpad3`nNumpad4`nNumpad5`nNumpad6`nNumpad7`nNumpad8`nNumpad9
  inifile=%inifile%`nA`nB`nC`nD`nE`nF`nG`nH`nI`nJ`nK`nL`nM`nN`nO`nP`nQ`nR`nS`nT`nU`nV`nW`nX`nY`nZ`nĆ`nŘ`nĹ`n1`n2`n3`n4`n5`n6`n7`n8`n9`n0`n```n`,`n`%`n+`n-`n*`n\`n/`n|`n_`n<`n^`n>`n!`n"`n#`n¤`n&`n(`n)`n=`n?`n´`n'`n¨`n~`n;`n:`n.`n@`nŁ`n$`n€`n§`nµ
  inifile=%inifile%`nLButton`nRButton`nMButton`nWheelDown`nWheelUp`nXButton1`nXButton2`n
  FileAppend,%inifile%,%applicationname%.ini
}

FileRead,inifile,%applicationname%.ini
StringSplit,keyarray,inifile,`n
inifile=
Return

EXIT:
GuiClose:
ExitApp

F1::
  WinGetPos, X, Y, W, H, %applicationname%
  ;MsgBox, practical is at %X%`,%Y% and its size is %W%x%H%
  MouseMove,X+W-10,Y+8
return

LockState:
  n := (GetKeyState("NumLock", "T")) ? "⚫ " : "○ "
  c := (GetKeyState("CapsLock", "T")) ? "⚫ " : "○ "
  s := (GetKeyState("ScrollLock", "T")) ? "⚫" : "○"
  GuiControl,,lock, %A_Space%%n%%c%%s%
return

~NumLock::
~CapsLock::
~ScrollLock::
  Sleep,10
  GoSub LockState
return

^!r::Reload

^space::^!tab

;VKE2::LShift
SC056::LShift
