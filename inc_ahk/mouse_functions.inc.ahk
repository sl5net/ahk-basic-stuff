; Indentation_style: https://de.wikipedia.org/wiki/EinrÃ¼ckungsstil#SL5small-Stil
IfNotExist,init_global.init.inc.ahk
	MsgBox,init_global.init.inc.ahk :-( not exist
#Include *i init_global.init.inc.ahk


MouseMove2(x,y){
	CoordMode, Mouse, Screen 
	DllCall("SetCursorPos", int, x, int, y)
	return
}
;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
getMousePos(){
	CoordMode, Mouse, Screen 
	MouseGetPos,x , y, id, control
	p := {x:x, y:y}
	return p
}


;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
;~ includes
return  ; probably redundant. its more secure if we do that.
#Include *i %A_ScriptDir%\inc_ahk\functions_global.inc.ahk ; SL5_inc_autoloader_copy2subfolder_and_prepare.ahk
;~ http://www.autohotkey.com/board/topic/18513-wait-for-sound/
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
;~ subroutinen beispielsweise müsen ans Dateiende
return  ; probably redundant. its more secure if we do that.
#Include *i %A_ScriptDir%\inc_ahk\functions_global_dateiende.inc.ahk
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

