;display the date and time, useful for print screen

#Include *i %A_ScriptDir%\inc_ahk\init_global.init.inc.ahk
#singleinstance force
#NoTrayIcon
; SetTimer,timerLbl2000,2000 ; ; 30.08.2018 13:52 it sometimes happesn. and if it happens then its really ugly !!!! :( !!
; SetTimer,lblCheckTrayIconStatus,100 ; ; 30.08.2018 13:52 it sometimes happesn. and if it happens then its really ugly !!!! :( !!

;/¯¯¯¯ countdown ¯¯ 190401154248 ¯¯ 01.04.2019 15:42:48 ¯¯\
;countdown modus
global g_timeStart 
g_timeStart := true ; then its countdown
g_timeStart := false ; then its just a clock
if(g_timeStart){
	MsgBox,Start countdown ?
	g_timeStart := A_TickCount + 1000*60*60 ; then its a countdowns
	; g_timeStart := A_TickCount + 5005 ; then its a countdowns
}
;\____ countdown __ 190401154251 __ 01.04.2019 15:42:51 __/
else{
	SetTimer,lblReload,% 60000 * 2 ; reload every minutes. sometimes the seconds ar not readabls. reload helps. quick and dirty 19-01-30_10-56
}
; Get Current Position
SysGet,Mon_BboxNew_,Monitor,0
fondo := Mon_BboxNew_Bottom - 17




Gui, +AlwaysOnTop +ToolWindow -SysMenu -Caption
Gui, Color, green
Gui, Font,  cWhite s10 q1, Arial Narrow ;red ; changed s11 to s10
;Gui, Font, c000000 s7 , verdana ;black
;Gui, Font, cFFFFFF s7 , verdana ;white
; Gui, Add, Text, vD y0 BackgroundTrans, %A_YYYY%-%A_MM%-%A_DD% %a_hour%:%a_min%:%a_sec%
str := getTimeStr(doMaybeTimer:=false)
Gui, Add, Text, vD y0 , %str%



Gui, Show, NoActivate x-9 y%fondo%,uptime ; screen position here
; WinSet, TransColor, Off, uptime 
;WinSet, TransColor, green 255,uptime ; 255 is max tansparent
SetTimer, RefreshD, 1000



if(0){
	Gui, +AlwaysOnTop +ToolWindow -SysMenu -Caption
	Gui, Color, black
	Gui, Show, NoActivate x-9 y%fondo%,Background ; screen position here
	WinSet, TransColor, black 75,Background
}


; Listen for desktop resize events
OnMessage(0x7E, "WM_DISPLAYCHANGE")
return



; Refresh every second
RefreshD:
isFullScreen := isWindowFullScreen("A")

; year2 := substr(A_YYYY,3,2)
year2 := substr(A_DDD,1,2)
; dd := substr(A_DDD,1,2)
; texto = %year2%-%A_MM%-%A_DD% %a_hour%:%a_min%:%a_sec%
texto := getTimeStr()
; ToolTip,% texto
if (0 && isFullScreen) {
	texto := ""
}
WinSet, AlwaysOnTop, On, uptime
;GuiControl, , D, %A_YYYY%-%A_MM%-%A_DD% %a_hour%:%a_min%:%a_sec%
GuiControl, , D, %texto%

return

getTimeStr(doMaybeTimer:=true){
	
	if(doMaybeTimer && g_timeStart){
		sec := Floor( ( g_timeStart - A_TickCount )/1000 )
		if(sec > 0){
			;toolTipGui(sec,,,"title5")
			min := Floor( sec/60 )
			restSec := sec - min * 60
			ret = %min%:%restSec% min 
			return ret
		}
	}
	ret = %A_DDD%%A_DD%.%A_MM% %a_hour%:%a_min%:%a_sec% 
	return ret
}



; If window is full screen turn off clock
isWindowFullScreen( winTitle ) {
;checks if the specified window is full screen
	
	winID := WinExist( winTitle )
	
	If ( !winID )
		Return false
	
	WinGet style, Style, ahk_id %WinID%
	WinGetPos ,laX,,winW,winH, %winTitle%
; 0x800000 is WS_BORDER.
; 0x20000000 is WS_MINIMIZE.
; no border and not minimized
	Return ( laX != 0 or ((style & 0x20800000) or winH < A_ScreenHeight or winW < A_ScreenWidth) ) ? false : true
}


; On desktop resize
WM_DISPLAYCHANGE(wParam, lParam)
{
	SysGet,Mon_BboxNew_,Monitor,0
	fondo := Mon_BboxNew_Bottom - 20
	Gui, Show, NoActivate x0 y%fondo%,uptime ; screen position here
}

lblCheckTrayIconStatus:
showTempTrayIf_isNearTrayMenue(iconAdress)		
DetectHiddenWindows,Off
IfWinExist,%A_ScriptName%_icon,ExitApp %A_ScriptName% ; message from child DynaRun() script
{
	WinClose,%A_ScriptName%_icon
	ExitApp
}
return


timerLbl2000:
return

lblReload:
Reload
return

#Include *i %A_ScriptDir%\inc_ahk\functions_global.inc.ahk
;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
;~ subroutinen beispielsweise müsen ans Dateiende
#Include *i %A_ScriptDir%\inc_ahk\functions_global_dateiende.inc.ahk
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
#Include *i %A_ScriptDir%\inc_ahk\UPDATEDSCRIPT_global.inc.ahk 

