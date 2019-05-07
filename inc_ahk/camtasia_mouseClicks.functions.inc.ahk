; Indentation_style: https://de.wikipedia.org/wiki/EinrÃ¼ckungsstil#SL5small-Stil
mouseClick_Record(cRdoNothing, cRall){
	mouseClick_camtasia(cRdoNothing, cRall, -73 )
	return

}
mouseClick_deleteRecording(cRdoIsRec, cRall){
		mouseClick_camtasia(cRdoIsRec, cRall, -210 )
		;~ Sleep,700
		;~ Send,{Tab}
		;~ Sleep,700
		;~ Send,{Enter}
	return
}
mouseClick_camtasia(w, cRall, xP ){
	if(!w || !cRall  !xP)
	{
		MsgBox,Oops !w || !cRall !xP `n  15-05-21_23-34
		return
	}
	IfWinNotExist,%w% 
	{
		;~ MsgBox,%w% := w `n :( not exist `n  15-05-21_23-38
		return -1
	}
	
	WinGetActiveTitle,activeTitle
	WinGetPos,x,y,w,h,%w% 
	mx:= x + w + xP 
	my:=Round(y + h /2) + 20
	
	SetTitleMatchMode,2
	WinActivate,%activeTitle% 
	WinWaitNotActive,%cRall% 
	MouseMove2(mx,my)
	Sleep,1000
	MouseClick, left, %mx% , %my% ,1,50,D
	Sleep,1000
	MouseClick, left, %mx% , %my% ,1,50,U
	Sleep,1000
	return
}
