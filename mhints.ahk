#SingleInstance
I_Icon = mhints.ico
IfExist, %I_Icon%
Menu, Tray, Icon, %I_Icon%
;return
SetDefaultMouseSpeed, 0
DetectHiddenWindows, On
;MsgBox % A_ScreenHeight A_ScreenWidth A_ScreenDPI
customDPI := A_ScreenDPI/96
hintSize := 32
winc_presses := 0
numberOfRows := 26
numberOfCols := 26
rowSpacing := hintSize + ( (A_ScreenHeight - numberOfRows * (hintSize * customDPI) ) / (numberOfRows - 1) ) / customDPI
colSpacing := hintSize + ( (A_ScreenWidth - numberOfCols * (hintSize * customDPI) ) / (numberOfCols - 1) ) / customDPI
AscA := 97
KeyArray := ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]

#IfWinNotActive CoordGrid
	#IfWinNotExist CoordGrid
		global numberOfRows, numberOfCols, rowSpacing, colSpacing, KeyArray

		^;::
      Gui,Font,CE5E9F0 S11,Bahnschrift
	 		; Display Coordinates 
			rowCounter := 0
			Loop {
				rowYCoord := rowCounter * rowSpacing
				rowYCoordAlpha := KeyArray[rowCounter+1]
				colCounter := 0
				Loop {
					colXCoord := colCounter * colSpacing
					colXCoordAlpha := KeyArray[colCounter+1]
					Gui, Add, Progress, w%hintSize% h%hintSize% x%colXCoord% y%rowYCoord% Backgroundfafafa disabled
					gui, add, text, w%hintSize% h%hintSize% x%colXCoord% y%rowYCoord% border 0x201 readonly backgroundtrans c212121, %rowYCoordAlpha%%colXCoordAlpha%
					colCounter := colCounter + 1
				}    
				Until colCounter = numberOfcols			
				rowCounter := rowCounter + 1
			}    
			Until rowCounter = numberOfRows
			Gui, Color, 000115
			Gui, Show, X0 Y0 W%A_ScreenWidth% H%A_ScreenHeight%, CoordGrid
			Gui -Caption +AlwaysOnTop +E0x20
			WinSet, Transcolor, 000115, CoordGrid
			
			Return
	#IfWinNotExist	
#IfWinNotActive	

#IfWinExist CoordGrid
	#IfWinNotActive CoordGrid
		^;::
      winmove, CoordGrid, , 0, 0
			Gui Show
			Return
	#IfWinNotActive	
#IfWinExist

#IfWinActive CoordGrid
	esc::
		Gui Hide
    winmove, CoordGrid, , 0, 0
		Return
		
	left:: 
	WinGetPos ,  currentposX, currentposY,,, CoordGrid
	winmove, CoordGrid,, % currentposX-16
	return
	right:: 
	WinGetPos ,  currentposX, currentposY,,, CoordGrid
	winmove, CoordGrid,, % currentposX+16
	return
	Up:: 
	WinGetPos ,  currentposX, currentposY,,, CoordGrid
	winmove, CoordGrid,, , % currentposY-16
	return
	Down:: 
	WinGetPos ,  currentposX, currentposY,,, CoordGrid
	winmove, CoordGrid,, , % currentposY+16
	return

	~a:: gosub, RunKey
	~b:: gosub, RunKey
	~c:: gosub, RunKey
	~d:: gosub, RunKey
	~e:: gosub, RunKey
	~f:: gosub, RunKey
	~g:: gosub, RunKey
	~h:: gosub, RunKey
	~i:: gosub, RunKey
	~j:: gosub, RunKey
	~k:: gosub, RunKey
	~l:: gosub, RunKey
	~m:: gosub, RunKey
	~n:: gosub, RunKey
	~o:: gosub, RunKey
	~p:: gosub, RunKey
	~q:: gosub, RunKey
	~r:: gosub, RunKey
	~s:: gosub, RunKey
	~t:: gosub, RunKey
	~u:: gosub, RunKey
	~v:: gosub, RunKey
	~w:: gosub, RunKey
	~x:: gosub, RunKey
	~y:: gosub, RunKey
	~z:: gosub, RunKey

	Runkey:
    global winc_presses
    winc_presses += 1
		if winc_presses = 2  
		{
			NavigateToCoord()
      winc_presses = 0
		}
		Return	

	NavigateToCoord()
	{
		CoordMode, Mouse, Window
		global numberOfRows, numberOfCols, rowSpacing, colSpacing, customDPI

		XCoordInput := SubStr(A_ThisHotkey,2,1)
		YCoordInput := SubStr(A_PriorHotkey,2,1)
		XCoordToUse := ConvertInputCoord(XcoordInput, "X")
		YCoordToUse := ConvertInputCoord(YcoordInput, "Y")

		XCoord := (XCoordToUse+0.26) * colSpacing * customDPI
		YCoord := (YCoordToUse-0.60) * rowSpacing * customDPI


		MouseMove, %XCoord%, %YCoord%, 0
		Gui Hide
;		Click
		Return
	}

	ConvertInputCoord(coordInput, XorY)
	{
		global AscA
		coordAsc := Asc(coordInput)
		if (XorY = "X") {
			coordToUse := coordAsc - AscA
		}
		else {
			coordToUse := coordAsc - AscA + 1
		}
		coordToUse := floor(coordToUse) 
		Return coordToUse
	}
#IfWinActive

^!r::Reload
