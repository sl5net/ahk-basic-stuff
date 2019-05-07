; Indentation_style: https://de.wikipedia.org/wiki/EinrÃ¼ckungsstil#SL5small-Stil
global g_CaretX_selectWord
global g_CaretY_selectWord

getSelectionFROMclipBoard( sleepDelay := 1){
return copySelectionFROMclipBoard( sleepDelay )
}
copySelectionFROMclipBoard( sleepDelay := 1){
    clipboardBackup := ClipboardAll
    c:=copySelection2clipBoard( sleepDelay )
    clipboard:=clipboardBackup
    return c
}

;<<<<<<<< copyWord2clipBoard <<<< 171120165205 <<<< 20.11.2017 16:52:05 <<<<
copyWord2clipBoard(doSelect:=true){
;msgbox,not implemented 17-08-08_17-58
   if(doSelect){
      selectWord()
   }
   Sleep,1200
   sleepDelay:=10
   c:=copySelection2clipBoard(sleepDelay)
   return c
}
;>>>>>>>> copyWord2clipBoard >>>> 171120165211 >>>> 20.11.2017 16:52:11 >>>>

;<<<<<<<< selecWord <<<< 180112200236 <<<< 12.01.2018 20:02:36 <<<<
selectLine(){
   Suspend,On
   while( GetKeyState("Ctrl", "P") ){
      send,{CtrlUp}
      Sleep,10
      ;ToolTip,30
   }
   while( GetKeyState("Shift", "P") ){
      send,{ShiftUp}
      Sleep,10
      ;ToolTip,30
   }
   SetKeyDelay,-1
   send,{end}{ShiftDown}{home}{home}{ShiftUp}
   ;ToolTip,35
   Suspend,Off
}
;<<<<<<<< selecWord <<<< 180112200236 <<<< 12.01.2018 20:02:36 <<<<
selectWord(){
   p := getCaretPos()
   MouseGetPos,mouseX,mouseY,mouseWin
   SetMouseDelay,-1
   Suspend,On
   ;MouseMove,% CaretX, % CaretY,2
   MouseMove,% p["x"],% p["y"] , 0
   g_CaretX_selectWord := CaretX
   g_CaretY_selectWord := CaretY

   SetMouseDelay,20
   SetKeyDelay,50,50
   MouseClick,left,% p["X"] - 5 , % p["Y"],2
   SetMouseDelay,0
   MouseMove,% mouseX,% mouseY
   Suspend,Off
}
;>>>>>>> selecWord >>>> 180112200243 >>>> 12.01.2018 20:02:43 >>>>



;<<<<<<<<<<<<<<< copySelection2clipBoard <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
copySelection2clipBoard( sleepDelay := 1, loopCounterMAX := 100){
	doToolTipBackupFeedback:=false
	WinGetActiveTitle,at
   ;doToolTipBackupFeedback:=true
   ; version-timestamp of this function: 13.08.2017 11:56 17-08-13_11-56
	ClipboardBackup := ClipboardAll
	loopCounter:=0
  ;Msgbox,%c% `n (%A_ScriptName%~%A_LineNumber%)
	while(clipboard && loopCounter < loopCounterMAX){
		Clipboard:=""
		loopCounter += 1
		Sleep, %sleepDelay%
	}
  ;Msgbox,%c% `n (%A_ScriptName%~%A_LineNumber%)
	if(clipboard){
		Msgbox,ERROR %clipboard%=clipboard `n (%A_ScriptName%~%A_LineNumber%)
	}
	
	a_TimeIdleStart := A_TimeIdlePhysical ; A_TimeIdle ; 
	MouseGetPos,x0,y0
   ; A_TimeIdlePhysical Similar to above but ignores artificial keystrokes and/or mouse clicks whenever the corresponding hook (keyboard or mouse) is installed; that is, it responds only to physical events.
	SetKeyDelay,180,280
	loopCounter:=0
	while(!clipboard && loopCounter < loopCounterMAX){
		IfWinNotActive,%at%
			return
      ; be sure that cursor not aut of the carret this shortime
		if( GetKeyState("c","P") || GetKeyState("Ctrl","P")  ){ 
			a_TimeIdleStart := A_TimeIdlePhysical ; A_TimeIdle ; 
		}
		if(a_TimeIdleStart - 200 > A_TimeIdlePhysical){
			MouseGetPos,x1,y1 ; mouse movements dont stop the copy process
			if(x0 <> x1 || y0 <> y1){
				a_TimeIdleStart := A_TimeIdlePhysical ; A_TimeIdle ; 
				x0 := x1
				y0 := y1
			}else{
				if(doToolTipBackupFeedback)
					ToolTip,%loopCounter%: `n >%Clipboard%< `n (%A_ScriptName%~%A_LineNumber%)
				msg =
				(
				clipboard = >%clipboard%<
				a_TimeIdleStart = %a_TimeIdleStart%
				A_TimeIdlePhysical = %A_TimeIdlePhysical%
				)
				send,^z ; undo becouse mybe selection was overwritten with letter c 
				tooltip,% msg "(" A_LineNumber " " RegExReplace(A_LineFile,".*\\") ")"
				; eventually person has nothing selected, therfore no msgbox, 22.10.2018 11:08
			}
			if(doToolTipBackupFeedback)
				ToolTip,%loopCounter%: `n >%Clipboard%< `n (%A_ScriptName%~%A_LineNumber%)
         ;msgbox,%loopCounter%: `n >%c%<
		}
		SetKeyDelay,50,50 ; solves the bug that ^c sometimes (every minute) was only c. it replaced the selection with c. that was horroble
		; toolTip1sec( "Send,^c`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")" )
		IfWinNotActive,%at%
			return
		Send,^c
		
      ;:1:2: 3
		loopCounter += 1
		Sleep, %sleepDelay%
		if(doToolTipBackupFeedback)
			ToolTip,%loopCounter%: `n >%Clipboard%< `n (%A_ScriptName%~%A_LineNumber%)
	} ; endOfWhile
	
	if(doToolTipBackupFeedback)
		ToolTip,%loopCounter%: `n >%Clipboard%< `n (%A_ScriptName%~%A_LineNumber%)
	c:=Clipboard
	Clipboard := ClipboardBackup
	Suspend,Off
	if(!c){
		return false
	}
	return c ;
}
;>>>>>>>>>>>>>>> copySelection2clipBoard >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
	
	
	
	getLineOrWordFROMclipBoard(doSelectLine){
		return copyLineOrWordFROMclipBoard(doSelectLine)
	}
	copyLineOrWordFROMclipBoard(doSelectLine){
		clipboardBackup := ClipboardAll
		c:=copyLineOrWord2clipBoard(doSelectLine)
		clipboard:=clipboardBackup
		return c
	}
;<<<<<<<< copyLineOrWord2clipBoard <<<< 171103235019 <<<< 03.11.2017 23:50:19 <<<<
	copyLineOrWord2clipBoard(doSelectLine){
		Suspend,on
		if(doSelectLine){
			Send,{Home}{ShiftDown}
			Send,{ShiftDown}{End}
		}else  {
			Send,^{Left 3}{ShiftDown}  
			Send,{ShiftDown}^{Right 3}
		}
		Send,{ShiftUp}
		c:=copySelection2clipBoard()
		return c
	}
;>>>>>>>> copyLineOrWord2clipBoard >>>> 171103235025 >>>> 03.11.2017 23:50:25 >>>>
	
;<<<<<<<< copyLineOrWord2clipBoard <<<< 171103235019 <<<< 03.11.2017 23:50:19 <<<<
	copyDocumentText2clipBoard(){
		Suspend,on
		Send,{CtrlDown}{Home}
		Send,{ShiftDown}
		Send,^{End}
		Send,{ShiftUp}{CtrlUp}
		c:=copySelection2clipBoard()
		Suspend,off
		return c
	}
;>>>>>>>> copyLineOrWord2clipBoard >>>> 171103235025 >>>> 03.11.2017 23:50:25 >>>>
