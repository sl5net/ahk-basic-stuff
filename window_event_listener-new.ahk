#SingleInstance,Force

SetTitleMatchMode, RegEx
; # IfWinActive, \.ahk\b
; #IfWinActive,
; ~^s::reload_if_StrgS()

#Include *i %A_ScriptDir%\inc_ahk\init_global.init.inc.ahk
;MsgBox,% ">" A_PriorKey "< = A_PriorKey"

CoordMode, ToolTip,Screen
;/¯¯¯¯ while ¯¯ 190325093026 ¯¯ 25.03.2019 09:30:26 ¯¯\
while(1){
	SetTitleMatchMode 3
	if(A_AhkVersion >= 2){
		; WinWaitNotActive(at) ; v2 Style
		; at := WinGetTitle("A") ; v2 Style
	}else{
		WinWaitNotActive, % at ; v1 Style
		WinGetTitle, at, A ; v1 Style
	}
	
	Gosub,lbl_frazeBlock
	;Gosub,lbl_YouTubelbl_YouTube
	
	if(RegExMatch(at,needle:="(?P<_n>Front Page \| ReactOS Project)",found)){
		ToolTip1sec(A_LineNumber " " RegExReplace(A_LineFile,".*\\"))
		Send, ^w ; v2 Style
		run, https://reactos.org/getbuilds/
		; MsgBox( found_n  , found_n "`n(" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")" )
	}
	
	if(RegExMatch(at,needle:="(?P<_n>\.pdf)",found)){
		ToolTip1sec(A_LineNumber " " RegExReplace(A_LineFile,".*\\"))
		; MsgBox,262208,% ":)`n" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ,% msg "`n(" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")"
	}
	
}
;\____ while __ 190325093032 __ 25.03.2019 09:30:32 __/

MsgBox, just started 19-04-06_09-53

; openDB_Browser_for_SQLite()
openDB_Browser_for_SQLite(d:="",t:="Words",doClickIntoSearch:=true,search:="someNew2secTooltip"){
	ToolTip1sec(A_LineNumber " " RegExReplace(A_LineFile,".*\\"))
	if(!d)
		d := (InStr(A_ComputerName,"540P-SL5NET"))
	? "G:\fre\private\sql\sqlite\actionList.db" 
	: A_ScriptDir "\actionListLearned.db" 
	
	settitlematchmode,1
	needle=DB Browser for SQLite ; ahk_class Qt5QWindowIcon
	ifwinnotexist, % needle
	{
            ; https://github.com/sqlitebrowser/sqlitebrowser/wiki/Command-Line-Interface
		para := " -t " t " " d " --t " t
		commandline = "C:\Program Files\DB Browser for SQLite\DB Browser for SQLite.exe" %para%
		;clipboard := commandline
		clipboard := search		
		run,% commandline ,"C:\Program Files\DB Browser for SQLite\"
		ToolTip2sec(commandline "`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")",100,100 )
		winwait, % needle,,9
		WinActivate, % needle
		WinWaitActive, % needle,,9
		send,!tw ; w like words ; send,{tab 4}w ; w like words
		CoordMode , Mouse, Relative
		MouseClick,left,331,230,1,1
		CoordMode , Mouse , Screen	
		Send,^v
	}
	RETURN
}

;/¯¯¯¯ lbl_YouTube ¯¯ 190419180508 ¯¯ 19.04.2019 18:05:08 ¯¯\
;/¯¯¯¯ lbl_YouTube ¯¯ 190419180508 ¯¯ 19.04.2019 18:05:08 ¯¯\
;/¯¯¯¯ lbl_YouTube ¯¯ 190419180508 ¯¯ 19.04.2019 18:05:08 ¯¯\
;/¯¯¯¯ lbl_YouTube ¯¯ 190419180508 ¯¯ 19.04.2019 18:05:08 ¯¯\
lbl_YouTube:
titYouTube=- YouTube - Google Chrome ; ahk_class Chrome_WidgetWin_1 ; mouseWindowTitle=0x3e0796  ; 
	; jump out of advertisment 19-04-18_07-35
if(RegExMatch(at,needle:="(?P<_n>" titYouTube ")",found))	
{
	WinGetPos, wX, wY, wW, wH, A
	SoundBeep,2500
	SoundGet, master_volume
	SoundSet, 5  
	Sleep,500
	Sleep,1500 ; it takes time before NextButton becomes visible
	yt_video_shorter_then_a_minute := ""
	; yt_video_shorter_then_a_minute := "|<d>*92$37.zzzzzzzzzzzzzzzzzzzzzzzzzzwzkDzzwzk3zzyTttzzyDswMzzDwSATzbyD7zzbz7XzznzXlzzlzlszztzswTzwzwSDrwzzDDzyTzU77yDzs7XzDzzzzzzzzzzzzzzzzzzzzzzy"
	; yt_video_shorter_then_a_minute .= "|<a>*160$35.zzzzzzzzzzzzzXz0zzzDw0zzyTttzzsznlXznz7X7zbyDbzyTwTDzwzsyTzlzlwzzbzXlzzDzbXzwzzDDztzy0QTnzz1szDzzzzzzzzzzU"		
	NextButton := ""
	; NextButton :="|<>*163$47.zzzzzzzzzzzzzzzzzvzzXzzzzlzz7zzzzVzyDzzzz0zwTzzzy0zszzzzw0Tlzzzzs0TXzzzzk0T7zzzzU0CDzzzz00QTzzzy01szzzzw0Dlzzzzs0zXzzzzk7z7zzzzUTyDzzzz3zwTzzzyDzszzzzxzzlzzzzzzzzzzzzzzzzzzs"
	; NextButton_whiteOnBlack :="|<>*116$35.zzzzzzzzzzzzzbzy7zz7zwDzy3zsTzw3zkzzs1zVzzk1z3zzU0y7zz00wDzy00sTzw01kzzs07Vzzk0T3zzU3y7zz0DwDzy1zsTzw7zkzzszzVzznzz3zzzzzzw"
	yt_overjump_rithBottom :="|<>*116$41.zzzzzzzzzzzzzzzzzzzzzzzzzzzzzwzzkzzzszzVzzzkTz3zzzUTy7zzz0DwDzzy0DsTzzw07kzzzs07Vzzzk073zzzU0C7zzz00wDzzy03sTzzw0Tkzzzs1zVzzzkDz3zzzUzy7zzz7zwDzzyTzsTzzzzzzzzzzzzzzU"
	; NextButton .= NextButton_whiteOnBlack
	NextButton .= yt_overjump_rithBottom
	; yt_video_shorter_then_a_minute .= NextButton ; maybe only search NextButton next time 19-04-18_08-01
	
	if(0){
		if (ok:=FindText(0, 0, A_ScreenWidth, A_ScreenHeight, 0.12, 0.12, yt_overjump_rithBottom))
		{
			CoordMode, Mouse
			X:=ok.1.1, Y:=ok.1.2, W:=ok.1.3, H:=ok.1.4, Comment:=ok.1.5, X+=W//2, Y+=H//2
  ; Click, %X%, %Y%
			for i,v in ok
				if i<=2
				{
					MouseMove,v.1+v.3//2, v.2+v.4//2
					MouseTip(v.1+v.3//2, v.2+v.4//2)
				}
			
			MsgBox,found 19-04-22_08-
		}
		
	}
	
	; if( ok:=FindText(wX, wY+wH-300,wW,300, tolerant1:=0, tolerant2:=0, NextButton )) ;  yt_video_shorter_then_a_minute
	if(1 && ok:=FindText(wX+300, wY+wH-300,wW-300,300, tolerant1:=0, tolerant2:=0, yt_overjump_rithBottom )) ;  yt_video_shorter_then_a_minute
	; if (0 && ok:=FindText(0, 0, A_ScreenWidth, A_ScreenHeight, 0, 0, yt_overjump_rithBottom))
	{ 	
		X:=ok.1.1, Y:=ok.1.2, W:=ok.1.3, H:=ok.1.4, Comment:=ok.1.5, X+=W//2, Y+=H//2
		CoordMode, Mouse
		MouseMove,% X ,% Y+50 ; MouseClick,left,% X+50,% Y	; Sleep,10
		; MouseClick,left,% X, % (Y + 250)	; Sleep,10
			; Click,% X+90,% Y	; Sleep,10
		; MsgBox,found 19-_09
		
		
		if(0){
			Sleep,1500
			
			; >|
			if( ok:=FindText(wX+wW//2, wY+wH-400,wW//2,400, tolerant1:=0.4, tolerant2:=0.2, NextButton))
				; if(wX && ok:=FindText(wX+wW//2, wY+wH-300,wW//2,300, tolerant1:=0, tolerant2:=0, NextButton))
			{
				X:=ok.1.1, Y:=ok.1.2, W:=ok.1.3, H:=ok.1.4, Comment:=ok.1.5, X+=W//2, Y+=H//2
				; MouseMove,% X+50 ,% Y
				CoordMode, Mouse
				MouseClick,left,% X,% Y	
				; Click,% (X+50),% Y	
				SoundBeep,1000,1000
			}
		}
		
		if(master_volume<10)
			master_volume := 50
		SoundSet,% master_volume
		SoundBeep,1000,1000
		return
		
		
	}
	
}




needle=Google Contacts - Google Chrome ahk_class Chrome_WidgetWin_1
IfWinActive, % needle
{
	WinGetPos, wX, wY, wW, wH, % needle ; https://www.autohotkey.com/boards/viewtopic.php?f=6&t=17834&p=271791#p271791
	
	
	
	if(clipboard && RegExMatch(clipboard,"^\d+$")){			; Telefonnummer 01712102515
		SoundBeep,4300,1000
		Telefonnummer:="|<>*220$59.0000000000000A00s001zs0M03U000A00k060000M01U0A0000k731lyD1S1Uv6CkkvXi313AElV16A662NUX6388ADwnz6A6EEMM1a0AMAUUkk3A0MkN11UU680kUW231nAQlVr4461wMT31s880000000008"			
		if(wX && ok:=FindText(wX, wY+200,wX+wW,wY+wH-300, tolerant1:=0, tolerant2:=0, Telefonnummer)){ ; findTextTool_demo_backwardsLoop_bottomTooTop(ok)
				;CoordMode, Mouse
			X:=ok.1.1, Y:=ok.1.2, W:=ok.1.3, H:=ok.1.4, Comment:=ok.1.5, X+=W//2, Y+=H//2
			MouseClick,left,% X+90,% Y	; Sleep,10
			Send,^v
		} else{
			SoundBeep,3000,1000
				; break
			return
		}
	}
	
	
	
	
	if(0 && RegExMatch(clipboard,"\@")){ 
		SoundBeep,2000,1000
		SoundBeep,2000,1000
		email:="|<>*220$49.0000001XDw1k300la00s3U00n00Q1k00NU0D1sS6Ak06UwNX6M03MK8NXDs1gP0Ala0ymBVyMn00NYlXANU0AKNVaAk06CAkn6M0376BtXDw1VX3glU00000004"
		
		email:="|<>**50$46.zk20A0160040E00M00E5001U00U47160022FW4M00c948FjU2EY0l60S94Ex4M00aF44FU0284El6008cF34M00VV6IFzk244CF6"
		
		
		email:="|<>*194$21.Tzzrzzzs00zU0Dz07yQ1nkssS3y3k70S003k00S003k00S003k00TzzzTzzo"
		Text :="|<>*194$21.Tzzrzzzs00zU0Dz07yQ1nkssS3y3k70S003k00S003k00S003k00TzzzTzzo"
		
		if (ok:=FindText(0, 0, A_ScreenWidth, A_ScreenHeight, 0, 0, email))
		{
			X:=ok.1.1, Y:=ok.1.2, W:=ok.1.3, H:=ok.1.4, Comment:=ok.1.5, X+=W//2, Y+=H//2
			Click, % (X + 190), %Y%
			Send,^v
				; Click, % X +190, %Y%
			for i,v in ok
				if i<=2
					MouseTip(v.1+v.3//2, v.2+v.4//2)
			
		} else{
			SoundBeep,3000,1000
				;break
		}
		
			; MsgBox, end of email 1_23-07 
	}
	
	Comment:=ok.1.5, X+=W//2, Y+=H//2
	MouseClick,left,% X+90,% Y	; Sleep,10		
	
	
	
	FirmaText:="|<>*221$69.0000000000631U00000000kMA01U00000631U0A000000kMAr7kw/BkC6v1bAAAltn7QtMAklX3AA8la31a6AMN1Vg4kMAklXz8ABza31a6AM11Vg0kMAklX08ABU631a6AM11Va0kAsklVb8AAta0y6667V1VVsk000000000004"
	if(0 && wX && ok:=FindText(wX, wY,wX+wW,wY+wH, tolerant1:=0, tolerant2:=0, FirmaText)) ; findTextTool_demo_backwardsLoop_bottomTooTop(ok)
		for i,v in ok ;  forward loop (top to bottom)
			if(i<=1){ ; how many immages 2 is good for demo ; ; MouseTip(v.1+v.3//2, v.2+v.4//2)
				X:=v.1+v.3//2, Y:=v.2+v.4//2, W:=ok.1.3, H:=ok.1.4,
				Send,^apragmatic minds
			} else{
		SoundBeep,3000,1000
		break
	}
}

return
;\____ lbl_YouTube __ 190419180523 __ 19.04.2019 18:05:23 __/
;\____ lbl_YouTube __ 190419180523 __ 19.04.2019 18:05:23 __/
;\____ lbl_YouTube __ 190419180523 __ 19.04.2019 18:05:23 __/
;\____ lbl_YouTube __ 190419180523 __ 19.04.2019 18:05:23 __/
;\____ lbl_YouTube __ 190419180523 __ 19.04.2019 18:05:23 __/



;/¯¯¯¯ lbl_frazeBlock ¯¯ 190423093041 ¯¯ 23.04.2019 09:30:41 ¯¯\
;/¯¯¯¯ lbl_frazeBlock ¯¯ 190423093041 ¯¯ 23.04.2019 09:30:41 ¯¯\
;/¯¯¯¯ lbl_frazeBlock ¯¯ 190423093041 ¯¯ 23.04.2019 09:30:41 ¯¯\
lbl_frazeBlock:
tFrazeBlock=Generation Giordano - Mozilla Firefox ahk_class MozillaWindowClass
tFrazeBlock=Generation Giordano - Mozilla Firefox
if(RegExMatch(at,pattern := "(?P<_n>" tFrazeBlock ")",found))	
{
	Sleep,3000
	tGenerationtTextMehrAnzeigen190423_0944 := "|<>*166$71.00000000000000000000000000MA0800000000kM0E00000001kk0U00000002XXlwS1wiD0055AH4k49W0008+EY900G4400GYzcG07Y8800Z90EY0l8EU01CG0V812EW002Aa92E2AV8nA4F7W4U7d2y000000000000000000000004"
	Text := tGenerationtTextMehrAnzeigen190423_0944 
	if (0 && ok:=FindText(0, 0, A_ScreenWidth, A_ScreenHeight, 0, 0, Text))
	{
		CoordMode, Mouse
		X:=ok.1.1, Y:=ok.1.2, W:=ok.1.3, H:=ok.1.4, Comment:=ok.1.5, X+=W//2, Y+=H//2
		Click, %X%, %Y%
		Last_A_This:=A_ThisFunc . A_ThisLabel 
		ToolTip1sec(" (" A_LineNumber " " RegExReplace(A_LineFile,".*\\") " " Last_A_This)
		SoundBeep,1500, 1000
	}else{
		
		WinGetPos, wX, wY, wW, wH, A
		if(1){
		 tip = %wX%, %wY%, %wW%, %wH%
		 rectangleTip(wX,wY,wW,wH) 
		 ToolTip9sec( tip "`n (" A_LineNumber " " RegExReplace(A_LineFile,".*\\") " " Last_A_This)
		}
 
 
 		; if(ok:=FindText(wX, wY,wW,wH, tolerant1:=0, tolerant2:=0, Text )){
		if(ok:=FindText(wX, wY,wW,wH, 0, 0, Text ))
		{
			CoordMode, Mouse
			
			i := ok.MaxIndex()
			while(ok[i] && i){ 
				X:=ok[i].1+ok[i].3//2, Y:=ok[i].2+ok[i].4//2, W:=ok.1.3, H:=ok.1.4, Comment:=ok.1.5, X+=W//2, Y+=H//2
				if(1)
					MouseMove,% X+50 + mod(A_Index,2)*40,% Y ; MouseClick,left,% X+50,% Y
				else
					MouseClick,left,% X,% Y
				i--
			}
	 		
			if(forwardLoop_topTooBottom){
				for i,v in ok {
					MouseMove, X:=v.1+v.3//2, Y:=v.2+v.4//2
				; MouseClick,left, X:=v.1+v.3//2, Y:=v.2+v.4//2
				}
			}
			Last_A_This:=A_ThisFunc . A_ThisLabel 
			ToolTip9sec(" (" A_LineNumber " " RegExReplace(A_LineFile,".*\\") " " Last_A_This)
			SoundBeep,1500, 500
			SoundBeep,2500, 500
			SoundBeep,1500, 500
		}
		; Gui, _rectangleTip_: Destroy			
	}
	; SoundBeep,3500, 1000
} 
return
;\____ lbl_frazeBlock __ 190423093053 __ 23.04.2019 09:30:53 __/
;\____ lbl_frazeBlock __ 190423093053 __ 23.04.2019 09:30:53 __/
;\____ lbl_frazeBlock __ 190423093053 __ 23.04.2019 09:30:53 __/



#Include *i %A_ScriptDir%\inc_ahk\functions_global.inc.ahk
#Include *i %A_ScriptDir%\inc_ahk\functions_global_dateiende.inc.ahk
#Include *i %A_ScriptDir%\inc_ahk\UPDATEDSCRIPT_global.inc.ahk

#Include *i %A_ScriptDir%\inc_ahk\findTextTool.inc.ahk
; #Include *i %A_ScriptDir%\inc_ahk\..\findTextTool.inc.ahk
