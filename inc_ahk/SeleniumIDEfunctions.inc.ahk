; Indentation_style: https://de.wikipedia.org/wiki/EinrÃ¼ckungsstil#SL5small-Stil
;gosub,setMouseToSeleniumIDE
setMouseToSeleniumIDE:
		IfWinNotActive,Selenium IDE
		WinActivate,Selenium IDE
		WinWaitActive,Selenium IDE
		MouseMove,120,  100,0
return


;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
;~ Gosub, clickOtherTab
clickOtherTab:

	MouseGetPos,x,y
	WinGetActiveTitle,W1206011216


	;MsgBox,countFrozen>%countFrozen%
	ToolTip,%A_LineNumber%: countFrozen>%countFrozen%
	Sleep,2000

	SetTitleMatchMode,2
	Loop,10
	{
		WinActivate,%Title1%
		WinWaitActive,%Title1%,,1
		IfWinActive,%Title1%
			break
	}
	
	Loop,20
	{
		SetTitleMatchMode,2
		ToolTip,%A_LineNumber%: WinWaitActive`,%Title1%
		WinWaitActive,%Title1%,,2
		IfWinNotActive,%Title1%
		{
								WinActivate,%W1206011216%
					ToolTip,WinWaitActive %W1206011216% 1
					WinWaitActive,%W1206011216%,,1
					ToolTip,					
					MouseMove,%x%,%y%,0

			return
}		
		xmax := A_ScreenWidth - 120
		xmin := 200
		;~ Random,xClick,200,xmax
		xClick := xClick + 99
		if(xClick > xmax)
			xClick:=xmin + (xClick - xmax)
		if(xClick < xmin)
			xClick := xmin + (xmin - xClick)
		
		;~ if( abs(xClickOld-xClick) < 200 )
			;~ Random,xClick,200,700

		xClickOld:=xClick
		;MouseClick, left,  %xClick%,72,1,50
		;MouseMove,%xClick%,72
		
		; funktionert zwar kann aber bei klick dazu führen das das tab geschlossen undnicht nur gewechelt wird (wenn kreuzle drunter)
		; aber bei 85 ist man unter dem kreuz. so kann fenster nicht geschlossen werden :) yeaaah
		DllCall("SetCursorPos", int, -xClick, int, 85)
		Click
		ToolTip,%A_LineNumber%: DllCall("SetCursorPos"  -%xClick%
		IfWinNotActive,%Title1%
			break
		Sleep,2000
		; try something else
		IfWinNotActive,%Title1%
			break
	}
;~ gosub,showCSVcontentWindow

					WinActivate,%W1206011216%
					ToolTip,WinWaitActive %W1206011216% 1
					WinWaitActive,%W1206011216%,,1
					ToolTip,					
					MouseMove,%x%,%y%,0

return
