#SingleInstance,Force
I_Icon = knews.ico
Menu, Tray, Icon, %I_Icon%
SetDefaultMouseSpeed, 0
CoordMode,Mouse,Screen

applicationname=knews

Gosub,READINI
  
shiftkeys=
keys=

sw := A_ScreenWidth
sh := A_ScreenHeight
opty := sh * 4/5
optw := 400
opth := 30
optx := sw - 1.33*optw 

Gui,+Owner +AlwaysOnTop -Resize -SysMenu -MinimizeBox -MaximizeBox -Disabled -Caption -Border -ToolWindow
Gui,Margin,0,0
Gui,Color,2E3440
Gui,Font,CE5E9F0 S12 W400,JuliaMono Medium
Gui,Add,Text,Vdesk,%A_Space%Desktop 1%A_Space%%A_Space%%A_Space%
Gui,Add,Text,Vlock x+0,%A_Space%x%A_Space%x%A_Space%x%A_Space%
Gui,Add,Text,Vtext x+0,MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
Gui,Show,X%optx% Y%opty% W%optw% H%opth% NoActivate,%applicationname%
GuiControl,,text,
WinSet,Transparent,210,%applicationname%

Gosub,LockState
Gosub,DeskState

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

AppsKey::RWin

;VKE2::LShift
SC056::LShift

^!r::Reload

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



DeskState:
    mapDesktopsFromRegistry()
    readCurrentDesktopNameFromRegistry()
    GuiControl,,desk, %A_Space%%CurrentDesktopName%
return

^#Left::
    global CurrentDesktop, CurrentDesktopName
    Send ^#{Left}
    Sleep,10
    mapDesktopsFromRegistry()
    readCurrentDesktopNameFromRegistry()
    GoSub DeskState
    ;MsgBox, %CurrentDesktopName%
    ;TrayTip Desktop %CurrentDesktop%, %CurrentDesktopName%, 1, 0x11
    return

^#Right::
    global CurrentDesktop, CurrentDesktopName
    Send ^#{Right}
    Sleep,10
    mapDesktopsFromRegistry()
    readCurrentDesktopNameFromRegistry()
    GoSub DeskState
    ;MsgBox, %CurrentDesktopName%
    ;TrayTip Desktop %CurrentDesktop%, %CurrentDesktopName%, 1, 0x11
    return

readCurrentDesktopNameFromRegistry() {
    global CurrentDesktop, CurrentDesktopId, CurrentDesktopName
    s := CurrentDesktopId
    FolderName := "{"
    FolderName := FolderName SubStr(s, 7, 2) SubStr(s, 5, 2) SubStr(s, 3, 2) SubStr(s, 1, 2)
    FolderName := FolderName "-"
    FolderName := FolderName SubStr(s, 11, 2) SubStr(s, 9, 2)
    FolderName := FolderName "-"
    FolderName := FolderName SubStr(s, 15, 2) SubStr(s, 13, 2)
    FolderName := FolderName "-"
    FolderName := FolderName SubStr(s, 17, 4)
    FolderName := FolderName "-"
    FolderName := FolderName SubStr(s, 21, 12)
    FolderName := FolderName "}"
    RegRead, CurrentDesktopName, HKEY_CURRENT_USER, SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VirtualDesktops\Desktops\%FolderName%, Name
    if (CurrentDesktopName = "") {
        CurrentDesktopName = Desktop %CurrentDesktop%
    }
}

; I found the following functions at:
; https://www.computerhope.com/tips/tip224.htm
mapDesktopsFromRegistry() {
    global CurrentDesktop, DesktopCount, CurrentDesktopId
    ; Get the current desktop UUID. Length should be 32 always, but there's no guarantee this couldn't change in a later Windows release so we check.
    IdLength := 32
    SessionId := getSessionId()
    if (SessionId) {
        RegRead, CurrentDesktopId, HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\SessionInfo\%SessionId%\VirtualDesktops, CurrentVirtualDesktop
        if (CurrentDesktopId) {
            IdLength := StrLen(CurrentDesktopId)
        }
    }
    ; Get a list of the UUIDs for all virtual desktops on the system
    RegRead, DesktopList, HKEY_CURRENT_USER, SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VirtualDesktops, VirtualDesktopIDs
    if (DesktopList) {
        DesktopListLength := StrLen(DesktopList)
        ; Figure out how many virtual desktops there are
        DesktopCount := DesktopListLength / IdLength
    }
    else {
        DesktopCount := 1
    }
    ; Parse the REG_DATA string that stores the array of UUID's for virtual desktops in the registry.
    i := 0
    while (CurrentDesktopId and i < DesktopCount) {
        StartPos := (i * IdLength) + 1
        DesktopIter := SubStr(DesktopList, StartPos, IdLength)
        OutputDebug, The iterator is pointing at %DesktopIter% and count is %i%.
        ; Break out if we find a match in the list. If we didn't find anything, keep the
        ; old guess and pray we're still correct :-D.
        if (DesktopIter = CurrentDesktopId) {
            CurrentDesktop := i + 1
            OutputDebug, Current desktop number is %CurrentDesktop% with an ID of %DesktopIter%.
            break
        }
        i++
    }
}


getSessionId()
{
    ProcessId := DllCall("GetCurrentProcessId", "UInt")
    if ErrorLevel {
        OutputDebug, Error getting current process id: %ErrorLevel%
        return
    }
    OutputDebug, Current Process Id: %ProcessId%
    DllCall("ProcessIdToSessionId", "UInt", ProcessId, "UInt*", SessionId)
    if ErrorLevel {
        OutputDebug, Error getting session id: %ErrorLevel%
        return
    }
    OutputDebug, Current Session Id: %SessionId%
    return SessionId
}
