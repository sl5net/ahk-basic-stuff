;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
;~ please use this ! as first line in every script before all includes! :)
isDevellopperMode:= true ; enthällt auch update script.
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
#Include *i %A_ScriptDir%\inc_ahk\init_global.init.inc.ahk
if(!iconAdress){
	msg := "Problem !iconAdress. means its empty 19-04-19_18-35" " (" A_LineNumber " " RegExReplace(A_LineFile,".*\\") " " 
	ToolTip4sec(msg)			
	MsgBox,% msg
}
; clipboard := iconAdress ;  E:\fre\public\Graf-Bilder\icon\abc123\ke.ico

#notrayicon
SetTimer,lblCheckTrayIconStatus,100 ; ; 30.08.2018 13:52 it sometimes happesn. and if it happens then its really ugly !!!! :( !!
SetTimer,timerLbl2000,2000 ; ; 30.08.2018 13:52 it sometimes happesn. and if it happens then its really ugly !!!! :( !!

; i addet ths lines and my problem with Copy+C is solved. 06.11.2018 11:19 or? lets try and see if its holdon
; no its not solved. maybe becouse a nother scripts disables the CTRLDOWN
#MaxHotkeysPerInterval 99000000
#HotkeyInterval 99000000
Process, Priority,, H ; <=== only use this if its not in a critical development 05.11.2018 13:20
; Process, Priority,, Normal
SetBatchLines, -1 ; used till 03.11.2018 18:51. thats okay. Use SetBatchLines -1 to never sleep (i.e. have the script run at maximum speed). The default setting is 10m
; SetBatchLines, 20ms ; addet 03.11.2018 18:51
; SetBatchLines, 10
SetKeyDelay, -1, -1
; SetWinDelay, -1 ; Sets the delay that will occur after each windowing command, such as WinActivate.
; SetWinDelay, 10
; SetControlDelay, -1 ; A short delay (sleep) is done automatically after every Control command that changes a control, namely Control, ControlMove, ControlClick, ControlFocus, and ControlSetText (ControlSend uses SetKeyDelay).
; SetControlDelay, 10

;g_config := {FuzzySearch: {enable: true, keysMAXperEntry: 6, doValueCopy: false, halloWorld: "Hello World 19-01-11_17-47" } }
;MsgBox, % g_config["FuzzySearch"]["halloWorld"] ; Approve

SetTimer,timerLbl2000,2000 ; ; 30.08.2018 13:52 it sometimes happesn. and if it happens then its really ugly !!!! :( !!

SetTimer,lblCheckTrayIconStatus,80 ; ; 30.08.2018 13:52 it sometimes happesn. and if it happens then its really ugly !!!! :( !!

; $^v:: ; for some reason this not works inside of keysEveryWhere .ahk
;   msgbox,v was pressed :) ; works NOT like expected (this case is ignored/ its not triggered) 
;   https://autohotkey.com/boards/viewtopic.php?f=5&t=53135&p=231754#p231754
; return 
; ^v:: ; for some reason this not works inside of keysEveryWhere.ahk
;   msgbox,v was pressed ; works NOT like expected (this case is ignored/ its not triggered) 
;   https://autohotkey.com/boards/viewtopic.php?f=5&t=53135&p=231754#p231754
; return

#notrayicon


#IfWinActive,Capture Image To Text And Find Text Tool ahk_class AutoHotkeyGUI
	esc::
closeKill_FindTextGUI()
Return

;/¯¯¯¯ FindText_GUI_CatchImage ¯¯ 190414180348 ¯¯ 14.04.2019 18:03:48 ¯¯\
WINf:
SetTitleMatchMode,2
#IfWinActive,
	#f::
Last_A_This:=A_ThisFunc . A_ThisLabel
ToolTip1sec(A_LineNumber . " " . A_ScriptName . " " . Last_A_This )
CoordMode, Mouse,Screen
CoordMode, Pixel,Screen
WinGetActiveTitle,at
WinGetClass,ac, A
WinGet, active_id, ID, A
wTit := "Capture Image To Text And Find Text Tool ahk_class AutoHotkeyGUI"
wTit2 := "FindText_GUI_CatchImage.ahk"
wCapture=Capture Image To Text ahk_class AutoHotkeyGUI ; mouseWindowTitle=0x261cfc  ; 
wCapture2=Capture Image To Text And Find Text Tool ahk_class AutoHotkeyGUI ; mouseWindowTitle=0x1c1f2e  ; 
DetectHiddenWindows,On

WinClose,% wCapture ,,,19
tooltip, WinWaitClose wCapture 19-04-14_17-11
WinWaitClose,% wCapture,,4
IfWinExist,
	MsgBox,"error " A_LineNumber 
Sleep,100

WinClose,% wTit 
tooltip, WinWaitClose 19-04-14_16-54,,,19
WinWaitClose,% wTit,,4
IfWinExist,
	MsgBox,"error " A_LineNumber 
Sleep,100

WinClose,% wTit2 ,,,19
; tooltip, WinWaitClose wTit2 19-04-14_16-56
tooltip,% A_LineNumber ,,,19
WinWaitClose,% wTit2,,4
IfWinExist,
	MsgBox,"error " A_LineNumber 
tooltip,,,,19

run,FindText\FindText_GUI_CatchImage.ahk
SetTitleMatchMode,1
DetectHiddenWindows,Off
tooltip,winwait,,,19
winwait,% wTit

tooltip, ,,,19
ControlClick,Button1,% wTit

WinWaitClose,% wTit
winwait,% wTit2,,,19

tooltip,% A_LineNumber ,,,19
WinWait,% wCapture
WinGetPos,wX,wY
tooltip,% A_LineNumber ,,,19
;Sleep,100 ; works? no
Sleep,400 ; works? yes 19-04-15_18-51
MouseClick,left,% wX + 32,% wY + 70,2
;MouseClick,left,% wX + 35,% wY + 65,2
; Sleep,15

/*
	needle=Introduction to Java 8 - YouTube - Google Chrome ahk_class Chrome_WidgetWin_1
	tIntroductitText:="|<>*92$37.zzzzzzzzzzzzzzzzzzzzzzzzzzwzkDzzwzk3zzyTttzzyDswMzzDwSATzbyD7zzbz7XzznzXlzzlzlszztzswTzwzwSDrwzzDDzyTzU77yDzs7XzDzzzzzzzzzzzzzzzzzzzzzzy"
	WinGetPos, wX, wY, wW, wH, % needle ; https://www.autohotkey.com/boards/viewtopic.php?f=6&t=17834&p=271791#p271791
	if(wX && ok:=FindText(wX, wY,wX+wW,wY+wH, tolerant1:=0.3, tolerant2:=0.1, tIntroductitText)) ; findTextTool_demo_backwardsLoop_bottomTooTop(ok)
		for i,v in ok
			MouseMove, X:=v.1+v.3//2, Y:=v.2+v.4//2
; if(ok:=FindText(wX, wY,wX+wW,wY+wH, tolerant1:=0.3, tolerant2:=0.1, t%shortTit%tText))){
; X:=ok.1.1, Y:=ok.1.2, W:=ok.1.3, H:=ok.1.4, Comment:=ok.1.5, X+=W//2, Y+=H//2
; MouseMove,% X+50,% Y ; MouseClick,left,% X+50,% Y
	#Include *i %A_ScriptDir%\inc_ahk\findTextTool.inc.ahk
	#Include *i %A_ScriptDir%\inc_ahk\..\findTextTool.inc.ahk
*/


; works
; Sleep,100 ; works? no
Sleep,1000 ; works?
; useless becouse it has already the focus: ControlClick,Button10,% wCapture ;Gray2Two  
;msgbox,??????? 19-04-15_18-35
tooltip,% A_LineNumber ,,,19
;WinWaitActive,% wCapture
;Send,{tab}{space}
ControlClick,Button10,% wCapture ;Gray2Two  
Send,{space}
Sleep,100 ; works?
tooltip,% A_LineNumber " waiting for your user decision" ,,,19
Send,{tab 7}
;MsgBox, 19-04-14_17-07
tooltip,% A_LineNumber " waiting for your user decision" ,,,19

SetTitleMatchMode,3
WinWaitClose,% wCapture
;Sleep,100
tooltip,% A_LineNumber ,,,19
winwait,% wCapture2


text:=""
while(!text && A_Index <20){
	sleep,50
	ControlGetText,text,Edit2,% wTit 
}
textFound := RegExMatch(text,"m)^(Text[^\n]+)",match)
; text := RegExReplace(text,"m).*\b(Text\:\=""[^""]+"").*","$1")
if(strlen(match1)>500)
{
	MsgBox, prob to long 19-04-14_17-44
	return
}
if(strlen(text)<10)
{
	MsgBox, prob to small 19-04-14_17-44
	return
}
if(strlen(match1)<10)
{
	MsgBox, 1=%match1% prob to small 19-04-14_17-44 0=%match0%
	return
}
clipboard := match1 "`n"
Sleep,100
tooltip,% A_LineNumber "`n" match1,,,19

ControlClick,Button2,% wTit ; Test
tooltip,  ,,,19
SuccessProcent := 0

SetTitleMatchMode,RegEx
wSuccess=\d+ ahk_class #32770 ; mouseWindowTitle=0x312060  ; 
tooltip,% A_LineNumber "`n" match1,,,19
WinWait,% wSuccess,Success
WinClose,% wSuccess,Success
WinWaitClose,% wSuccess,Success
SuccessProcent := 100
tooltip,% A_LineNumber ,,,19


while(0){ ; works not at the moment 19-04-14_19-09 https://www.autohotkey.com/boards/viewtopic.php?f=76&t=63641&p=272688#p272688
	IfExist,% wSuccess,Success
	{
		SuccessProcent := 100
		WinClose,% wSuccess,Success
		tooltip,% A_LineNumber ,,,19
		WinWaitClose,% wSuccess,Success
	}
	IfWinNotExist,% wCapture
		SuccessProcent := 100
	if(SuccessProcent)
		Break
	WinGetActiveTitle,atTemp
	tooltip,% A_LineNumber ,,,19
	WinWaitNotActive,% atTemp,,20
}
if(SuccessProcent)
	WinClose, % wCapture

DetectHiddenWindows,On
tooltip,% A_LineNumber ,,,19
WinWaitNotActive, % wCapture,,3
;WinWaitClose, % wCapture,
tooltip,,,,19
; WinActivate,ahk_id %active_id%

SetTitleMatchMode,1
WinActivate,AHK Studio
WinWaitActive,AHK Studio

;Msgbox,% match1
;return

shortTit := RegExReplace(substr(at,1,10),"\W+","_")

titleStr=needle=%at% ahk_class %ac%
t = 
(
/*
	%titleStr%
	t%shortTit%t%match1%
	WinGetPos, wX, wY, wW, wH, `% needle ; https://www.autohotkey.com/boards/viewtopic.php?f=6&t=17834&p=271791#p271791
	if(wX && ok:=FindText(wX, wY,wX+wW,wY+wH, tolerant1:=0.3, tolerant2:=0.1, t%shortTit%tText)) ; findTextTool_demo_backwardsLoop_bottomTooTop(ok)
		for i,v in ok
			MouseMove, X:=v.1+v.3//2, Y:=v.2+v.4//2	
; if(ok:=FindText(wX, wY,wX+wW,wY+wH, tolerant1:=0.3, tolerant2:=0.1, t`%shortTit`%tText))){
; X:=ok.1.1, Y:=ok.1.2, W:=ok.1.3, H:=ok.1.4, Comment:=ok.1.5, X+=W//2, Y+=H//2
; MouseMove,`% X+50,`% Y ; MouseClick,left,`% X+50,`% Y
	#Include *i `%A_ScriptDir`%\inc_ahk\findTextTool.inc.ahk
	#Include *i `%A_ScriptDir`%\inc_ahk\..\findTextTool.inc.ahk
	*/
	)
c0 := "`n`n" t "`n`n`n"
	; MsgBox,% c0
tooltip,% A_LineNumber ,,,19
sendByStrgV(c0)
	;sendClipboard(c0) ; or use something like Send,^v
tooltip, ,,,19

Return
;\____ FindText_GUI_CatchImage __ 190414180357 __ 14.04.2019 18:03:57 __/	










#ifwinActive,Mastodon - Google Chrome ahk_class Chrome_WidgetWin_1 ; mouseWindowTitle=0x4c21cc  ; downsensational 
	down::
 ; if(RegExMatch(at,needle:="(?P<_n>\.pdf)",found)){ }
; 4538 keysEveryWhere.ahk
/*
	Text:=""
	WinGetPos, wX, wY, wW, wH, % needle ; https://www.autohotkey.com/boards/viewtopic.php?f=6&t=17834&p=271791#p271791
	if(ok:=FindText(wX, wY,wX+wW,wY+wH, 0.3, 0.1, Text)) ; findTextTool_demo_backwardsLoop_bottomTooTop(ok)
		for i,v in ok ;  forward loop (top to bottom)
			if(i<=222){ ; how many immages 2 is good for demo ; ; MouseTip(v.1+v.3//2, v.2+v.4//2)
				X:=v.1+v.3//2, Y:=v.2+v.4//2, W:=ok.1.3, H:=ok.1.4, Comment:=ok.1.5, X+=W//2, Y+=H//2
				MouseMove,% X+50 + mod(A_Index,2)*40,% Y ; MouseClick,left,% X+50,% Y	; Sleep,10
			} else
		break
*/
return






;/¯¯¯¯ ARTE ¯¯ 190414232852 ¯¯ 14.04.2019 23:28:52 ¯¯\
; Example Video forwoard / rewind with left / right keys
; tested in fullscreen mode 19-04-14_23-38
; Works best with a dark Background 19-04-14_23-51
offset := 20
offset := 50
SetTitleMatchMode,2
#IfWinActive,ARTE - Google Chrome ahk_class Chrome_WidgetWin_1 ; mouseWindowTitle=0xdc1576  ; 
	right::
Text:="|<>*103$31.zs07zzs00zzs00Dzs003zs001zw000Tw000Dy0003z0001s0000k0000M0000A0000400002D0003zk001zs001zy000zzU00zzs00zzy01zw"
needle=ARTE - Google Chrome ahk_class Chrome_WidgetWin_1 ; mouseWindowTitle=0xdc1576  ; 
WinGetPos, wX, wY, wW, wH, A ; % needle ; https://www.autohotkey.com/boards/viewtopic.php?f=6&t=17834&p=271791#p271791
mX := wX + 200 , mY := wY + wH - 30 
;MouseMove, %wX%, 500,20
MouseGetPos,x1,y1
MouseMove, %mX%, %mY%,8
if(wX && ok:=FindText(wX, wY+wH-200,wX+wW,300, 0.2, 0.12, Text)) ; findTextTool_demo_backwardsLoop_bottomTooTop(ok)
	for i,v in ok
		if(i<2)
			MouseMove, X:=v.1+v.3//2, Y:=v.2+v.4//2	
MouseClickDrag, L, 0, 0, % offset, 3,,R
MouseMove, %x1%, %y1%,1
return

left::
Text:="|<>*103$31.zs07zzs00zzs00Dzs003zs001zw000Tw000Dy0003z0001s0000k0000M0000A0000400002D0003zk001zs001zy000zzU00zzs00zzy01zw"
needle=ARTE - Google Chrome ahk_class Chrome_WidgetWin_1 ; mouseWindowTitle=0xdc1576  ; 
WinGetPos, wX, wY, wW, wH, A ; % needle ; https://www.autohotkey.com/boards/viewtopic.php?f=6&t=17834&p=271791#p271791
mX := wX + 200 , mY := wY + wH - 30 
;MouseMove, %wX%, 500,20
MouseGetPos,x1,y1
MouseMove, %mX%, %mY%,8
if(wX && ok:=FindText(wX, wY+wH-200,wX+wW,300, 0.2, 0.12, Text)) ; findTextTool_demo_backwardsLoop_bottomTooTop(ok)
	for i,v in ok
		if(i<2)
			MouseMove, X:=v.1+v.3//2, Y:=v.2+v.4//2	
MouseClickDrag, L, 0, 0, % -offset, 3,,R
MouseMove, %x1%, %y1%,1
return
;\____ ARTE __ 190414232856 __ 14.04.2019 23:28:56 __/

SetTitleMatchMode,1
#IfWinActive,QTranslate ahk_class #32770 ahk_exe QTranslate.exe
	~^a:: 
Last_A_This:=A_ThisFunc . A_ThisLabel
ToolTip2sec("`n" A_LineNumber " " A_ScriptName "`n" Last_A_This )
Suspend,On
	;send,^c
c := copySelection2clipBoard()
if(strlen(c)<5){
	ToolTip9sec("ERROR: Oops to shoprt `n" A_LineNumber " " A_ScriptName "`n" Last_A_This )	
	Suspend,Off	
	Return
}
sleep,100
send,!{tab}
WinClose,QTranslate ahk_class #32770 ahk_exe QTranslate.exe
WinWaitClose,QTranslate ahk_class #32770 ahk_exe QTranslate.exe
sleep,100
; Send,^v
sendByStrgV(c)
;sendClipboard(c)
Suspend,Off
RETURN


; openDB_Browser_for_SQLite()
openDB_Browser_for_SQLite(d:="",t:="Words",doClickIntoSearch:=true){
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
		clipboard := commandline
		run,% commandline ,"C:\Program Files\DB Browser for SQLite\"
		ToolTip2sec(commandline "`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")",100,100 )
		winwait, % needle,,9
		WinActivate, % needle
		WinWaitActive, % needle,,9
		send,!tw ; w like words ; send,{tab 4}w ; w like words
		CoordMode , Mouse, Relative
		MouseClick,left,331,230,1,1
		CoordMode , Mouse , Screen	
	}
	RETURN
}


; 01.08.2019 - 31.01.2019 
; Clipboard := 1827.62 / 6 ; Einnahmen 304.603333
; Clipboard := 770 / 6 ; Gewinn 128.333333


~c::
Last_A_This:=A_ThisFunc . A_ThisLabel
ToolTip1sec(A_LineNumber . " " . A_ScriptName . " " . Last_A_This )
Suspend,On 
if(GetKeyState("Ctrl") =1 ){
	ToolTip5sec(clipboard "`n =clipboard(" A_LineNumber . " " . A_ScriptName . " " . Last_A_This ")" )
	send,^c
}else{
	; ToolTip5sec(clipboard "`n =clipboard(" A_LineNumber . " " . A_ScriptName . " " . Last_A_This ")" )
	loop,9
	{
		sleep,50
		if(GetKeyState("Ctrl") =1 ) ; check it again 22.10.2018 06:42
		{
			send,^z^c
			ToolTip5sec(clipboard "`n =clipboard(" A_LineNumber . " " . A_ScriptName . " " . Last_A_This ")" )
			break
		}
	}
}
Suspend,Off
Return

; cv0

~v::
Last_A_This:=A_ThisFunc . A_ThisLabel
ToolTip1sec(A_LineNumber . " " . A_ScriptName . " " . Last_A_This )
return
; Return
Suspend,On 
if(GetKeyState("Ctrl") =1 ){
	send,v
}else{
	send,v
	sleep,300
	if(GetKeyState("Ctrl") =1 ) ; check it again 22.10.2018 06:42
		send,^z^v
}
Suspend,Off
MsgBox,262208,% ":)`n" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ,% ":)`n(" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")"
Return

#IfWinActive,global-IntelliSense-everywhere-Nightly-Build
	~^+c::
fileAddress:=""
while(A_Index < 199 && !found){
	fileAddress := clipboard
	found := RegExMatch(fileAddress,"\.ahk$")
	sleep,10
}
if(!found){
	ToolTip8sec("ups. " fileAddress "`n`n`n(" A_LineNumber " " A_ScriptName " " Last_A_This )		
	return
}
;ToolTip8sec(fileAddress "`n`n`n(" A_LineNumber " " A_ScriptName " " Last_A_This )	
;oReturn

Send,^!+c ; Source/create_al_Address-functions.inc.ahk:374
Sleep,50
lineNumber := RegExReplace(clipboard,"^.*\:")
; msgbox,% lineNumber
; reload

ToolTip1sec(A_LineNumber . " " . A_ScriptName . " " . Last_A_This )
needle=AHK Studio
IfWinNotExist,% needle
{
	ToolTip8sec("return becouse now AHK Studio is runnding. (" A_LineNumber " " A_ScriptName " " Last_A_This )
	Return
}
WinActivate,% needle
send,^o
needle=Select File - AHK-Studio.ahk ahk_class #32770 ; mouseWindowTitle=0x3e0d44  ; 
WinWaitActive,% needle,,2
ifwinactive,% needle
{
	ToolTip8sec(fileAddress "`n`n`n(" A_LineNumber " " A_ScriptName " " Last_A_This )	
	sleep,100
	sendByStrgV(fileAddress)
	;sendClipboard(fileAddress)
;	Send,^v
	send,{enter}
	SetTitleMatchMode,2
	WinWaitActive,% fileAddress,,3
	IfWinNotActive,% fileAddress
		return
}else
	Return
WinWaitClose,% needle, , 6 
needle=AHK Studio
ifwinactive,% needle
{
	send,^g
	needle=Go To Line ahk_class #32770 ; mouseWindowTitle=0xbd09e0  ; 
	WinWaitActive, % needle , , 3
	IfWinNotActive, % needle 
		return
	; send,% lineNumber
	sendByStrgV(lineNumber)
	send,{enter}
}
return



#IfWinActive,Ordner suchen ahk_class #32770 ; mouseWindowTitle=0x110fc8  ; 
	^v::
needle=Ordner suchen ahk_class #32770 ; mouseWindowTitle=0x110fc8  ; 
send,{left 9}
Return

;/¯¯¯¯ QTranslateVoiceReader ¯¯ 190320120832 ¯¯ 20.03.2019 12:08:32 ¯¯\
; https://www.autohotkey.com/boards/viewtopic.php?f=6&t=62922
#IfWinActive,stop translating? (id=1903200938)
	Last_A_This:=A_ThisFunc . A_ThisLabel
ToolTip1sec(A_LineNumber . " " . A_ScriptName . " " . Last_A_This )
esc::
WinClose
return

#IfWinActive,QTranslate ahk_class #32770 ; ahk_exe QTranslate.exe
	esc::
Last_A_This:=A_ThisFunc . A_ThisLabel
ToolTip5sec(A_LineNumber . " " . A_ScriptName . " " . Last_A_This )
processing_results_QTranslateVoiceReader()
RETURN

QTranslateVoiceReader:
#IfWinActive,
	~^ö::
timeOutExpectedNothingWillChangeAnymore_Milli_default := 900 ; is default but to fast. translater is often slower then that, so its not workine
timeOutExpectedNothingWillChangeAnymore_Milli := timeOutExpectedNothingWillChangeAnymore_Milli_default
;timeOutExpectedNothingWillChangeAnymore_Milli := 550
timeOutExpectedNothingWillChangeAnymore_Milli := 7000 ; 8000 is sometimes to slow. mic i turned oftern off
WinGetActiveTitle, activeTitle
Last_A_This:=A_ThisFunc . A_ThisLabel
ToolTip1sec(A_LineNumber . " " . A_ScriptName . " " . Last_A_This )

; send,^ö 
winTitle := "QTranslate ahk_class #32770 ahk_exe QTranslate.exe"
tooltip,% "WinWaitActive (" A_LineNumber " " RegExReplace(A_LineFile,".*\\") ")"	
DetectHiddenWindows,Off
WinWaitActive,% winTitle,,3
tooltip,
IfWinNotActive,% winTitle
{
	Msgbox,,% ":( WinNotExistActive " winTitle " `n (" A_LineNumber " " RegExReplace(A_LineFile,".*\\") ")",,3
	return
}
; Wait until it doesn't change: 
transGerman := ""
transEnglish1 := ""
transEnglish2 := ""
transEnglish3 := ""
while(A_Index < 100){
	tip := "while (" A_LineNumber " " RegExReplace(A_LineFile,".*\\") ")"	
	ToolTip5sec(tip)
	Sleep,% timeOutExpectedNothingWillChangeAnymore_Milli ; <=========================
	If(!WinExist(winTitle)){
		; Msgbox,,% "`n (" A_LineNumber " " RegExReplace(A_LineFile,".*\\") ")",,3
		return
	}
	if(transGerman){ ; starts with a given german or is a stored froem below
		;  ; this is not working. if it starts again it deleting the old text. thats not usefull
		ControlGetText, transGermanTEST , RICHEDIT50W1, % winTitle			
		while(!instr(transGermanTEST,transGerman)){
			ControlSetText, RICHEDIT50W1, % transGerman transGermanTEST, % winTitle
			ControlSend, RICHEDIT50W1, {end}, % winTitle
			sleep,1500
			ControlGetText, transGermanTEST , RICHEDIT50W1, % winTitle			
		}
		while(transGermanTEST == transGerman){
			sleep,500
			ControlGetText, transGermanTEST , RICHEDIT50W1, % winTitle			
		}
		transGermanTESTtransGermanTEST := ""
	}
	ControlGetText, transEnglish3 , RICHEDIT50W2, % winTitle
	if(A_Index > 50 && transEnglish1 == transEnglish3) {
		Msgbox,,% "`n (" A_LineNumber " " RegExReplace(A_LineFile,".*\\") ")",,3
		return
	}
	if(!transEnglish3) ; This probably never happens
		continue
	if(A_Index == 1)
		transEnglish1 := transEnglish3
	isChangedInLastStep := (transEnglish2 <> transEnglish3) ; <====================
	if(!isChangedInLastStep && transEnglish3 <> transEnglish1){
		if(timeOutExpectedNothingWillChangeAnymore_Milli <= timeOutExpectedNothingWillChangeAnymore_Milli_default) ; fast, hustle mode
			break
		MsgBox, 4, stop translating? (id=1903200938) , stop translating (Press YES or Enter),2
		IfMsgBox yes
			break
		WinWaitClose,stop translating? (id=1903200938),,3
		WinWaitActive,% winTitle,,6
		if(false){ ; this is not working. if it starts again it deleting the old text. thats not usefull
			ControlGetText, transGerman , RICHEDIT50W1, % winTitle
			Suspend,On
			send,^ö
			sleep,100
			send,^ö
			Suspend,Off
			WinWaitActive,% winTitle,,6
			ControlSend, RICHEDIT50W1, {end}, % winTitle
		}
		if(0){
			WinWaitActive,% winTitle,,6
			transGermanTEST := ""
			while(transGermanTEST<>RICHEDIT50W1){
				ControlSetText, RICHEDIT50W1, % transGerman , % winTitle
				sleep,500
				ControlGetText, transGermanTEST , RICHEDIT50W1, % winTitle			
			}
			return
			sleep,4000
			Sleep,% timeOutExpectedNothingWillChangeAnymore_Milli ; <=========================
		}
	}
	transEnglish2 := transEnglish3
	aindex := (isChangedInLastStep) ? 1 : aindex++
	if(aindex > 20){
		Msgbox,,% "`n (" A_LineNumber " " RegExReplace(A_LineFile,".*\\") ")",,3
		return
	}
}
tooltip,
processing_results_QTranslateVoiceReader(activeTitle,transEnglish3)
Return
processing_results_QTranslateVoiceReader(doPasteFrom1or2 := "", activeTitle := "", transEnglish3 := "",keepClipboardFixSecs := 100 ){
	winTitle := "QTranslate ahk_class #32770 ahk_exe QTranslate.exe"
	if(!transEnglish3)
		ControlGetText, transEnglish3 , RICHEDIT50W2, % winTitle
	ControlGetText, transGermanSTART  , RICHEDIT50W1, % winTitle ; You may also want to have the original version later	
	
	; maybe transGermanSTART is not german. thats only sometimes. just a variable name. 19-03-21_12-33
	transEnglish3 := RegExReplace(transEnglish3,"\bPunkt\b",".")
	transGermanSTART := RegExReplace(transGermanSTART,"\bPunkt\b",".")
	
	WinClose, % winTitle
	tooltip,% "WinWaitClose (" A_LineNumber " " RegExReplace(A_LineFile,".*\\") ")",1,1
	WinWaitClose,% winTitle,,3
	
	;testen
	; 
	
	at := ""
	if(!doPasteFrom1or2){
		WinGetActiveTitle,at
		WinGetClass,ac,A
		; ac ; HwndWrapper[TheBrain.exe;;577881e0-375a-4d74-9e2f-0968e2d8425d]
		if(RegExMatch(at, "(- AutoHotkey Community)"))
			doPasteFrom1or2 := 2
		else if( RegExMatch(at, "(Telegram|Notepad++|Token - Google Chrome|Gmail - E-Mail schreiben - Google Chrome|TheBrain)") 
			|| RegExMatch(ac, "(TheBrain\.exe|TelegramQt)") ) ; TelegramQt5QWindowIcon
			doPasteFrom1or2 := 1 ; its past for e.g. germen in my case 19-03-20_12-24
		else
			doPasteFrom1or2 := 2
		; needle=Gmail - E-Mail schreiben - Google Chrome ahk_class Chrome_WidgetWin_1 ; mouseWindowTitle=0x1151f44  ; 
		; WinMove,needle=Gmail - E-Mail schreiben - Google Chrome ahk_class Chrome_WidgetWin_1 ,, 593,16, 1916,927
		; WinMove,needle=Gmail - Re: Token - Google Chrome ahk_class Chrome_WidgetWin_1 ,, 787,44, 1916,927
	}		
	if(activeTitle){
		WinActivate,% activeTitle
		tooltip,% "WinWaitActive (" A_LineNumber " " RegExReplace(A_LineFile,".*\\") ")"
		WinWaitActive,% activeTitle,,2
	}
	
	Send,^v
	tooltip,
	Sleep,100
	Send,^z
	Sleep,100
	Send,^v
	
	newClipboard := (doPasteFrom1or2 == 1) ? transGermanSTART : transEnglish3
	; newClipboard .= " at= "  at "#" ac "#" doPasteFrom1or2 ; HwndWrapper[TheBrain.exe;;577881e0-375a-4d74-9e2f-0968e2d8425d]
	loop,9
		while(Clipboard <> newClipboard){
			Clipboard := newClipboard
			sleep,100
		}
	secs := 0
	keepClipboardFixMilli := 1000 * keepClipboardFixSecs
	while(FALSE && a_index<keepClipboardFixMilli ){
		Clipboard := newClipboard
		sleep,1
		secs++
		if(secs > keepClipboardFixMilli ){
			SoundBeep,2000
			break
		}
	}
	; 0In a small test In a small test In a small test
	return
}
;\____ QTranslateVoiceReader __ 181024084505 __ 24.10.2018 08:45:05 __/







#IfWinActive,asdlkfjaölsdkjasdölfkj AUS STOP 09.11.2018 14:43
	~^c::
Last_A_This:=A_ThisFunc . A_ThisLabel
ToolTip1sec(A_LineNumber . " " . A_ScriptName . " " . Last_A_This )
Suspend,on
c := ""
if(c := copySelection2clipBoard())
	Clipboard := c
  ; MsgBox,% Clipboard " = Clipboard `n c= " c "`n(" A_LineNumber " " RegExReplace(A_LineFile,".*\\") ")"
Suspend,off
if(Clipboard == ""){
	clipboard := clipboard_backup
	msg = alert clipboard is empty `n (%A_LineFile%~%A_LineNumber%)
		;Msgbox,,% msg,,3 
	ToolTip5sec( msg )		
}
return

; ~^v:: ; for some reason this not works inside of keysEveryWhere.ahk
	; its nearly everytime igonered. every 10 times orso its not ignored.
   ; msgbox,^v was pressed ; works NOT like expected (this case is ignored/ its not triggered)
;   https://autohotkey.com/boards/viewtopic.php?f=5&t=53135&p=231754#p231754
; return
; ctrl & v::
;  msgbox,ctrl & v was pressed ; works like expected
; return


#Include *i %A_ScriptDir%\keysEveryWhere_PRIVATE.inc.ahk
run,keysEveryWhere_PART2.ahk ; created 13.06.2018 09:47 becouse of : 


send, {alt up}{CtrlUp}




CopyQ:
DetectHiddenWindows,on
SetTitleMatchMode,2
if(!WinExist("- CopyQ ahk_class“ - CopyQ ahk_class")){
  ; check is copyQ is running, only at the beginning of this script 04.08.2017 11:17
  ;run,"C:\Program Files (x86)\_\CopyQ\copyq.exe"  
}
runIfNotExist("cron.ahk", "cron.ahk","",false) 

feedbackMsgBoxCloseAllWindows()
feedbackMsgBox(A_ScriptName,"18-01-06_16-26")

; send,{Raw}!x ;    

DetectHiddenWindows,on
IfWinExist,keysEveryWhere.ahk
{
  ;~ MsgBox, ups . how could that happens!!!?? error  IfWinExist keysEveryWhere.ahk
; kommt manchmal mehrmals vor. komisch.
}
;~ #Include keysEveryWhere_4_Refactor_engine.ahk
;
;~ ListHotkeys 	 
;~ Anzeige der Hotkeys welche vom aktuellen Script verwendet werden, ungeachtet dessen ob ihre Subroutinen z.Z. laufen, und ob sie den Tastatur- oder Maus-Hook benutzen. 
;~ http://www.essential-freebies.de/board/viewtopic.php?t=11375


;MouseMove,50,0
;ToolTip,5erts sdfgdsg wwwwwwwww
;~ lll(A_LineNumber, "keysEveryWhere.ahk")


programmNummer:=1
lll(A_LineNumber, "keysEveryWhere.ahk")


;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
;~ sometimes some keys hook nonstop
;~ so initial them first, so reload could help:
Send,{CtrlUp}
Send,{AltUp}
; Send,{ShiftUp}
;
Last_A_This:=A_ThisFunc . A_ThisLabel
ToolTip1sec(A_LineNumber . " " . A_ScriptName . " " . Last_A_This )
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

s1:=1000
m1:=s1 * 60
m10:=m1 * 10

; this script needs to be reloadet sometimes, becouse somtimes hotkeys ar lost 04.03.2017 23:06
; terfore
;SetTimer, ReloadScript, % m1 ; but this often not help, but sometimes :-( 04.03.2017 23:10
; leider wartete der reloud nicht, wenn dieses script selbst input boxen offen hat...
;SetTimer, ReloadScript, 2000 ; but this often not help, but sometimes :-( 04.03.2017 23:10

;STARTOFSCRIPT
;SetTimer,UPDATEDSCRIPTpilawa,1000
;SetTimer,UPDATEDSCRIPTfunctions_global,1000
;SetTimer,UPDATEDSCRIPTfunctions_global_dateiende,1000

SetTimer,CHEC10minutes,%m10%
;SetTimer, LblPowerCinemaUp , 1000
;SetTimer, LblPowerCinemaUp , Off
;~ ToolTip1sec(A_LineNumber . " " . A_ScriptName . " " . A_ThisFunc . A_ThisLabel)


#InstallKeybdHook
;~ http://de.autohotkey.com/wiki/index.php?title=InstallKeybdHook

;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

miliSec:=5000

;################ Begin Hotkeys

Suspend,off
return

Calc:
SetTitleMatchMode,2
#IfWinActive, Calc
	^+1::
; Ctrl & shift::
; Ctrl & 1::
Last_A_This:=A_ThisFunc . A_ThisLabel
ToolTip1sec(A_LineNumber . " " . A_ScriptName . " " . Last_A_This)
Suspend,on
run,C:\Program Files (x86)\_\CopyQ\copyq.exe
Suspend,off
return

GoogleChrome:
SetTitleMatchMode,2
#IfWinActive,- Google Chrome
	^+q:: ; thats stupid close all in chrome
run,https://www.reddit.com/r/chrome/comments/7u268i/is_there_a_good_way_to_disable_ctrl_q_on_chrome/
run,https://www.computerworld.com/article/3177326/internet/chrome-ctrl-shift-q.html
return
	; https://www.computerworld.com/article/3177326/internet/chrome-ctrl-shift-q.html

EVERYTHING:
settitlematchmode,2
#IfWinActive,- Everything ahk_class EVERYTHING
	~f2:: ; select with fileExtension please
Last_A_This:=A_ThisFunc . A_ThisLabel
ToolTip1sec(A_LineNumber . " " . A_ScriptName . " " . Last_A_This)
sleep,100
Suspend,On
send,+{end}
Suspend,Off
return

yEdexe:
#IfWinActive,ahk_class SunAwtFrame ahk_exe yEd.exe 
	f7::
WinTitle := "ahk_class SunAwtFrame ahk_exe yEd.exe"
Last_A_This:=A_ThisFunc . A_ThisLabel
ToolTip1sec(A_LineNumber . " " . A_ScriptName . " " . Last_A_This)
SetTitleMatchMode,2
SetKeyDelay,80,150
ControlSend,,{left}{right},% WinTitle ; catch a node
ControlSend,,^w,% WinTitle ; new child
ControlSend,,{f2},% WinTitle ; edit text
ControlSend,,{clipboard},% WinTitle ; edit text
ControlSend,,!w,% WinTitle ; redisign node around text
ControlSend,,k{enter},% WinTitle ; redisign node around text
ControlSend,,!+g{enter},% WinTitle ; layout organisch
sleep,1100
RETURN


AutoHotkeyCommunity:
settitlematchmode,2
#IfWinActive, AutoHotkey Community - Post a new topic
	^w::
ToolTip5sec("dangerous ^w you may loos all your typing!! (18-06-10_09-11) " A_LineNumber . " " . A_ScriptName . " " . Last_A_This)
return




GULP:
settitlematchmode,1
#IfWinActive,GULP - 
	~$^v::
;~Ctrl & v::
Last_A_This:=A_ThisFunc . A_ThisLabel
ToolTip1sec(A_LineNumber . " " . A_ScriptName . " " . Last_A_This)
lll(A_LineNumber, "keysEveryWhere.ahk",Last_A_This)
c:=clipboard
if( RegExMatch(c, "^(\d{4})/(\d{2})", match ))
{
	cGulpFormat := match2 "/" match1
	Suspend,On
	send,%cGulpFormat%
	Suspend,Off
}
return



#IfWinActive,ahk_class Chrome_WidgetWin_1 ahk_exe Code.exe ; ahk_id 0x28109be
	^+Backspace::
msgBox,19-01-17_08-48
return



GoogleChrome354:
#IfWinActive Google Chrome
	StrgVonlyText:
Ctrl & v::
Last_A_This:=A_ThisFunc . A_ThisLabel
ToolTip1sec(A_LineNumber . " " . A_ScriptName . " " . Last_A_This)
lll(A_LineNumber, "keysEveryWhere.ahk",Last_A_This)
ClipboardBackup := ClipboardAll
Clipboard = %Clipboard%
  ;~ ToolTip,c = %c%
Suspend,on
Send,^v
Suspend,off
Clipboard := ClipboardBackup

clipboard=%clipboard%

return

OpenOffice:
LibreOffice:
settitlematchmode,2
#IfWinActive,.ods - OpenOffice Calc ahk_class SALFRAME ; mouseWindowTitle=0x3a0914  ; 
	#IfWinActive,.ods - LibreOffice Calc ahk_class SALFRAME ; mouseWindowTitle=0x2c0bec  ; 
		#IfWinActive,.ods
			~^+p::
f9:: ; copy clipboard to everything search engine 22.05.2018 17:15
; ~ctrl & shift:: ; copy clipboard to everything search engine 22.05.2018 17:15
;  KeyWait, 2 ,L D T2
if(true || GetKeyState("2","P")){
	Last_A_This:=A_ThisFunc . A_ThisLabel
	ToolTip1sec(A_LineNumber . " " . A_ScriptName . " " . Last_A_This)
    ; Abkürzungen RG , R für Rechnung
    ; B für Bank
    ; GK Girokonto
    ; BE Bankeinzug
  ; ODT2everythingSearch_and_step_down()
    ;tooltip,°°°°°°°°°°°°°
	
	WinGetActiveTitle, at
	doShowItInEverything := true
	doOpenFirstFileOfEverythingResult := false
	c := trim( ODT2everythingSearch_and_step_down( doShowItInEverything, doOpenFirstFileOfEverythingResult) , " `t`n`r")
    ; ODT2everythingSearch_and_step_down(doShowItInEverything := true, doOpenFirstFileOfEverythingResult := false){
	
	MsgBox, 4,, repeat loop? (press Yes or No), 1
    ; IfMsgBox, Timeout ; works but we use else 24.05.2018 14:25
    ; MsgBox Timeout
	IfMsgBox Yes
	{
	; noOp test
	} else {
		Suspend,on
		loop,9
		{
			SetKeyDelay, 90, 150
			while(GetKeyState("shift","P") && a_index < 1000 )
				send,{shiftup} ; dont know sometimes useful test
			while(GetKeyState("ctrl","P") && a_index < 1000 )
				send,{CtrlUp}  ; dont know sometimes useful
			while(GetKeyState("alt","P") && a_index < 1000 )
				send,{AltUp}  ; dont know sometimes useful
			sleep,100
		}
		Suspend,off
		return ; MsgBox You pressed No.
	}
	
	
	; BW2_01.03.2015 - 31.08.2015_inkl_verdi-abziehbar-auch-fuer-freie-17185.ods - OpenOffice Calc ahk_class SALFRAME ; mouseWindowTitle=0x70c90  ; 
	folderAddressBW1 := "E:\fre\private\office\amt\arge_harz\6mon_Pakete\BW1 01.09.2014 - 28.02.2015\BW1 Rechnungen - 01.09.2014 - 28.02.2015 2576,66Gewinn"
	folderAddressBW2 := "E:\fre\private\office\amt\arge_harz\6mon_Pakete\BW2 01.03.2015 - 31.08.2015\mit_BelegNummer\Labeled PDFs\Labeled PDFs"
	folderAddress := (InStr(at, "BW2_01.03.2015")) ? folderAddressBW2 : folderAddressBW1
	
	countEmpty := 0
	doShowItInEverything := true
	while(countEmpty<9 && a_index < 355){
		WinActivate,% at
		WinWaitActive,% at,,1
		ifwinNotactive,% at
			RETURN
		c := trim( ODT2everythingSearch_and_step_down(doShowItInEverything) , " `t`n`r")
		sleep,150
		c2 := trim(Clipboard, " `t`n`r")
		if(!c2){ ; !c || 
			tooltip,%countEmpty%:`n c=>%c%< `n c2=>%c2%< (line:%A_LineNumber%)
			;msgbox,%countEmpty%:`n c=>%c%< `n c2=>%c2%< (line:%A_LineNumber%)
			countEmpty++
			continue
		}else{
			countEmpty := 0
			; fileAddress := """" folderAddress "\" c2 """"
			fileAddress := folderAddress "\" c2 
			if(!FileExist(fileAddress)){
        ;   MsgBox, '%c%' = c (line:%A_LineNumber%) `n 
				; c2c2
				msg =
          (
            Oops  !FileExist

            fileAddress = %fileAddress%

            '%c%' = c 

            '%c2%' = c2

            line:%A_LineNumber%
				)
				clipboard := fileAddress
				doUpdateWithNewNameKonvention := false
				if(!InStr(c2, "GK", true) && doUpdateWithNewNameKonvention){
					send,{up}{f2}{home}GK{enter}
					tooltip,% msg
					continue
				} else {
					msgbox,% msg
					return
				}
			; fileAddress
			}
		} ; end else
	}
	msgbox,countEmpty=%countEmpty% `n A_Index=%A_Index% `n endof GetKeyState("2","P")) (line:%A_LineNumber%)
} ; if(GetKeyState("2","P")){ 
Return ; copy clipboard to everything search engine 22.05.2018 17:15










classSALFRAME:
settitlematchmode,2
; #IfWinActive, Calc ahk_class SALFRAME
#IfWinActive, ahk_class SALFRAME
; ctrl & v & shift --> past without format 16.05.2018 09:58
	ctrl & v::
Last_A_This:=A_ThisFunc . A_ThisLabel
ToolTip1sec(A_LineNumber . " " . A_ScriptName . " " . Last_A_This)
Suspend,on
if(GetKeyState("shift","P")){
	;If (A_TimeIdle < 50 || GetKeyState("ctrl", "P") || GetKeyState("Alt", "P") || GetKeyState("Shift", "P") || GetKeyState("LWin", "P") || GetKeyState("RWin", "P")  || GetKeyState("LButton", "P") ){
	c = %clipboard%
	c := trim(c)
	c := RegExReplace(c, "m)\s+" , " ")
	clipboard := c
	
	send,^v
;16.05.2018 09:55  msgbox,test 18-05-16_08-34
} else
	send,^v
Suspend,off
Return


FreeCommanderXE:
#IfWinActive,ahk_class FreeCommanderXE
	#IfWinActive,ahk_class FreeCommanderXE.SingleInst.1
		F4::
Last_A_This:=A_ThisFunc . A_ThisLabel
ToolTip1sec(A_LineNumber . " " . A_ScriptName . " " . Last_A_This)
Send,!g
return  
^d::
WinGetActiveTitle , at
atWithoutClass := Rtrim( RegExReplace(at, "- FreeCommander.*",""))
if(!atWithoutClass)
	return
Suspend,on
Send,^d ; %  at
Last_A_This:=A_ThisFunc . A_ThisLabel
ToolTip1sec(A_LineNumber . " " . A_ScriptName . " " . Last_A_This)
;msgbox,%at%?

loop,9
{
	; WinWaitActive,ahk_class VirtualConsoleClassGhost
	sleep,50
	WinWaitActive,ahk_class VirtualConsoleClass,,1
	ifwinNotactive,ahk_class VirtualConsoleClass
		WinActivate,ahk_class VirtualConsoleClass
	; WinMove,cmd (Admin) ahk_class VirtualConsoleClassGhost ,, 2411,597, 728,308
	WinSetTitle, , , % atWithoutClass
	WinWaitActive,% atWithoutClass " ahk_class VirtualConsoleClass",,1
	ifwinactive, % atWithoutClass " ahk_class VirtualConsoleClass"
		continue
;WinSetTitle, , , % at
}
Suspend,off
;  msgbox,ok ?
;  msgbox, %atWithoutClass% <> %at%

return  







SciTEWindow:
SetTitleMatchMode,2

#IfWinActive,ahk_class SciTEWindow
	
^y::
Last_A_This:=A_ThisFunc . A_ThisLabel
ToolTip1sec(A_LineNumber . " " . A_ScriptName . " " . Last_A_This)
selectLine() 
Send,{space}{Backspace 2}
return


!f4::
Last_A_This:=A_ThisFunc . A_ThisLabel
ToolTip1sec(A_LineNumber . " " . A_ScriptName . " " . Last_A_This)
IfWinActive,(Unbenannt) - SciTE4AutoHotkey ahk_class SciTEWindow 
{
	Suspend,on
	WinClose ; scite beenden 
	Suspend,off
	return
}
Suspend,on
send,^w ; nur tabs schliesen. programm schliesen soll man dann halt dann über den x button oben links
Suspend,off
;Msgbox,`n (%A_ScriptName%~%A_LineNumber%)
return


IntelliJ:
SetTitleMatchMode,2
#IfWinActive,XXXXXXXXXXXXXXXXXXX IntelliJ IDEA ahk_class SunAwtFrame ; jetbrains
; #IfWinActive,IDEA ahk_class SunAwtFrame
; #IfWinActive,ahk_class SunAwtFrame
; #IfWinActive,IntelliJ
; #IfWinActive,
	Ctrl & v::
Last_A_This:=A_ThisFunc . A_ThisLabel
ToolTip5sec(A_LineNumber . " " . A_ScriptName . "  simplePast ^+!v " . Last_A_This . "`n" )
Suspend,on
  ;ClipboardClean = %Clipboard%
  ;sendClipboard(Clipboard)
; send,{Text}%ClipboardClean% ; without formating code
send,{CtrlDown}{ShiftDown}{AltDown}v{AltUp}{ShiftUp}{CtrlUp} ; simple past
Suspend,off
return

#IfWinActive,
	#+::
Last_A_This:=A_ThisFunc . A_ThisLabel
ToolTip1sec(A_LineNumber . " " . A_ScriptName . " " . Last_A_This)
runIfNotExist("ScreenMagnifier.ahk", "ScreenMagnifier.ahk")
return


#IfWinActive,ahk_class DClass ; mouseWindowTitle=0x30d24  ; ,Double Commander 0.8.2 beta build 8010M; 2018/02/23 ahk_class DClass ,, 567,43, 1914,855
	!g::
Last_A_This:=A_ThisFunc . A_ThisLabel
msg := "cd... prepare changing directory by cd ... command"
while(GetKeyState("alt","P")){
	ToolTip1sec(A_LineNumber . " " . A_ScriptName . "" . Last_A_This . "`n" msg )
	sleep,100
}
ControlFocus, Edit1, ahk_class DClass
ControlSend, Edit1, cd{space} , ahk_class DClass
ToolTip5sec(A_LineNumber . " " . A_ScriptName . "" . Last_A_This . "`n" msg )
return


SciTEWindow652:
#IfWinActive,ahk_class SciTEWindow
	^w::
Last_A_This:=A_ThisFunc . A_ThisLabel
ToolTip1sec(A_LineNumber . " " . A_ScriptName . " " . Last_A_This)
IfWinActive,(Unbenannt) - SciTE4AutoHotkey ahk_class SciTEWindow 
{
	Suspend,on
	WinClose ; scite beenden 
	Suspend,off
	return
}
; ToolTip,milli %A_ThisHotkey% : %A_TimeSinceThisHotkey%
CtrlWmodus := "selectWord"
if(A_PriorHotkey = "^w"){
	ToolTip,milli %A_PriorHotkey% : %A_TimeSincePriorHotkey%
	if(A_TimeSincePriorHotkey < 2500 && (CtrlWmodus == "selectWord" || CtrlWmodus == "selectLine"))
		CtrlWmodus = "selectLine"
	msg=CtrlWmodus=%CtrlWmodus%
	msg := msg . "`n" . A_LineNumber . " " . A_ScriptName . " " . Last_A_This 
	ToolTip5sec(msg)
}
if(CtrlWmodus == "selectWord"){
	selectWord()
}else {
	;if(CtrlWmodus == "selectLine"){
	selectLine() 
;    MsgBox,aswd
}
return

#IfWinActive,
	
MButton::
If(1 && WinActive("ahk_class SciTEWindow")) {
	Sleep,400 ; geht frühestens  ab 300 22.11.2017 08:59    ; auf diese art führt scite beide rightclicks aus. einmal das f12-menü und zum anderen das kontextmenü 
}
If(1 || !WinActive("ahk_class SciTEWindow")) 
	MouseClick,right ; nutze gerade diese vertical ergo mouse. da ist die linke taste oben , also vertauscht. konnte mich jetzt doch ein bisschen daran gewöhnen, so dass ich sie wohl doch weiter nutze. 22.11.2017 08:54
  ; eine sehr interessante erfahrrung ist, das jetzt das scite menü durch functtionen labels usw wieder funktioniert !!! und zwar mit der mittlerene taste! unabhängig von dieser umbiegung hier. :) ... eigentlich echt praktisch
; das geht aber nur, wenn ich zuvor ein bisschen sleep eingebaut habe, beor ich mein click, right mache.
Last_A_This:=A_ThisFunc . A_ThisLabel
msg := A_LineNumber . " " . A_ScriptName . " " . Last_A_This 
ToolTip5sec(msg)
return

#IfWinActive,ahk_class SciTEWindow
	f12::
copyWord2clipBoard() 
Sleep,2500
msg := Clipboard . " = Clipboard`n`n" . A_LineNumber . " " . A_ScriptName . " " . Last_A_This . "`n n" . sTRG_SHIFT_L_n 
; ToolTip,% msg
ToolTip5sec(msg)
return

PrintScreen::
Last_A_This:=A_ThisFunc . A_ThisLabel
   ; send,{PrintScreen} ; becouse it triggered. so make a sofisticated config llike below: 29.08.2017 16:11
; see reason inide of window_event_listener_imageSearchVersion.ahk 29.08.2017 19:33
Send,{CtrlDown}{ShiftDown}{AltDown}q{AltUp}{ShiftUp}{CtrlUp}
Sleep,2000 ; :) great. tooltips later ar not inside the screenshot but visible to the user 15.11.2017 14:17 :)
msg := A_LineNumber . " " . A_ScriptName . " " . Last_A_This . "`n n" . sTRG_SHIFT_L_n 
; ToolTip,% msg
ToolTip5sec(A_LineNumber . " " . A_ScriptName . " " . Last_A_This . "`n n" . sTRG_SHIFT_L_n )

return

;<<<<<<<< ^Del <<<< 171113191220 <<<< 13.11.2017 19:12:20 <<<<
#IfWinActive, blue line ahk_class TscShellContainerClass
	#IfWinActive, Nightly ahk_class TscShellContainerClass ; eigentlich nur hier wichtig. oder besonders wichtig 13.11.2017 19:11 Visual Basic
		^Del:: ; verhindert , weil STRG+Enter zum Entwicklungsmodus öffnet und nahe der DEL - Taste ist, das versehentlich gelöscht wird.
Msgbox,^Del is STOPPED HERE `n (%A_ScriptName%~%A_LineNumber%) 
return
;>>>>>>>> ^Del >>>> 171113191224 >>>> 13.11.2017 19:12:24 >>>>


;OnOnOnOnOnOnOnOnOnOOnOOnOn


VisualStudio:
#IfWinActive, Microsoft Visual Studio 
;~ #IfWinActive, ahk_class HwndWrapper[DefaultDomain;;8a1eab71-c6a6-4684-b522-c7745193ff52] 
	~^y::
sTRG_SHIFT_L_n = STRG + SHIFT + L `n       or config here: `n Tools->Customize > Keyboard  Edit.LineDelete
Last_A_This:=A_ThisFunc . A_ThisLabel
ToolTip1sec(A_LineNumber . " " . A_ScriptName . " " . Last_A_This . "`n n" . sTRG_SHIFT_L_n )
;~ Send, {CtrlDown}{ShiftDown}l{ShiftUp}{CtrlUp}
return
Ctrl & NumpadDiv::
Last_A_This:=A_ThisFunc . A_ThisLabel
ToolTip1sec(A_LineNumber . " " . A_ScriptName . " " . Last_A_This)
Send, {Home}//{Space}
; ~ ToolTip3sec("STRG + SHIFT + L `n       or config here: `n Tools->Customize > Keyboard  Edit.LineDelete")
MsgBox,A_LineNumber . " " . A_ScriptName . " " . Last_A_This
return

SetTitleMatchMode,2
#IfWinActive, Microsoft Visual Studio 
	Ctrl_Shift_up:
+^up::
Last_A_This:=A_ThisFunc . A_ThisLabel
ToolTip1sec(A_LineNumber . " " . A_ScriptName . " " . Last_A_This)
;~ drawButtons("bjw" , 150)  ; b = ctrsl a = alt j = shift q=f6 w = up
Suspend,on

Send,{End}{ShiftDown}{Home}
c:=copySelection2clipBoard()
Send,^x{ShiftUp}
Send,{BackSpace}{Up}{Home}
Send,^v{Enter}{up}
Suspend,off   
MsgBox,A_LineNumber . " " . A_ScriptName . " " . Last_A_This

return


SetTitleMatchMode,2
#IfWinActive, Microsoft Visual Studio 
	Ctrl_Shift_down:
+^Down::
Last_A_This:=A_ThisFunc . A_ThisLabel
ToolTip1sec(A_LineNumber . " " . A_ScriptName . " " . Last_A_This)
   ;~ drawButtons("bjy" , 150)  ; b = ctrsl a = alt j = shift q=f6 w = up y =down
   ;~ If (GyetKeyState("Shift", "p")) {
;  if u want trigger ^z and you missed. its creates lots of confusion. and i nealy never use this funktion. so turn it off.
Suspend,on

Send,{End}{ShiftDown}{Home}
c:=copySelection2clipBoard()
Send,^x{ShiftUp}
Send,{BackSpace}{Down 2}{Home}
Send,^v{Enter}{up}
Suspend,off   
MsgBox,A_LineNumber . " " . A_ScriptName . " " . Last_A_This

return

#IfWinActive,
	
SC03:: Send, " 
; two to douple qupte  https://autohotkey.com/board/topic/84037-is-there-a-way-to-identify-keys/
; http://www.ee.bgu.ac.il/~microlab/MicroLab/Labs/ScanCodes.htm

SendLevel 1

#IfWinActive,
<^>!0::
<^>!}::
	
}:: ; poblem with that: https://autohotkey.com/boards/viewtopic.php?f=5&t=47860&p=214402#p214402 23.4.218 19:54}
; sendplay, {}} 0 0 } }}
Suspend,on
SendRaw, } ; Sends {} 0 0 0 0 0 
Last_A_This:=A_ThisFunc . A_ThisLabel
ToolTip1sec(A_LineNumber . " " . A_ScriptName . " " . Last_A_This)
loop,3
{
	while(GetKeyState("Ctrl", "p") || GetKeyState("shift", "p") || GetKeyState("alt", "p")){
		send,{altUp}
		send,{shiftUp}
		send,{CtrlUp}
		sleep,80  
}}
Suspend,off
return
#IfWinActive,
	numpad0::
Suspend,on
SendRaw, 0 ; 350 ; Sends {} 0 0 0 0 0 
  ;SendPlay, 0 351 ; Sends {} 0 0 0 0 0 
;SendInput, 0 352; Sends {} 0 0 0 0 0 
Last_A_This:=A_ThisFunc . A_ThisLabel
ToolTip1sec(A_LineNumber . " " . A_ScriptName . " " . Last_A_This)
Suspend,off
return

0:: ; poblem with that: https://autohotkey.com/boards/viewtopic.php?f=5&t=47860&p=214402#p214402 23.4.218 19:54}
; sendplay, {}} 0 0 } }}
Suspend,on
SendRaw, } ; Sends {} 0 0 0 0 0 
Last_A_This:=A_ThisFunc . A_ThisLabel
ToolTip1sec(A_LineNumber . " " . A_ScriptName . " " . Last_A_This)
loop,20
{
	while(GetKeyState("Ctrl", "p") || GetKeyState("shift", "p") || GetKeyState("alt", "p")){
		send,{altUp}
		send,{shiftUp}
		send,{CtrlUp}
		sleep,80  
}}
Suspend,off
return
msgbox,% ord("%")
Suspend,on
sendplay,% chr(37) ; {}}
msgbox, {}}
send,{CtrlUp}
Suspend,off
return
1::! 
; http://stackoverflow.com/questions/13706992/autohotkey-escape-quotes-in-string-for-run-command-arguments

3::§ ; paragraph
4::$

6::&

7::  ; 

Suspend,On
while( GetKeyState("RAlt","P") ){
	; send,{RAltUp}
	tip := "Alt is down"
	ToolTip,% A_LineNumber . " " . RegExReplace(A_LineFile,".*\\")  . " `n " . tip
	sleep,50
}
send,{text}`{ ; solved the problem (ctrl hanging in jetbrains) 21.10.2018 19:08
	Suspend,Off
	return
	; (((()))
	8::
	ToolTip,% A_LineNumber . " " . RegExReplace(A_LineFile,".*\\")  . " `n " . tip	
	Suspend,On	
	send,{text}[
	Suspend,Off
	9::]
	+0::=
	+1::!
	+3::§ ; paragraph
	+4::$

	+6::&
	+7::/
	+8::(
	+9::)
	
	RAlt & 0::
	Last_A_This:=A_ThisFunc . A_ThisLabel
	ToolTip5sec(A_LineNumber . " " . A_ScriptName . " " . Last_A_This)	 
	if( GetKeyState("RAlt","P") ){
		send,{RAltUp}
	}
	
	KeyWait, LAlt, L  ; Wait for the left Alt key to be logically released.
	KeyWait, RAlt, L  ; Wait for the left Alt key to be logically released.
	Suspend,On
	; send,{text}} ; solved the problem (ctrl hanging in jetbrains) 21.10.2018 19:08
	while( GetKeyState("RAlt","P") ){
		; send,{RAltUp}
		tip := "Alt is down"
		ToolTip,% A_LineNumber . " " . RegExReplace(A_LineFile,".*\\")  . " `n " . tip
		sleep,50
	}
	ToolTip,
; } } } 
	; Send, % "{text}" Chr(125) ; works 22.10.2018 04:40
	send,{text}`} ; works 22.10.2018 04:40
;	send,{altup}{Ctrlup}
	; }} } 
	
	Suspend,Off
	; Send,{}}
	; } }} {}} {text}}  }
	return
	
	
	RAlt & 3::SendRaw, % Chr(179) ; 
	
	; ==}=}===}=
	
; RAlt & 4::
; RAlt & 5::
; RAlt & 6::
	; {
	RAlt & 7::
	while( GetKeyState("RAlt","P") ){
		; send,{RAltUp}
		tip := "Alt is down"
		ToolTip,% A_LineNumber . " " . RegExReplace(A_LineFile,".*\\")  . " `n " . tip
		sleep,50
	}
	
	; lklkjl
	
	Suspend,On
	send,{text}`{ ; solved the problem (ctrl hanging in jetbrains) 21.10.2018 19:08
		Suspend,Off
		return
		RAlt & 8::
		ToolTip,% A_ThisLabel " " A_LineNumber . " " . RegExReplace(A_LineFile,".*\\")  . " `n " . tip	
		Suspend,On
		send,{text}[ ; solved the problem (ctrl hanging in jetbrains) 21.10.2018 19:08
		;Send,[
		Suspend,Off
		return
		RAlt & 9::
		Suspend,On
		send,{text}] ; solved the problem (ctrl hanging in jetbrains) 21.10.2018 19:08
		
		;	Send,] [ ] 
		Suspend,Off
		return


		SendLevel 0
		
		SetTitleMatchMode,2
		
		
		#IfWinActive,Nachweis der Arbeitssuche
			^v:: 
		;WinGetActiveTitle,t
		Msgbox,`n (%A_LineFile%~%A_LineNumber%) 
		Last_A_This:=A_ThisFunc . A_ThisLabel
		ToolTip1sec(A_LineNumber . " " . A_ScriptName . " " . Last_A_This)
		Clipboard = %Clipboard%
		Sleep,100
		ToolTip2sec(Clipboard A_LineNumber   " "   A_LineFile   " "   Last_A_This) 
		send, % Clipboard
		return
		
; 01.03.2015 - 31.08.2015 (März2015-Aug2015)_mit_BelegNummer.ods - OpenOffice Calc ahk_class SALFRAME ; mouseWindowTitle=0xc016ba  ; 
		; WinMove,01.03.2015 - 31.08.2015 (März2015-Aug2015)_mit_BelegNummer.ods - OpenOffice Calc ahk_class SALFRAME ,, 378,14, 1914,1005
		
		SetTitleMatchMode,1
		#IfWinActive,01.03.2015 - 31.08.2015 (März2015-Aug2015)_mit_BelegNummer.ods - OpenOffice
			~^c:: 
		send,{ShiftUp}{CtrlUp}
		
		Last_A_This:=A_ThisFunc . A_ThisLabel
		ToolTip1sec(A_LineNumber . " " . A_ScriptName . " " . Last_A_This)
		; Clipboard := RegExReplace(Clipboard, "\b(\d{2})\.(\d{2})\.(\d{4})\b" , "$3/$2" )
		ToolTip2sec(Clipboard A_LineNumber   " "   A_LineFile   " "   Last_A_This) 
		tooltip,WinActivate
		settitlematchmode,2
		WinActivate,PDF-XChange Editor
		tooltip,WinWaitActive
		WinWaitActive,PDF-XChange Editor
		;SetKeyDelay, 150, 280
		Suspend,on
		if(0){
			;sleep,20
			send,{Shift_down}
			sleep,100
			;send,{Shift_down}
			cP  := 0
			sP  := 0
			while ( 0 && (  ! cP || ! sP ) ){
				tooltip,%a_index%: %cP% %sP% 
				send,{Ctrl_Shift_down}
				sleep,50
				cP  := GetKeyState("Ctrl", "p")
				sP  := GetKeyState("Shift", "p")
			}
			; 
			cP  := GetKeyState("+Ctrl", "p")
			sP  := GetKeyState("Shift", "p")
			if( 0 && ( ! cP || ! sP )){
				send,{ShiftUp}{CtrlUp}
				msgbox,%cP% %sP% Oops 18-07-25_19-04
				Suspend,off
				return
			}
			send,+f
			send,+f
		}
				
		MouseClick, left , 3594,367 , 1 , 0
		sleep,50 
		send,{CtrlDown}{Shift_down}^+f
		sleep,350 
		send,{ShiftUp}{CtrlUp}
		sleep,150 
		send,^a{del 9}{Backspace 9}
		sleep,50 
		send,^v{enter}{tab 5}
		sleep,150 
		send,{down 2}
  ;tooltip,WinWaitActive
		;WinActivate,01.03.2015 - 31.08.2015 (März2015-Aug2015)_mit_BelegNummer.ods - OpenOffice
		Suspend,off
		tooltip,
		; msgbox,%clipboard%
		return
		
		
		#IfWinActive,Threema Web -
		;#IfWinActive,Threema Web - Google Chrome ahk_class Chrome_WidgetWin_1
			~^c:: ; leider machen sich neue nachrichten nicht bemerkbar, dadurch das sich der fenstertitel ändert... also das ist keine kontrolle 30.01.2018 12:58
		WinGetActiveTitle,t
		Last_A_This:=A_ThisFunc . A_ThisLabel
		ToolTip1sec(A_LineNumber . " " . A_ScriptName . " " . Last_A_This,1,1)
		WinSetTitle,% t,,% "Threema Web - " . Clipboard
		return
		
		; SetTitleMatchMode,2
		#IfWinActive,Google Chrome555
			;~LButton::
		; MsgBox,262208,%  A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ,% A_PriorKey " = A_PriorKey :)`n" clipboard "`n`n"  ":)`n(" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")"
		;return
			
		~^c::
		Last_A_This:=A_ThisFunc . A_ThisLabel
		ToolTip9sec(A_LineNumber . " " . A_ScriptName . " " . Last_A_This)
		MsgBox,262208,%  A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ,% A_PriorKey " = A_PriorKey :)`n" clipboard "`n`n"  ":)`n(" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\") ")"
		Sleep, 4000
   ; check clipboard is changed
;~ subStr_Clipboard_1_5 := SubStr(Clipboard,1,5)
		; sometimes copy text with ^ c dont copy. visual feedback ist needet and implemented here. 22.09.2015 18:41
		if(Clipboard_OLD  <> Clipboard) {
			c := Clipboard
			https_www_google_d = https://www.google.de/
			strLen_https_www_goo := StrLen(https_www_google_d)
			subStr_c_strLen_http := SubStr(c,1,strLen_https_www_goo)
			;~ MsgBox,'%subStr_c_strLen_http%' ?= '%https_www_google_d%' (line:%A_LineNumber%) `n 
			if(subStr_c_strLen_http == https_www_google_d ){
				c := RegExReplace( c, "([^?]+\?).*(\#?q=[^&]+).*","$1$2")
				MsgBox, '%c%' = c (line:%A_LineNumber%) `n 
				MsgBox,'%subStr_c_strLen_http%' ?= '%https_www_google_d%' (line:%A_LineNumber%) `n
;~ Reload
;~ sourceid_chrome_inst = sourceid=chrome-instant&
;~ ion=1&espv=2&es_th=1&ie=UTF-8#q=vidisic%20augengel%20test&es_th=1 
				;~ https://www.google.de/webhp?sourceid=chrome-instant&ion=1&espv=2&es_th=1&ie=UTF-8#q=vidisic%20augengel%20test&es_th=1 
				Clipboard := c
			}else if( UniqueID := WinActive("JOBBÖRSE - Stellenangebot -") && InStr(c, "https://jobboerse.arbeitsagentur.de/vamJB/stellenangebotAnzeigen.html" ) ){
				StringReplace,Clipboard ,c,aufrufErfolgteAusSuchassistent:= true&,
			; MsgBox, '%Clipboard%' = Clipboard `n (line:%A_LineNumber%) `n 
			}
			SetTimer,Show_Clipboard_1_5,200 ; it need to show it later. if i use ToolTip inside it schow me the old clipboard :D 22.09.2015 18:33
			Clipboard_OLD := c
		}
		
		IfWinExist,Nachweis der Arbeitssuche im
		{
			WinActivate,
			WinWaitActive,
			send,{f2}
		}
		
		
		return
		;>>>>>>>> ctrl & c >>>> 170823085722 >>>> 23.08.2017 08:57:22 >>>>
		
		
		; asökjhlkjödf aölsdkjfaölsdkf öaldjskf 
		
;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
		; mit escape fenster schliesen funktion 14.07.2017 20:26
		SetTitleMatchMode,2

#IfWinActive,- SumatraPDF ahk_class SUMATRA_PDF_FRAME
			ESC::
		Last_A_This:=A_ThisFunc . A_ThisLabel
		ToolTip1sec(A_LineNumber . " " . A_ScriptName . " " . Last_A_This)
		send,!{f4} ; ALT+F4 windows explorer fenter schliesen die lösen. 14.07.2017 20:23
		return
; mit escape fenster schliesen funktion 14.07.2017 20:26
		;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
		
		
		
		Show_Clipboard_1_5:
		SetTimer,Show_Clipboard_1_5,Off 
		subStr_Clipboard_1_5_OLD := subStr_Clipboard_1_5
		subStr_Clipboard_1_5 := SubStr(Clipboard,1,5)
		ToolTip3sec( "" . subStr_Clipboard_1_5 . "..." )
		return
		
		DetectHiddenWindows,on
		SetTitleMatchMode, 2
		

#IfWinActive,HTML5 Test - Upwork - Google Chrome ahk_class Chrome_WidgetWin_1 

#IfWinActive, Upwork - Adaptive Skill Test - Google Chrome ahk_class Chrome_WidgetWin_1 
			#IfWinActive, oDesk :.: The On Demand Global Workforce - Google Chrome ahk_class Chrome_WidgetWin_1 

~LButton::
		Send,{F9}
		return
		
		
		
		
		
		
		;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
		SetTitleMatchMode,2
		;~ Inkscape ahk_class gdkWindowToplevel,
		#IfWinActive Inkscape ahk_class gdkWindowToplevel
		;~ ahk_class gdkWindowToplevel
			down::
		;~ send,!x{down}
		send,{Alt Down}x{Alt Up}{down}
		return
		up::
		;~ send,!x{down}
		send,{Alt Down}x{Alt Up}{up}
		return
		;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
		
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
		;~ doppel actually not trigger. whey ? StrgAStrgA 12-11-22_10-50
		StrgAStrgA:
		StrgA:
		SetTitleMatchMode, 2
		#IfWinActive ahk_class
			~^a::
		Last_A_This:=A_ThisFunc . A_ThisLabel
		ToolTip5sec(clipboard "`n" A_LineNumber . " " . A_ScriptName . " " . Last_A_This )
		StrgAStrgA()
		return
		;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
		
		
		SetTitleMatchMode, 2
		
		titleBeforeDictation:="" 
		isDragonMicrophoneOn:=0
		;MsgBox, %isDragonMicrophoneOn%
		
		;::SC163::Send,#e  ; FN unter IBM T41
		
		#IfWinActive
		;~ #tab::send,!{tab}
			~#tab::
		Suspend,on
  ;~ send,{LWin Down}{tab}{tab}{tab}   
  ;~ send,{LWin Down}{tab}{tab}
		;~ wieviel tabs ist nicht immer ganz klar. komisch. naja  
		SetKeyDelay,30
		send,{LWin Down}{tab}{tab}   
		SetKeyDelay,10        
		Suspend,off
		return
		
		
		#IfWinActive portal.epost.de - Google Chrome ahk_class Chrome_WidgetWin_1
			Ctrl & v::
		ToolTip2sec(A_LineNumber   " "   A_LineFile   " "   Last_A_This) 
		WinActivate,portal.epost.de - Google Chrome ahk_class Chrome_WidgetWin_1
		WinWaitActive,portal.epost.de - Google Chrome ahk_class Chrome_WidgetWin_1
		Sleep,1000
		MouseClick,left,500,650
		Sleep,1000
		;~ SendPlay,1 %clipboard%
		SendInput,2 %clipboard%
		;~ SendMessage,3 %clipboard%
		return
		;~ lklkj
		
		#IfWinExist Camtasia Recorder ahk_class RECORDER_CLASS_D77CA95F_632A_4d48_8FD0_2A8DEAA6DA4A
			Ctrl & +::
		Last_A_This:=A_ThisFunc . A_ThisLabel
		ToolTip1sec(A_LineNumber . " " . A_ScriptName . " " . Last_A_This)
		;MsgBox,Shift + Alt + in 
		Send,{Shift Down}!i{Shift Up} ;zoom in
		return
		
		
		Ctrl & -::
		Last_A_This:=A_ThisFunc . A_ThisLabel
		ToolTip1sec(A_LineNumber . " " . A_ScriptName . " " . Last_A_This)
		;MsgBox,Shift + Alt + out
		Send,{Shift Down}!o{Shift Up} ;zoom in
		return
		
		;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
		SetTitleMatchMode, 2
		#IfWinActive AbstractSpoon ahk_class Afx
			ctrl & shift::
		Last_A_This:=A_ThisFunc . A_ThisLabel
		ToolTip1sec(A_LineNumber . " " . A_ScriptName . " " . Last_A_This)
		
		; weil ctrl+shift+n nicht funktioniert
		if(0)
		{
			WinWait, test - ToDoList ï¿½ AbstractSpoon, Above &Priority
			IfWinNotActive, test - ToDoList ï¿½ AbstractSpoon, Above &Priority, WinActivate, test - ToDoList ï¿½ AbstractSpoon, Above &Priority
				ToolTip3sec(A_LineNumber   " "   A_LineFile   " "   Last_A_This) 
			WinWaitActive, test - ToDoList ï¿½ AbstractSpoon, Above &Priority
			MouseClick, left,  392,  522
			Sleep, 100
		}
		
		Input, SingleKey, L1 M,{Esc}{LControl}{RControl}{LAlt}{RAlt}{LShift}{RShift}{LWin}{RWin}{AppsKey}{F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Left}{Right}{Up}{Down}{Home}{End}{PgUp}{PgDn}{Del}{Ins}{BS}{Capslock}{Numlock}{PrintScreen}{Pause}
		
		if(SingleKey="n")
		{
			
    ;ToolTip [, Text, X, Y, WhichToolTip]
			;Send, {CTRLDOWN}{shiftdown}n{shiftup}{CTRLUP}
			Send, {CTRLDOWN}n{CTRLUP}
			sleep,50
			send,{enter}
			sleep,50
			Send, {CTRLDOWN}{right}{CTRLUP}{f2}
		}
		return
		;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
		
		
		return
		


		#IfWinExist 
			
		WinN:
		~#n::
		Send,{BackSpace} ; becouse it writes a n . the ~ is for prevent windows to open windows.
  ;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
		; n15-05-1%%%5-%%11
		if(0)
		{
			;ï¿½ndern Datumsshortcut (Win+n) von 10-01-25_21-30 in 25.Jan 2010
			FormatTime, timestamp, %A_now% ,dd.MM.yyyy
			SendPlay, %timestamp% ; 8-6-24_14-80008-6-24_14-80008-6-24_14-9000 8-6-24_14-90008-6-24_14-90008-6-24_14-9000
			return
		}
		;   
		
		;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
		KeyWait, LWin ; , L ; Wait for the left Alt key to be logically released.
		KeyWait, RWin ; , L ; Wait for the left Alt key to be logically released.
		
		FormatTime, timestamp, %A_now%,yy-MM-dd_HH-mm
		;~ timestamp:=timestamp
		Last_A_This:=A_ThisFunc . A_ThisLabel
		lll(A_LineNumber, "keysEveryWhere.ahk",Last_A_This)
		ToolTip1sec(A_LineNumber . " " . A_ScriptName . " " . Last_A_This . "`n" . timestamp  )
  ;08-07n15-05-12_16-25-07_17-44,
  ;{ASC 0108}; n15-05-12_16-20
  ;SendMessage, 0x111, 4007, 0x00000000, , Windows Task-Manager 
		;MsgBox, %timestamp%
		
		Suspend,ON
		
		if(0)
		{
			; diese methjode geht bei eingeschalteten benutezrknten -steuerungu unter vista leider nicht.
			SendPlay, %timestamp% ; 8-6-24_14-80008-6-24_14-80008-6-24_14-9000 8-6-24_14-90008-6-24_14-90008-6-24_14-9000
		}
		else
		{
			timestamp:=timestamp
			
			; n--_-n--_-
			if(WinActive("ahk_class TscShellContainerClass"))
				Send,{Space}'SL{Space} ; kürzel typisch für B&W 15.11.2017 18:52 , 17-11-15_18-52
			
			Send, %timestamp% ; leider werden einige zahlen dann nicht verarbeitet. 10-07-14_14-06{numpad1}{numpad}-{numpad}{numpad}-{numpad1}{numpad4}_{numpad1}{numpad4}-{numpad}{nu} 10-07-14_14-07 10-07-14_14-07
		; n15-05-12_16-17
		}
		Suspend,Off
		
		return
		
		; 21.09.2015 15:34
		
		
		WinNgorssgeschrieben:
;RControl & RShift::AltTab
		;24.04.2010 "$:=$:"=!="$:=$:"=!="  30.05.2015 
		SetTitleMatchMode,2
		;~ #IfWinActive,Google Chrome ahk_class Chrome_WidgetWin_1 
		#IfWinActive, 
			LWin & LShift::
		;ï¿½ndern Datumsshortcut (Win+n) von 10-01-25_21-30 in 25.Jan 2010
		IfWinActive,Nachweis
			FormatTime, timestamp, %A_now%,dd.MM.yyyy 
		else
			FormatTime, timestamp, %A_now%,dd.MM.yyyy HH:mm
		KeyWait, LWin ; , L ; Wait for the left Alt key to be logically released.
		KeyWait, RWin ; , L ; Wait for the left Alt key to be logically released.
		;FormatTime, timestamp, %A_now%,yy-MM-dd_HH-mm
		timestamp:=timestamp
		if(WinActive("ahk_class TscShellContainerClass"))
			Send,{Space}'SL{Space} ; kürzel typisch für B&W 
		; Send,%timestamp% ; => 22.12.2014 ... da hängt leider aktuell (09.05.2018 05:28) die 0 nach und wird als hotkey verstanden
		sendClipboard(timestamp) ; so is es zum glück sowieso viel schneller 09.05.2018 05:28
		;~ SendRaw,,%timestamp% ; erzeugt dieses => {numpad2}{numpad2}.{numpad1}{numpad2}.{numpad2}{numpad}{numpad1}{numpad4}
		Last_A_This:=A_ThisFunc . A_ThisLabel
		ToolTip1sec(A_LineNumber . " " . A_ScriptName . " " . Last_A_This . "`n" . timestamp  )
  ;08-07-07_17-44, 15.11.2017 18:50
		;17-11-15_18-5117-11-15_18-51
		return
		
		Suspend,On
		
  ;{ASC 0108}
		;SendMessage, 0x111, 4007, 0x00000000, , Windows Task-Manager
		if(0)
		{
			; diese methjode geht bei eingeschalteten benutezrknten -steuerungu unter vista leider nicht.
			SendPlay, %timestamp% ; 8-6-24_14-80008-6-24_14-80008-6-24_14-9000 8-6-24_14-90008-6-24_14-90008-6-24_14-9000
		}
		else
		{
			timestamp:=timestamp
			Send, %timestamp% ; leider werden einige zahlen dann nicht verarbeitet. 10-07-14_14-06{numpad1}{numpad}-{numpad}{numpad}-{numpad1}{numpad4}_{numpad1}{numpad4}-{numpad}{nu} 10-07-14_14-07 10-07-14_14-07
		}
		
		Suspend,Off
		
		return
		
		
		WINae:
		#ä:: ; gï¿½ï¿½gle -definition
		KeyWait, LWin ; , L ; Wait for the left Alt key to be logically released.
		KeyWait, RWin ; , L ; Wait for the left Alt key to be logically released.
		
		; ErrorLevel is set to 1 if the command timed out or 0 otherwise.
		if ErrorLevel   ; i.e. it's not blank or zero.
			exitBecouseOfErrorInLine(A_LineNumber . " " . A_ScriptName . " " . Last_A_This)
		
		
		Last_A_This:=A_ThisFunc . A_ThisLabel
		lll(A_LineNumber, "keysEveryWhere.ahk",Last_A_This)
		ToolTip1sec(A_LineNumber . " " . A_ScriptName . " " . Last_A_This)
		SendEvent,^c ; einfach kopiern ... reicht aber nicht bei Emails und links
		run,http://www.google.com/search?q=define`%3A%clipboard%&esrch=BetaShortcuts
		ToolTip2sec( A_ThisLabel . "`n define BetaShortcuts")
		;http://www.google.com/search?hl=en&esrch=BetaShortcuts&q=define%3Aclipboard&btnG=Search
		return
		
		WINue:
		#ü:: ; google -codeSuche
		KeyWait, LWin ; , L ; Wait for the left Alt key to be logically released.
		KeyWait, RWin ; , L ; Wait for the left Alt key to be logically released.
		
		; ErrorLevel is set to 1 if the command timed out or 0 otherwise.
		if ErrorLevel   ; i.e. it's not blank or zero.
			exitBecouseOfErrorInLine(A_LineNumber . " " . A_ScriptName . " " . Last_A_This)
		
		
		Last_A_This:=A_ThisFunc . A_ThisLabel
		ToolTip1sec(A_LineNumber . " " . A_ScriptName . " " . Last_A_This)
		SendEvent,^c ; einfach kopiern ... reicht aber nicht bei Emails und links
		run,http://www.google.com/codesearch?hl=de&lr=&q=2008+%clipboard%+lang`%3Ajava+-google&sbtn=Suche
		;http://www.google.com/codesearch?hl=de&lr=&q=2008+%clipboard%+lang%3Ajava+-google&sbtn=Suche
		run,http://books.google.de/books?q=%clipboard%&btnG=Nach+B%C3%BCchern+suchen
		ToolTip2sec( A_ThisLabel . "`n java / books ")
		return
		
		exitBecouseOfErrorInLine(info)
		{
			MsgBox, %info% `n`n exit
			exit
		}
		
		;~ 200801-22-15-27-33
		WINe:
		#e::
		KeyWait, LWin ; , L ; Wait for the left Alt key to be logically released.
		KeyWait, RWin ; , L ; Wait for the left Alt key to be logically released.
		; ErrorLevel is set to 1 if the command timed out or 0 otherwise.
		if ErrorLevel   ; i.e. it's not blank or zero.
			exitBecouseOfErrorInLine(A_LineNumber . " " . A_ScriptName . " " . Last_A_This)
		
		Last_A_This:=A_ThisFunc . A_ThisLabel
		ToolTip4sec(A_LineNumber . " " . A_ScriptName . " " . Last_A_This)
		SetTitleMatchMode, 2
		; 2: A window's title can contain WinTitle anywhere inside it to be a match.
		
		dir:=""
		WinGetActiveTitle, ActiveTitle
		tc=FreeCommander ahk_class TfcForm
		IfWinActive,%tc% ; , WinText, ExcludeTitle, ExcludeText]
		{
			Last_A_This:=A_ThisFunc . A_ThisLabel
			ToolTip1sec(A_LineNumber . " " . A_ScriptName . " " . Last_A_This)
  	;D: - FreeCommander ahk_class TfcForm
    ;System32 - FreeCommander ahk_class TfcForm
			;ControlSend, , {CTRLDOWN}{ALTDOWN}{INS}{CTRLUP}{ALTUP} , %ActiveTitle%
			clipboardBackup := ClipboardAll
			Sleep,50
			Send,{CTRLDOWN}{ALTDOWN}{INS}{CTRLUP}{ALTUP}
			dir:=clipboard 
			clipboard:=clipboardBackup
			; A_WinDir The Windows directory. For example: C:\Windows
			run,%A_WinDir%/explorer.exe "%dir%" ; D:\fre\private\
			;SendEvent,{LWin down}e{LWin up}
			ToolTip4sec(A_LineNumber   " "   A_LineFile   " "   Last_A_This) 
			forceWinActivate("ahk_class CabinetWClass")
			return
		}
		SetTitleMatchMode, 2
		; StringReplace, OutputVar, InputVar, SearchText , ReplaceText, ReplaceAll?] 
		tc2=ahk_class CabinetWClass
		IfWinActive,%tc2% ; , WinText, ExcludeTitle, ExcludeText]
		{
			Last_A_This:=A_ThisFunc . A_ThisLabel
			ToolTip1sec(A_LineNumber . " " . A_ScriptName . " " . Last_A_This)
			;C:\Program Files (x86)\_\PSPad editor ahk_class CabinetWClass
			StringReplace, dir, ActiveTitle, %tc2%, , All
		}
		
  ;MsgBox, %clipboard%
  ;if ( StrLen(dir)=0 AND StrLen(clipboard)>0 )
		; D:\fre\private\DFU_ftp_mail_chat_ssh_fax\dosqlweb.de\cello
		if(InStr(clipboard, ":\", 1 , 1))
		{
			IfExist, %clipboard%
			{
				clipboardBackup := ClipboardAll
				dir=%clipboard% 
			}
			else
			{
      ; autohotkey verzeichnis erstellen
				;MsgBox, 4, , Would you like to create  `n %clipboard% ?, 3  ; 5-second timeout.
				MsgBox, 4, , Would you like to create  `n %clipboard% ?, 3
				IfMsgBox, Yes
				{
					clipboardBackup := ClipboardAll
					dir=%clipboard% 
					FileCreateDir, %dir%
					
					if ErrorLevel   ; i.e. it's not blank or zero.
						MsgBox, ErrorLevel  %dir%
					
				}
        ;IfMsgBox, Timeout
        ;    Return ; i.e. Assume "No" if it timed out.
				; Otherwise, continue:
				
			}
		} 
		
	;if Not WinExist("FreeCommander")
		;#E::Run %A_ProgramFiles%\_\FreeCommander\FreeCommander.exe
		r=%A_ProgramFiles%\_\FreeCommander\FreeCommander.exe
		
		;~  MsgBox, run,%r% "%dir%"
		
		IfExist, %r%
		run,%r% /R="%dir%"
		
		
	;r=C:\Program Files (x86)\_\FreeCommander\FreeCommander.exe
	;IfExist, %r%
	;	run,%r% "%dir%"
	; Run rundll32.exe shell32.dll`,Control_RunDLL desk.cpl`,`, 3  ; 
		;else
		ToolTip4sec(A_LineNumber   " "   A_LineFile   " "   Last_A_This) 
		forceWinActivate(tc)
		return
		
		
		WinRRRTitelCopyShort:
		#r::
		goto showTitle
		return
		
		#IfWinActive
			WinV:
		~#v::
		c=%Clipboard%
		ToolTip,c = %c%
		Suspend,on
		SendPlay,%c%
		Sleep,1000
		Suspend,off
		Suspend,off
		return
		
		
		
		WinT:
		showTitleTogle=off
		~#t::
		;~ #t::
		
		KeyWait, LWin ; , L ; Wait for the left Alt key to be logically released.
		KeyWait, RWin ; , L ; Wait for the left Alt key to be logically released.
		
		; ErrorLevel is set to 1 if the command timed out or 0 otherwise.
		if ErrorLevel   ; i.e. it's not blank or zero.
		{
			showTitleTogle =off
		; exitBecouseOfErrorInLine(A_LineNumber . " " . A_ScriptName . " " . Last_A_This)
		}
		
		Last_A_This:=A_ThisFunc . A_ThisLabel
		ToolTip1sec(A_LineNumber . " " . A_ScriptName . " " . Last_A_This)
		;~ ToolTip3sec("showTitle-Keys: Win+T, Win+R (Default: Win-ausfï¿½hren")
		SetTimer, showTitle, 1000
		if showTitleTogle =on
		{
			showTitleTogle =off
			;tooltip,
			ToolTip,  %activeTitleFromShowTitleSetTimer%`n (%A_ScriptName%~%A_LineNumber%) 
			Clipboard := activeTitleFromShowTitleSetTimer
			
		}
		else
			showTitleTogle =on
		SetTimer, showTitle, %showTitleTogle%
		return
		
		
		
		
		;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
		
		
		
		
		
		#IfWinActive,.php - PhpStorm
			#IfWinActive,- PhpStorm
				
		~!Enter:: ; 24.03.2018 20:50 https://youtrack.jetbrains.com/issue/WI-41253
		msg := "BTW 'Complete current statement' Ctrl+Shift+Enter"
		ToolTip1sec(msg "`n(" A_LineNumber   " "   A_LineFile   ") "  )
		return
		
		f1::
		;~ MsgBox, %k%
		SleepValue:=200
		ClipboardOLD = %Clipboard%
		Loop,10
		{
			Send,^c
			Sleep,%SleepValue%
			if(ClipboardOLD <> Clipboard)
				break
		}
		value = %Clipboard%
		ToolTip,value %Clipboard%
		Sleep,%SleepValue%
		ToolTip,
		Send,{f2}
		Sleep,%SleepValue%
		Send,^a
		Sleep,%SleepValue%
		ClipboardOLD = %Clipboard%
		Loop,10
		{
			Send,^c
			Sleep,%SleepValue%
			if(ClipboardOLD <> Clipboard)
				break
		}
		name = %Clipboard%
		condition := name . "=='" . value . "'"
		Clipboard = %condition%
		ToolTip,%condition%
		Sleep,%SleepValue%
		;~ MsgBox [, Options, Title, Text, Timeout]
		MsgBox,,Clipboard = %condition%,Clipboard = %condition%,2
		Sleep,%SleepValue%
		Send,{esc}
		return
		
		#IfWinActive,.php - PhpStorm asï¿½kfjasoeiruaweï¿½lksdï¿½lfksdjf 
			enter::
;~ Suspend,On
;~ ControlSend,,{enter},.php - PhpStorm 
;~ Suspend,Off
		;~ return
		infoText:="Ctrl + shift + enter = Complete Current Statement (Settings | Keymap)" 
		tooltip,%infoText% 
		Suspend,On
		ControlSend,,{CtrlDown}+{enter}{CtrlUp},.php - PhpStorm 7.1.1 ahk_class SunAwtFrame
		sleep,10
		MsgBox, 4,, ControlSend enter?  (press Yes or No)`n%infoText%,1
		IfMsgBox Yes
		{
			;~ MsgBox You pressed Yes.
			ControlSend,,{enter},.php - PhpStorm 7.1.1 ahk_class SunAwtFrame
		}
		else
		{
		;~ MsgBox You pressed No.
		}
		Sleep,500
		Suspend,Off
		return
		
		#IfWinActive,.php - PhpStorm 
			^NumpadAdd::
		tooltip,%A_LineNumber%: Ctrl & NumpadAdd (may start it as win-admin)
		Suspend,On
		send,^{WheelUp}
		;~ ControlSend,,^{WheelUp},PhpStorm 7.0 ahk_class SunAwtFrame
		Suspend,Off
		return
		
		#IfWinActive,.php - PhpStorm 
			^NumpadSub::
		tooltip,%A_LineNumber%: Ctrl & NumpadAdd
		Suspend,On
		send,^{WheelDown}
		;~ ControlSend,,^{WheelUp},PhpStorm 7.0 ahk_class SunAwtFrame
		Suspend,Off
		return
		
		#IfWinActive,Rename ahk_class SunAwtDialog
			up::
		tooltip,esc
		Suspend,On
		ControlSend,,{esc},Rename ahk_class SunAwtDialog
		Suspend,Off
		return
		Down::
		tooltip,esc
		Suspend,On
		ControlSend,,{esc},Rename ahk_class SunAwtDialog
		Suspend,Off
		return
		;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
		
		
		
		
		
		#IfWinActive,awï¿½eorjsadlï¿½fkaï¿½sdlfk Mozilla Firefox
			StrgR:
		^r::
		ToolTip1sec(A_LineNumber . " " . A_ScriptName . " " . Last_A_This)
		send,{CtrlDown}
		return
		#IfWinActive,Facebook - Mozilla Firefox ahk_class MozillaUIWindowClass
			StrgW:
		^w::
		ToolTip1sec(A_LineNumber . " " . A_ScriptName . " " . Last_A_This)
		send,{CtrlDown}
		return
		
		
		
		
		
		f4tasteWinWaitActive:
		SetTitleMatchMode,2
		
		
;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
;~ thanks to:
;~ http://www.autohotkey.com/board/topic/75390-ahk-l-unicode-uri-encode-url-encode-function/
		;~ http://www.w3schools.com/tags/ref_urlencode.asp
		UriEncode(Uri)
		{
			oSC := ComObjCreate("ScriptControl")
			oSC.Language := "JScript"
			Uri:= RegExReplace(Uri, " = ", "\n\n")  ; Returns "aaaXYZzzz" by means of the $1 backreference.
			Uri:= RegExReplace(Uri, "[\n\r]", "###Zeilenumbruch###")  ; Returns "aaaXYZzzz" by means of the $1 backreference.
			
			
    ;~ Uri=%Uri%
			;~ MsgBox,test %Uri%
			Script := "var Encoded = encodeURIComponent(""" . Uri . """)"
			oSC.ExecuteStatement(Script)
			Uri:= oSC.Eval("Encoded")
    ;~ Clipboard:=Uri
    ;~ MsgBox,%Uri%
    ; C3 BC is the UTF-8 encoding of ï¿½
			; http://www.andre-jochim.de/url-encode.htm
			Uri:= RegExReplace(Uri, "%C3%BC", "ue")  ; ï¿½
			Uri:= RegExReplace(Uri, "%C3%9C", "Ue")  ; ï¿½
			Uri:= RegExReplace(Uri, "%C3%A4", "ae")  ; 
			Uri:= RegExReplace(Uri, "%C3%84", "Ae")  ; 
			Uri:= RegExReplace(Uri, "%C3%B6", "oe")  ; 
			Uri:= RegExReplace(Uri, "%C3%96", "Oe")  ; 
			Uri:= RegExReplace(Uri, "%253A", ":")  ; 
			
			Uri:= RegExReplace(Uri, "%23%23%23Zeilenumbruch%23%23%23","%0D%0A")  ; Returns "aaaXYZzzz" by means of the $1 backreference.
			
			Return, Uri
		}
		
		UriDecode(Uri)
		{
			oSC := ComObjCreate("ScriptControl")
			oSC.Language := "JScript"
			Script := "var Decoded = decodeURIComponent(""" . Uri . """)"
			oSC.ExecuteStatement(Script)
			Return, oSC.Eval("Decoded")
		}
		;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
		
		WINp:
		#p:: ; 
		Last_A_This:=A_ThisFunc . A_ThisLabel
		ToolTip1sec(A_LineNumber . " " . A_ScriptName . " " . Last_A_This)
		
		KeyWait, LWin ; , L ; Wait for the left Alt key to be logically released.
		KeyWait, RWin ; , L ; Wait for the left Alt key to be logically released.
		
		; ErrorLevel is set to 1 if the command timed out or 0 otherwise.
		if ErrorLevel   ; i.e. it's not blank or zero.
			return ; exitBecouseOfErrorInLine(A_LineNumber . " " . A_ScriptName . " " . Last_A_This)
		
		SendEvent,^c ; einfach kopiern ... reicht aber nicht bei Emails und links
		StringReplace, NewStr, clipboard, ", , All
		; http://software.magnus.de/office-
		if( SubStr(NewStr, 1 , 7) = "http://" )
			run,%NewStr%
		else
			run, http://www.google.com/search?hl=de&esrch=BetaShortcuts&q=site:php.net+%NewStr%&btnG=Suche&lr=lang_de
		ToolTip2sec( A_ThisLabel . "`n BetaShortcuts `n" . clipboard)
		return
		
		
		#IfWinActive - DragonPad - Dokument.rtf ahk_class TalkpadClass
			!::MsgBox, Text 17-02-12_17-59
		return
		
		tabThingy:
		#IfWinActive Alt-Tab Thingy v3 ahk_class ATT_MainWnd
			tab::SendPlay,{right}
		shift & tab::SendPlay,{left}
		0::SendPlay,{space}
		1::SendPlay,{Home}{right 1}
		2::SendPlay,{Home}{right 2}
		3::SendPlay,{Home}{right 3}
		4::SendPlay,{Home}{right 4}
		5::SendPlay,{Home}{right 5}
		6::SendPlay,{Home}{right 6}
		7::SendPlay,{Home}{right 7}
		8::SendPlay,{Home}{right 8}
		9::SendPlay,{Home}{right 9}
		numpad0::SendPlay,{space}
		numpad1::SendPlay,{Home}{right}
		numpad2::SendPlay,{Home}{right 2}
		numpad3::SendPlay,{Home}{right 3}
		numpad4::SendPlay,{Home}{right 4}
		numpad5::SendPlay,{Home}{right 5}
		numpad6::SendPlay,{Home}{right 6}
		numpad7::SendPlay,{Home}{right 7}
		numpad8::SendPlay,{Home}{right 8}
		numpad9::SendPlay,{Home}{right 9}
		return
		
		#IfWinActive Wink - [Unbenannt1 *] ahk_class wxMDIFrameClassNR
			Up::
		Send,^j
		sleep,300
		Send,^c
		sleep,50
		thisPage := RegExReplace(clipboard, "\s*/.*", "")  
		lastPage := RegExReplace(clipboard, ".*\s*/", "")  
		next100:= (thisPage + 0) -100
		;ToolTip, next100=%next100%`n thisPage=%thisPage% `n lastPage=%lastPage%
		if( next100 < 1 ) 
			next100 := 1
		if( next100 > lastPage )
			next100 := lastPage
		sleep,50
		
		Suspend,On
		
		send,%next100% {return}
		Suspend,Off
		
		
		return
		Down::
		Send,^j
		sleep,300
		Send,^c
		sleep,50
		thisPage := RegExReplace(clipboard, "\s*/.*", "")  
		lastPage := RegExReplace(clipboard, ".*\s*/", "")  
		next100:= (thisPage + 0) + 100
		;ToolTip, next100=%next100%`n thisPage=%thisPage% `n lastPage=%lastPage%
		if( next100 < 1 ) 
			next100 := 1  
		if( next100 > lastPage ) 
			next100 := lastPage    
		sleep,50
		send,%next100% {return}
		return
		PgDn::
		SetKeyDelay, 0, -1
		Send,{right 8}
		return
		PgUp::
		SetKeyDelay, 0, -1
		Send,{left 8}
		return
		return
		
		
		SetTitleMatchMode,2
		#IfWinActive - Eclipse SDK ahk_class SWT_Window0
			^m::
		ToolTip1sec("Sendet STRG+ALT+Z fï¿½r Eclipse-Fullscreen-Plugin")
		SendPlay,{ctrldown}m{altdown}z{altup}{ctrlup}
		Last_A_This:=A_ThisFunc . A_ThisLabel
		ToolTip4sec(A_LineNumber . " " . A_ScriptName . " " . Last_A_This)
		WinActivate, - Eclipse SDK ahk_class SWT_Window0
		
		
		return
		
		#IfWinActive öffnen ahk_class #32770
			#a::
		
		KeyWait, LWin ; , L ; Wait for the left Alt key to be logically released.
		KeyWait, RWin ; , L ; Wait for the left Alt key to be logically released.
		
		Last_A_This:=A_ThisFunc . A_ThisLabel
		ToolTip1sec(A_LineNumber . " " . A_ScriptName . " " . Last_A_This)
		Send,!n
		SendEvent,%HardDriveLetter%:\fre\private\HtmlDevelop\AutoHotKey\
		SendEvent,{enter}
		Sleep,500
		if (A_OSVersion = "WIN_VISTA" )
			ControlFocus , FolderView, öffnen ahk_class #32770 ; , WinText, ExcludeTitle, ExcludeText]
		return
		
		#IfWinActive SL.doc - Microsoft Word ahk_class OpusApp
			F3::
		Send,{CTRLDOWN}{ALTDOWN}y{ALTUP}{CTRLUP}
		Send,{right}
		Last_A_This:=A_ThisFunc . A_ThisLabel
		ToolTip1sec(A_LineNumber . " " . A_ScriptName . " " . Last_A_This)
		return
		
		#IfWinActive all-together.doc - Microsoft Word ahk_class OpusApp
			F10::Send,!{F8}
		#IfWinActive Microsoft Visual Basic - Normal - [ThisDocument (Code)] ahk_class wndclass_desked_gsk
			!F8::
		F10::
		ControlClick , ComboBox2, Microsoft Visual Basic - Normal - [ThisDocument (Code)] ahk_class wndclass_desked_gsk
		ControlFocus , ComboBox2, Microsoft Visual Basic - Normal - [ThisDocument (Code)] ahk_class wndclass_desked_gsk
		return
		#IfWinActive Microsoft Visual Basic - Normal - [NewMacros (Code)] ahk_class wndclass_desked_gsk
			!F8::
		F10::
		ControlClick , ComboBox2, Microsoft Visual Basic - Normal - [NewMacros (Code)] ahk_class wndclass_desked_gsk
		ControlFocus , ComboBox2, Microsoft Visual Basic - Normal - [NewMacros (Code)] ahk_class wndclass_desked_gsk
		return
		#IfWinActive Microsoft Visual Basic - All-together - [ThisDocument (Code)] ahk_class wndclass_desked_gsk
			!F8::
		F10::
		ControlClick , ComboBox2, Microsoft Visual Basic - All-together - [ThisDocument (Code)] ahk_class wndclass_desked_gsk
		ControlFocus , ComboBox2, Microsoft Visual Basic - All-together - [ThisDocument (Code)] ahk_class wndclass_desked_gsk
		return
		
		SetTitleMatchMode,2
		#IfWinActive VLC media player ahk_class wxWindowClassNR
			p::
		Last_A_This:=A_ThisFunc . A_ThisLabel
		ToolTip1sec(A_LineNumber . " " . A_ScriptName . " " . Last_A_This)
		ControlClick, x48 y67, VLC media player
		return
		
		#IfWinActive VLC media player ahk_class QWidget
			del::
		;~ ControlSend [, Control, Keys, WinTitle, WinText, ExcludeTitle, ExcludeText]
		ControlSend,,^i,VLC media player ahk_class QWidget
		wM=Aktuelle Medieninformationen ahk_class QWidget 
		WinWaitActive,%wM%,,1
		IfWinNotActive,%wM%
			return
		
		ClipboardOLD2=%Clipboard%
		ClipboardOLD:=""
		;~ ControlSend,,{ShiftDown}{Tab}{ShiftUp},%wM%
		WinGetPos , X, Y, Width, Height, %wM%
		x:=Width-200
		y:=Height-70
		;~ MouseMove,%x% , %y%
		MouseClick,l,%x% , %y%
		Send,^a
		Send,^c
		;~ break
		
		
		IfExist,%Clipboard%
		{
			ToolTip3sec(A_LineNumber   " "   A_LineFile   " "   Last_A_This) 
			WinActivate,VLC media player ahk_class QWidget
			Send,{esc}
			Sleep,200
			Send,{esc}
			Sleep,200
			ControlSendRaw,,n,VLC media player ahk_class QWidget
			;~ Send,!g
			Sleep,200
			
			
    ;~ MsgBox,datei existiert :)  %Clipboard%
			; FileDelete, C:\temp files\*.tmp
			FileDelete,"%Clipboard%"
			FileDelete,%Clipboard%
			ToolTip,FileDelete %Clipboard%
			send,{esc}
			IfNotExist,%Clipboard%
				;~ MsgBox,hurra datei existiert nicht mehr :)  %Clipboard%
				IfWinExist,%wM%
					WinClose,%wM%
			IfWinExist,%wM%
				FileDelete,"%Clipboard%"
			FileDelete,%Clipboard%
			WinClose,%wM%
			IfWinExist,%wM%
				WinClose,%wM%
			IfExist,%Clipboard%
			MsgBox,existiert immernoch :(  %Clipboard%
		}
		IfWinExist,%wM%
			WinClose,%wM%
		IfWinExist,%wM%
			WinClose,%wM%
		IfWinExist,%wM%
			
		
		w=Medien öffnen ahk_class QWidget 
		Sleep,1000
		IfWinExist,%w%
			WinClose,%w%
		Sleep,1000
		IfWinExist,%w%
			WinClose,%w%
		Sleep,1000
		IfWinExist,%w%
			WinClose,%w%
		
		return


;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
		;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
		SetTitleMatchMode,2
		;~ - Mozilla Firefox ahk_class MozillaWindowClass
		#IfWinActive Mozilla Firefox ahk_class MozillaWindowClass
		;~ RButton::
			~RButton::
		ToolTip3sec(A_LineNumber   " "   A_LineFile   " "   Last_A_This) 
		if(0)
		{
			Clipboard=""
			;~ ControlSend,,{APPSKEY},Mozilla Firefox ahk_class MozillaWindowClass
			MouseClick,right 
			Sleep,100
			;~ ControlSend,,a,Mozilla Firefox ahk_class MozillaWindowClass
			Send,a
			Sleep,100
			ClipboardBackup := ClipboardAll
			Loop,50
			{
				WinActivate, DOM des ausgewählten Quelltextes - Mozilla Firefox ahk_class MozillaWindowClass
				WinWaitActive, DOM des ausgewählten Quelltextes - Mozilla Firefox ahk_class MozillaWindowClass
				Send,^c
				if(Clipboard <> ClipboardBackup)
				{
					WinClose,DOM des ausgewählten Quelltextes - Mozilla Firefox ahk_class MozillaWindowClass
					break
				}
			}
			
			
			if(Clipboard <> ClipboardBackup)
				sourceOfSelectedClipboard:=Clipboard
			else
				sourceOfSelectedClipboard:=""
  ;~ MsgBox,sourceOfSelectedClipboard=`n%sourceOfSelectedClipboard%
			;~ Send, {APPSKEY}a
			pattern =.*href\s*=\s*["']([^"']*)["'].*
			pattern =.*href\s*=\s*"(.*)".*
			pattern =ims).*(http[^s"]*)".*
			NeuerStr := RegExReplace(sourceOfSelectedClipboard, pattern, "$1")  ; Gibt "aaaXYZzzz" mithilfe der Rï¿½ckreferenz $1 zurï¿½ck.
			MsgBox,NeuerStr =`n%NeuerStr%
		} 
		
		return
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
		;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
		
		return
		
		#IfWinActive Player - IC_C ahk_class #32770
			right::
		SetTitleMatchMode, 1
		ControlClick, x180 y131, Player - IC_
		return
		
		left::
		SetTitleMatchMode, 1
		ControlClick, x20 y131, Player - IC_
		return
		
		NumpadEnter::
		Send,{space}
		return
		enter::
		Send,{space}
		return
		
		; toglle start stop
		space::
		MsgBox,yes gefunden 10-11-27_20-19
		SetTitleMatchMode, 1
		;STOP=STOP
		if( lastControlAction <> "PLAY" )
		{
			ControlAction=PLAY
			ControlClick, PLAY, Player - IC_
		}
		else
		{
			ControlAction=STOP
			ControlClick, STOP, Player - IC_
		}
		lastControlAction:=ControlAction
		return
		
  ; WinWaitActive, Player - IC_C0009.ZVR, Elapsed Time 00:01:3
  ; MouseClick, left,  180,  131
		;>>>>>>>>>>>( Visible Window Text )<<<<<<<<<<<
		
  ; REW
  ; PLAY
  ; FF
  ; STOP
  ; Slider1
  ; Elapsed Time 00:00:00 / Total Time 00:02:34
		; OPEN
		
		return
		
		Nachrichten_Suchen_Enter:
		SetTitleMatchMode, 3
		#IfWinActive Nachrichten suchen ahk_class MozillaUIWindowClass
			enter::
		{
			Send !s
			Last_A_This:=A_ThisFunc . A_ThisLabel
			ToolTip3sec(A_LineNumber . " " . A_ScriptName . " " . Last_A_This)
		}
		
		#IfWinActive Posteingang - Thunderbird ahk_class MozillaUIWindowClass
			^f::
		ToolTip3sec(A_LineNumber   " "   A_LineFile   " "   Last_A_This) 
		WinWait, Posteingang - Thunderbird, 
		IfWinNotActive, Posteingang - Thunderbird, , WinActivate, Posteingang - Thunderbird, 
			WinWaitActive, Posteingang - Thunderbird
		IfWinActive, Posteingang - Thunderbird
		{ 
			Send, {APPSKEY}
			Sleep,500
			Send, s
			WinWait, Nachrichten suchen 
			IfWinNotActive, Nachrichten suchen, , WinActivate, Nachrichten suchen, 
				WinWaitActive, Nachrichten suchen 
			IfWinActive, Nachrichten suchen
			{
				Sleep,200
				Send, {ALTDOWN}m{ALTUP}
				Sleep,100
				Send, {TAB}{TAB}{TAB}{TAB}
			}
		}
		return
		
		
		
		
		
		
		
		
		
;/¯¯¯¯ Notepad ¯¯
;~ % dranmachen
		;~ #IfWinActive ahk_class TfPSPad.UnicodeClass
		#IfWinActive  - Notepad++ ahk_class Notepad++
			^!5::
		;ToolTip1sec("geht leider nicht unter PSPAD")
		Last_A_This:=A_ThisFunc . A_ThisLabel
		ToolTip1sec(A_LineNumber . " " . A_ScriptName . " " . Last_A_This)
		clipboard_backup:=clipboard
		Send, {CTRLDOWN}c{CTRLUP}
		tooltip,%clipboard%
		s=`%%clipboard%`%  
		Send, %s%
		clipboard:=clipboard_backup
		return
		
;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
		;~ PSPad - [D:\fre\private\HtmlDevelop\AutoHotKey\keysEveryWhere.ahk] ahk_class TfPSPad.UnicodeClass
		SetTitleMatchMode, 2
		#IfWinActive ahk_class TfPSPad.UnicodeClass
			!f4::
		Last_A_This:=A_ThisFunc . A_ThisLabel
		ToolTip1sec(A_LineNumber . " " . A_ScriptName . " " . Last_A_This)
		send,^{f4}
		;MsgBox, Text
		return
		;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
		
;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
		;~ kompletten code auskommentieren
		SetTitleMatchMode, 2
		#IfWinActive ahk_class TfPSPad.UnicodeClass
			^k::
		backupclipboard:=clipboard
		clipboard:=""
		send,^c
		sleep,500
		c := RegExReplace( clipboard, "\n" , ";" )
		clipboard:=backupclipboard
		sendraw,``;%c%
		return
		;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
		
		#d::
		
		Last_A_This:=A_ThisFunc . A_ThisLabel
		ToolTip1sec(A_LineNumber . " " . A_ScriptName . " " . Last_A_This)
		
		KeyWait, LWin ; , L ; Wait for the left Alt key to be logically released.
		KeyWait, RWin ; , L ; Wait for the left Alt key to be logically released.
		
		; ErrorLevel is set to 1 if the command timed out or 0 otherwise.
		if ErrorLevel   ; i.e. it's not blank or zero.
			return ; exitBecouseOfErrorInLine(A_LineNumber . " " . A_ScriptName . " " . Last_A_This)
		
		Send,!n
		SendEvent,%HardDriveLetter%:\fre\private\LERN\Diplomarbeit\IBM_Lotus_Symphony\Developing\
		SendEvent,{enter}
		Sleep,500
		if (A_OSVersion = "WIN_VISTA" )
			ControlFocus , FolderView, ï¿½ffnen ahk_class #32770 ; , WinText, ExcludeTitle, ExcludeText]
		return
		
		;~ Weil manchmal das Shift & RButton von VoiceReader nicht richtig erkannt wird, tuh ich noch mal explizit den Text in die Zwischenablage kopieren.
		
		ShiftRButton:
		Shift & RButton::
		Last_A_This:=A_ThisFunc . A_ThisLabel
		ToolTip1sec(A_LineNumber . " " . A_ScriptName . " " . Last_A_This)
		clipboard:=""
		SendEvent,^c{shift down}{RButton}{shift up}
  ; mal kucken ob man trotzdem noch schnell in zwischenablage ï¿½bersetzen kann.
  ;c:=clipboard
  ;StringReplace, c, c, [Bearbeiten], , All
  ;StringReplace, clipboard, clipboard, [Bearbeiten], , All
  ;clipboard:=c
		;MsgBox, %c%
		
		
		return
		
		
		return
		
		
		
		#IfWinActive 
;~ Capslock::
  ;~ Last_A_This:=A_ThisFunc . A_ThisLabel
		;~ ToolTip1sec(A_LineNumber . " " . A_ScriptName . " " . Last_A_This)
			
	;~ ; das ist hier eine kleine provisorische Lï¿½sung fï¿½r ein Bug
	;~ ; das mitunter Vista aufgefallen ist.
	;~ ; das passiert zum Beispiel nach einem Control+Tab im Notepad Editor. 08-06-26_11-44
	;~ ;GetKeyState, state, Shift
	;~ ;if state = D
	;~ ;	Send,{shift up}
		;~ ;MsgBox At least one Shift key is down.
		
	;~ Send,{Control down}
  ;~ Sleep,1000  ; fï¿½r eine Sekunde 
	;~ Send,{Control up}
;~ return
		;Shift ;http://www.at-mix.de/caps_lock_taste.htm
		
		;~ Die Umschaltsperre (Shift Lock) oder Feststelltaste (Schweiz: Caps Lock) befindet sich auf einer Tastatur direkt ï¿½ber der linken Umschalttaste
		SetScrollLockState, AlwaysOff
		
		;Send, w{CTRLDOWN}{CTRLBREAK}{CTRLBREAK}{CTRLUP}
		
;#IfWinActive 
;~*}::
;~ if (A_OSVersion <> "WIN_VISTA" )
;~ 	tooltip2sec("} ist tot, verwende {")
;return
;#IfWinActive 
;~*{::
;~ if (A_OSVersion <> "WIN_VISTA" )
;~ 	SendEvent,{{}{}} ; } wird immer gleich mitgeschrieben weil kaputt
;return
		;*^::tooltip2sec("^ ist tot, verwende WIN + Roll")
		#PRINTSCREEN::SendEvent,{^}PRINTSCREEN
		^PRINTSCREEN::SendEvent,{^}PRINTSCREEN
		#CTRLBREAK::SendEvent,{^}CTRLBREAK ; der geht nicht ...
		^CTRLBREAK::SendEvent,{^}CTRLBREAK
		;PRINTSCREEN^CTRLBREAK^CTRLBREAK^PRINTSCREEN^PRINTSCREEN
		
		
		0:*:
		Last_A_This:=A_ThisFunc . A_ThisLabel
		ToolTip1sec(A_LineNumber . " " . A_ScriptName . " " . Last_A_This)
		if (A_OSVersion = "WIN_VISTA" )
		{
			;Send,{Numpad0}
			return
		}
		tooltip2sec("= ist tot, verwende SCROLLLOCK (Taste Rol) fï¿½r =")
		return
		
		; ss
		
		#IfWinActive 
			SCROLLLOCK::SendEvent,=
		;~ betrifft nicht die Numlock 0
		
		#IfWinActive 
			NumLock::
		medion := "1700MHZ"
		bigbag := "2400MHZ"
		state := GetKeyState("Numlock", "T")  ; True if CapsLock is ON, false    otherwise.5588yy654654
		if( A_ComputerName = medion  )
		{
			if ( state )
			{
				SetNumLockState, Off
			}
			else
			{
				SetNumLockState, On
			}
		}
		else
		{
			;Suspend, On
			Send,y  
			Tooltip,y-Ersatztaste  `n  `n '%state%' = state  `n  `n A_LineNumber . " " . A_ScriptName 
			SetTimer, RemoveToolTip, 2000    
		}
		return
		
		ReloadPyton:
		#IfWinActive,.py (3.4.3) ahk_class TkTopLevel
			~Enter::
		WinGetActiveTitle,at
		ToolTip4sec(A_LineNumber . " " . A_ScriptName . " " . Last_A_This)
		ControlSend,,{f5},Python 3.4.3 Shell
		Sleep,500
		WinActivate,%at%
		return
		
		
		ReloudFirefoxLoop:
		#f5::
		Last_A_This:=A_ThisFunc . A_ThisLabel
		ToolTip1sec(A_LineNumber . " " . A_ScriptName . " " . Last_A_This)
		;ReloudFirefox
		KeyWait, LWin ; , L ; Wait for the left Alt key to be logically released.
		KeyWait, RWin ; , L ; Wait for the left Alt key to be logically released.
		
		; ErrorLevel is set to 1 if the command timed out or 0 otherwise.
		if ErrorLevel   ; i.e. it's not blank or zero.
			return ; 	exitBecouseOfErrorInLine(A_LineNumber . " " . A_ScriptName . " " . Last_A_This)
		
		Last_A_This:=A_ThisFunc . A_ThisLabel
		ToolTip1sec(A_LineNumber . " " . A_ScriptName . " " . Last_A_This)
		if ReloudFirefox=on
			ReloudFirefox=off
		else
			ReloudFirefox=on
		SetTimer, Lbl_Toggle_ReloudFirefox , %ReloudFirefox%
		return
		
;#IfWinActive
		;^!c::MsgBox You pressed Control+Alt+C in a window other than Notepad/WordPad.
		
		
;~ StartTime := A_TickCount
;~ Sleep, 1000
		;~ ElapsedTime := A_TickCount - StartTime
		
		
		
		#IfWinActive
			#i::
		Last_A_This:=A_ThisFunc . A_ThisLabel
		ToolTip1sec(A_LineNumber . " " . A_ScriptName . " " . Last_A_This)
		
		KeyWait, LWin ; , L ; Wait for the left Alt key to be logically released.
		KeyWait, RWin ; , L ; Wait for the left Alt key to be logically released.
		
		; ErrorLevel is set to 1 if the command timed out or 0 otherwise.
		if ErrorLevel   ; i.e. it's not blank or zero.
			return ; 	exitBecouseOfErrorInLine(A_LineNumber . " " . A_ScriptName . " " . Last_A_This)
		
;ToolTip , Text
;ControlFocus , S&top
		;, InfoRapid Suchen & Ersetzen 
		
		;Return 
		
		SetTitleMatchMode,1
		t:="InfoRapid Suchen & Ersetzen - "
		;ahk_class seRapid_Frame
		if WinExist(t)
		{
			ifwinNotactive,%t% 
				Send,^c
			forceWinActivate(t)
			; WinWaitActive , WinTitle, WinText, Seconds, ExcludeTitle, ExcludeText]
			WinWaitActive,%t%,,1
			
			WinSetTitle, %t%, , %t% F9 open in StandardAnwendung
			ifwinnotactive,%t% 
				return
			
			MouseClick, right, 55, 233
			sleep,1500
			SendEvent,{alt down}b{alt up}
			Suspend,on
			Send,%clipboard%  
			Suspend,off
		}
		else
		{
    ;~ MsgBox,A_ProgramFiles=%A_ProgramFiles%
			; "C:\Program Files (x86)\_\InfoRapid Suchen & Ersetzen\seRapid.exe"
			FilePattern:=A_ProgramFiles . "\_\InfoRapid Suchen & Ersetzen\seRapid.exe"
			; "C:\Program Files (x86)\_\seRapid\seRapid.exe"
			if(FileExist(FilePattern))
				run,%FilePattern%
			else
			{
				; "C:\Program Files (x86)\_\seRapid\seRapid.exe"
				FilePattern:=A_ProgramFiles . "\_\seRapid\seRapid.exe"
				if(FileExist(FilePattern))
					run,%FilePattern%
				else
				{
					FilePattern:="C:\Program Files (x86)\_\InfoRapid Suchen & Ersetzen\seRapid.exe"
					if(FileExist(FilePattern))
						run,%FilePattern%
					else
					{
						FilePattern:=A_ProgramFiles . " (x86)\_\seRapid\seRapid.exe"
						if(FileExist(FilePattern))
							run,%FilePattern%
						
					}
					
				}
			}
			
			WinWaitActive,%t%,,1
			IfWinActive,%t%
			{
				sleep,500
				if(FileExist(clipboard))
				{
					ControlFocus ,&Verzeichnis, %t%
					Send, {tab} ; springe ins Verzeichnis Eingabe Feld
					;ControlSend, , {tab}, %t% ; springe ins Verzeichnis Eingabe Feld
					Send, %clipboard% ; Verzeichnis Eingabe Felditesttestiiitesttestitesttest
					;ControlSend, , %clipboard%, %t% ; Verzeichnis Eingabe Feld
					ToolTip1sec("ControlFocus ,&Verzeichnis, %t%")
					
					ControlFocus ,Such&begriff, %t% ; focus Label
					Send, {tab} ; springe ins Textfeld
				}
				Sleep,9000
			}
			else
				SendPlay,#i
		}
		return
		
		
		;VBA_BAWVerwaltung - [BAWFunctions (Code)]  ahk_class TscShellContainerClass ; mouseWindowTitle=0x3150cec  ; 
		#IfWinActive,ahk_class TscShellContainerClass
			^Esc:: ; startmenü auf RemoteDesktop
		Last_A_This:=A_ThisFunc . A_ThisLabel
		ToolTip1sec(A_LineNumber . " " . A_ScriptName . " " . Last_A_This)
		Suspend,on
		send,^{f1} ; wird dort nochmal gemappt RemoteDesktop 17-12-12_15-04
		Suspend,off
		return
	;MsgBox, 0, Tutorial, Hallo World
	;MouseGetPos,KDE_X2,KDE_Y2 ; Get the current mouse position.
; 	MouseMove, 0,0
; 	SendEvent ,^{Esc}
; 	if (A_OSVersion <> "WIN_VISTA" )
; 		SendEvent ,P
		; Return   ;==>captureEsc
		
;~ doppelte ^ verhindern
;:*:^^::
;~ fï¿½r welchen Rechner war das wichtig ??????????
;~  Last_A_This:=A_ThisFunc . A_ThisLabel
;~ ToolTip1sec(A_LineNumber . " " . A_ScriptName . " " . Last_A_This)
;return
		;~ aaaa
		
		
		
		
		;^w^c^r^r^^
		shift & F11::
		Last_A_This:=A_ThisFunc . A_ThisLabel
		ToolTip1sec(A_LineNumber . " " . A_ScriptName . " " . Last_A_This)
		SetTitleMatchMode, 3
		; 3: A window's title must exactly match WinTitle to be a match.
		WinGetActiveStats, Title, w, h1, X, Y
		SendEvent,{F11}
		Sleep,400
		WinGetActiveStats, Title, w, h2, X, Y
		if h1=%h2%
		{
			Critical
			hWnd := WinActive("A")
			ToggleFullScreen(hWnd)
		}
		;ToolTip,%Title% w%w% h%h% x%X% y%Y%
		Return
		
; F11::
;    Last_A_This:=A_ThisFunc . A_ThisLabel
		;    ToolTip1sec(A_LineNumber . " " . A_ScriptName . " " . Last_A_This . "`n n" . sTRG_SHIFT_L_n )
		
; 	SetTitleMatchMode, 3
	; 3: A window's title must exactly match WinTitle to be a match.
; 	WinGetActiveStats, Title, w, h1, X, Y
; 	SendPlay,{F11}
; 	Sleep,800
; 	WinGetActiveStats, Title, w, h2, X, Y
	; Tasklist-TODOlist_Diplomarbeit - ToDoList ï¿½ AbstractSpoon ahk_class Afx:400000:b:10003:6:2eb21435
; 	SetTitleMatchMode, 2
; 	IfWinNotActive, AbstractSpoon
; 	if(h1=h2)
; 	{
    ; Prevents the current thread from being interrupted by other threads.
; 		Critical
; 		hWnd := WinActive("A")
; 		ToggleFullScreen(hWnd)
; 	}
	;ToolTip,%Title% w%w% h%h% x%X% y%Y%
		; Return
		
		#IfWinActive,
			
		WINs:
		#s::
		Last_A_This:=A_ThisFunc . A_ThisLabel
		ToolTip1sec(A_LineNumber . " " . A_ScriptName . " " . Last_A_This)
		
		
		KeyWait, LWin ; , L ; Wait for the left Alt key to be logically released.
		KeyWait, RWin ; , L ; Wait for the left Alt key to be logically released.
		
		; ErrorLevel is set to 1 if the command timed out or 0 otherwise.
		if ErrorLevel   ; i.e. it's not blank or zero.
			return ; 	exitBecouseOfErrorInLine(A_LineNumber . " " . A_ScriptName . " " . Last_A_This)
		
		if(WINs=1)
			WINs:=0
		else
			WINs:=1
		
		IfWinExist , ahk_class TalkpadClass, , notepad
		{
			; DragonPad - 09-04-26_10-32.rtf ahk_class TalkpadClass
			if(isDragonMicrophoneOn=0)
			{
				isDragonMicrophoneOn:=1
				WinGetActiveTitle, titleBeforeDictation
      ;MsgBox, %titleBeforeDictation%
			;WinActivate  ;Last Found Window will be activated
			}
			else
			{
				;ToolTip3sec(isDragonMicrophoneOn)
				isDragonMicrophoneOn:=0
			;WinActivate, %titleBeforeDictation%
			}
			; now the microphone on off at the dragon speaking program
			Send,{ctrl down}{shift down}{alt down}s{alt up}{shift up}{ctrl up}
			
			
		}
		
  ;Ton an aus - toggles nur wen if(WINs=1)
		;~ MsgBox,14-12-23_11-21    `n WINs=%WINs% `n A_OSVersion = %A_OSVersion%
		if(WINs=1)
		{  
			if (  InStr(  A_OSVersion ,"WIN_" ) )
				Send {Volume_Mute}  ; Mute/unmute the master volume.
			SoundSet, +1, , mute  ; Toggle the master mute (set it to the opposite state)
  	;Send {Volume_Down 3}  ; Lower the master volume by 3 intervals.
		;Send {Volume_Mute}  ; Mute/unmute the master volume.
		}
		return
		
		#Down::Send {Volume_Down 3}  ; Lower the master volume by 3 intervals.
		#Up::Send {Volume_Up 3}  ; Upper the master volume by 3 intervals.

;~ numplus
		#IfWinActive ahk_class Notepad++
			^+NumpadAdd::
		Last_A_This:=A_ThisFunc . A_ThisLabel
		ToolTip1sec(A_LineNumber . " " . A_ScriptName . " " . Last_A_This)
		ControlSend,,^!+f,ahk_class Notepad++ ; fold All
		RETURN
		#IfWinActive ahk_class Notepad++
			^+NumpadSub::
		Last_A_This:=A_ThisFunc . A_ThisLabel
		ToolTip1sec(A_LineNumber . " " . A_ScriptName . " " . Last_A_This)
		ControlSend,,^!f,ahk_class Notepad++ ; fold All
		RETURN
		
		
;~ Alt-(0~8) Collapse the Level (0~8)
;~ Alt-Shift-0 Unfold All
		;~ Alt-Shift-(1~8) Uncollapse the Level (1~8)
		#IfWinActive ahk_class Notepad++
			!^::nPPcollapseLevel(0)
		#IfWinActive ahk_class Notepad++
			!1::nPPcollapseLevel(1)
		#IfWinActive ahk_class Notepad++
			!2::nPPcollapseLevel(2)
		#IfWinActive ahk_class Notepad++
			!3::nPPcollapseLevel(3)
		#IfWinActive ahk_class Notepad++
			!4::nPPcollapseLevel(4)
		#IfWinActive ahk_class Notepad++
			!5::nPPcollapseLevel(5)
		#IfWinActive ahk_class Notepad++
			!6::nPPcollapseLevel(6)
		#IfWinActive ahk_class Notepad++
			!7::nPPcollapseLevel(7)
		#IfWinActive ahk_class Notepad++
			!8::nPPcollapseLevel(8)
		
;#IfWinActive
		;^!c::MsgBox You pressed Control+Alt+C in a window other than Notepad/WordPad.
		
		
		KeyState(Key, State) {
			GetKeyState, S, %Key%, %State%
			Return, %S%
		}
		
		tp41fn(ComputerName, key1, key2)
		{


			if( ComputerName = "IBM-DE212688" )
				s:=key1
			else
				s:=key2 
			;~ SendPlay,%s% ; dont work anymore n15-05-08_15-12
			Suspend,on
			global a_doublequote
			doubleQuote="
			if(Trim(s) == doubleQuote)
				SendRaw,"
			else
				SendRaw,%s%
			;~  !"ï¿½$%6{66%6
			Suspend,off
			return
		}
		
;~ Alt-(0~8) Collapse the Level (0~8)
;~ Alt-Shift-0 Unfold All
		;~ Alt-Shift-(1~8) Uncollapse the Level (1~8)
		nPPcollapseLevel(level){
			ControlSend,,!0,ahk_class Notepad++ ; fold All
			if(level>0)
			{
				; Unfold
				Loop, %level%
					ControlSend,,{Shift down}!%A_Index%{Shift up},ahk_class Notepad++
			}
			return
		}
		
		;SetTitleMatchMode, 2
		#IfWinActive ahk_class Notepad++
			~^tab::
		Last_A_This:=A_ThisFunc . A_ThisLabel
		ToolTip1sec(A_LineNumber . " " . A_ScriptName . " " . A_ThisFunc . A_ThisLabel . "`nDies ist eine Notlï¿½sung unter Vista" )
		;WinActivate, ahk_class Notepad++
		;WinActivate, ahk_class #32770
		;ControlFocus, , ahk_class Notepad++  ;, WinText, ExcludeTitle, ExcludeText]
		Sleep,2000
		ToolTip1sec(A_LineNumber . " " . A_ScriptName . " " . A_ThisFunc . A_ThisLabel . "`nTabTab als Notlï¿½sung nach 5 Sekunden" )
		Send,!{Tab}!{Tab}
		;ControlClick, x200 y400, ahk_class Notepad++  ; Clicks at a set of coordinates
		;~^tab::ControlSend , N, hallo, ahk_class Notepad++ ; ControlSend , N,  ahk_class Notepad++ ;, WinText, WhichButton, ClickCount, Options, ExcludeTitle, ExcludeText]
		return
		
		
		
;ControlClick [, Control-or-Pos, WinTitle, WinText, WhichButton, ClickCount, Options, ExcludeTitle, ExcludeText]
;ControlSend [, Control, Keys, WinTitle, WinText, ExcludeTitle, ExcludeText]
		;kkkkk hallo kkkkkkkkhallohallohallohallohallohallo
		
		SetTitleMatchMode, 1
		#IfWinActive PowerCinema ahk_class Koan
			s::SoundSet, +1, , mute  ; Toggle the master mute (set it to the opposite state)
		
		;MegaGlest ahk_class SDL_app
		
		#IfWinActive Glest ahk_class Window1
			#IfWinActive Glest ahk_class SDL_app
				!PrintScreen::Send,{PrintScreen}
		;~ !PrintScreen macht in glest nur leere Bilder.
		
		#h::
		return
		
		shift & 1::
		Last_A_This:=A_ThisFunc . A_ThisLabel
		lll(A_LineNumber, A_ScriptName,Last_A_This)
		ToolTip1sec(A_LineNumber . " " . A_ScriptName . " " . Last_A_This )
		
		
		MouseGetPos, OutputVar1X, OutputVar1Y, OutputVar1Win
		;MsgBox,%OutputVar2X%, %OutputVar2Y%
		return
		"::
		MouseGetPos, OutputVar2X, OutputVar2Y, OutputVar2Win
		return
		§:: ; paragraph
		MouseGetPos, OutputVar3X, OutputVar3Y, OutputVar3Win
		return
		
		$::
		MouseGetPos, OutputVar4X, OutputVar4Y, OutputVar4Win
		return
		
		%::
		MouseGetPos, OutputVar5X, OutputVar5Y, OutputVar5Win
		return
		
		
		
		
		
		
		
		;Filter ahk_class MozillaUIWindowClass
		tc=Filter ahk_class MozillaUIWindowClass
		#IfWinActive Filter ahk_class MozillaUIWindowClass
			del::
		Last_A_This:=A_ThisFunc . A_ThisLabel
		ToolTip1sec(A_LineNumber . " " . A_ScriptName . " " . Last_A_This)
		;ControlSend, , {Del}, %tc%
		ControlSend, , !l, %tc% ; lï¿½schen
		;WinWait, WinTitle, WinText, Seconds [, ExcludeTitle, ExcludeText]
		WinWaitActive, Bestätigen ahk_class #32770, , 2
		WinWaitNotActive, Bestätigen ahk_class #32770, , 4
		; manchmal sind die doppelt da
		WinClose, Bestätigen ahk_class #32770
		
		
		return 
		return
		
		
		
		
		
		
		
		
		
		tc=Filter ahk_class MozillaUIWindowClass
		SetTitleMatchMode, 3
		#IfWinActive Filter ahk_class MozillaUIWindowClass
			f2::
		Last_A_This:=A_ThisFunc . A_ThisLabel
		ToolTip1sec(A_LineNumber . " " . A_ScriptName . " " . Last_A_This)
		;msgbox ,hallo
		ControlSend, , !b, %tc% ; lï¿½schen
		return 
		return 
		
		tc=Filter bearbeiten ahk_class #32770
		thunderbird_oneFilterRule_edit:
		#IfWinActive Filter bearbeiten ahk_class #32770
			~!a:: ; focus ausfï¿½hrende aktion
		;ControlSend, , !a, %tc%
		Sleep,50
		Send, {Tab 2}{f4}
		;ControlSend [, Control, Keys, WinTitle, WinText, ExcludeTitle, ExcludeText]
		return
		return
		
		tc=Filter ahk_class MozillaUIWindowClass
		thunderbird_filter_navigation_by_keyboard:
		SetTitleMatchMode, 3
		#IfWinActive Filter ahk_class MozillaUIWindowClass
		; should hold the filter status (aktiv/deaktiv)
			!o:: ; nach oben
		Send, {space}
		;sleep,10
		SendPlay, !o
		return
		
		!u:: ; nach unten
		Send, {space}
		;sleep,10
		SendPlay, !u 
		return
		
		!b:: ; bearbeiten
		Send, {space}
		;sleep,10
		SendPlay, !b 
		return
		
		!r:: ; reihenfolge fokus
		ControlSend, , !f, %tc%
		Sleep,10
		ControlSend, , {Tab}{Tab}, %tc%
    ;Sleep,10
    ;ControlSend, , !f{Tab}{Tab}, %tc%
		;Focus ,Such&begriff, Filter ahk_class MozillaUIWindowClass
		return
		
		;###############
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
;~ problem this is also used:
;~ Re: hcards2hmtl Filter jspWiki ahk_class MozillaUIWindowClass Verfassen: ahk_class
;>>>>>>>>>>>>>>>>>>>>>>>>>>>><>>>>>>>>>>>>>>>>>
		;~ "kkk" 
		SpaceSendRawLetter_in_win(l,fc)
		{
			SetTitleMatchMode, 3
			WinGetActiveTitle, at
			IfWinNotActive, %fc%
				return
			If( InStr(fc, at) )
			{
				Send, {space}
				SendRaw, %l% %at%
			}
			else
				SendRaw,%l%
			return
		}
		
		SetTitleMatchMode, 2
		fc=Filter ahk_class MozillaUIWindowClass
		#IfWinActive Filter ahk_class MozillaUIWindowClass
			a::SpaceSendRawLetter_in_win("a",fc)
		; ^\s+(\w)::\s+Send, {space}\s+SendRaw, \w\s+return
		b::SpaceSendRawLetter_in_win("b",fc)
		c::SpaceSendRawLetter_in_win("c",fc)
		d::SpaceSendRawLetter_in_win("d",fc)
		e::SpaceSendRawLetter_in_win("e",fc)
		f::SpaceSendRawLetter_in_win("f",fc)
		g::SpaceSendRawLetter_in_win("g",fc)
		h::SpaceSendRawLetter_in_win("h",fc)
		i::SpaceSendRawLetter_in_win("i",fc)
		j::SpaceSendRawLetter_in_win("j",fc)
		k::SpaceSendRawLetter_in_win("k",fc)
		l::SpaceSendRawLetter_in_win("l",fc)
		m::SpaceSendRawLetter_in_win("m",fc)
		n::SpaceSendRawLetter_in_win("n",fc)
		o::SpaceSendRawLetter_in_win("o",fc)
		p::SpaceSendRawLetter_in_win("p",fc)
		q::SpaceSendRawLetter_in_win("q",fc)
		r::SpaceSendRawLetter_in_win("r",fc)
		s::SpaceSendRawLetter_in_win("s",fc)
		t::SpaceSendRawLetter_in_win("t",fc)
		u::SpaceSendRawLetter_in_win("u",fc)
		v::SpaceSendRawLetter_in_win("v",fc)
		w::SpaceSendRawLetter_in_win("w",fc)
		x::SpaceSendRawLetter_in_win("x",fc)
		y::SpaceSendRawLetter_in_win("y",fc)
		z::SpaceSendRawLetter_in_win("z",fc)
		
		; code generation part
		if(0)
		{
			Last_A_This:=A_ThisFunc . A_ThisLabel
			ToolTip1sec(A_LineNumber . " " . A_ScriptName . " " . Last_A_This)
    	;Send, {space}
    	;Sleep, 1000
			;SendRaw, a
			
			;97-122 (lowercase a-z).
			if(1){
				s=#IfWinActive Filter ahk_class MozillaUIWindowClass
				Loop , 26
				{
					l:=Chr(a_index+96) 
					
          ;Last_A_This:=A_ThisFunc . A_ThisLabel
					;ToolTip1sec(A_LineNumber . " " . A_ScriptName . " " . Last_A_This)
					s=%s%%l%::`n
					s=%s%Send, {space}`n SendRaw, %l% `n
					s=%s%return`n
				}
				s=%s%return`n
				clipboard:=s
				MsgBox, %clipboard%
			}
			return 
		}
		return
		
		;~ same hotkey subroutine executed by more than one variant:
		#IfWinActive In Datei speichern ahk_class #32770
			*Space::
		#IfWinActive Bitte geben Sie den Dateinamen an`, unter dem die Datei gespeichert werden sollï¿½ ahk_class #32770
			*Space::
		#IfWinActive Sichern als ahk_class #32770
			*Space::
		#IfWinActive Enter name of file 
			*Space::
		#IfWinActive Speichern unter ahk_class #32770
			*Space::
		#IfWinActive Save as ahk_class #32770
			*Space::
		#IfWinActive Save As ahk_class #32770
			*Space::
		Send,_
		return  
		
		#IfWinActive Dragon NaturallySpeaking 11 - InstallShield Wizard ahk_class MsiDialogCloseClass
			#-::
		NewStr=Clipboard
		NewStr:=NewStr
		ToolTip1sec(A_LineNumber . " " . A_ScriptName . " " . Last_A_This)
		;StringReplace,NewStr,NewStr,-,{tab},All
		StringReplace,NewStr,NewStr,-,,All
		SendEvent,%NewStr%
		return
		
		
		
		
		
		
		
		#IfWinActive ahk_class SciTEWindow 
			
;SetTitleMatchMode,2
; VBA_BAWVerwaltung [Entwerfen] - [Form_frmMain (Code)] ahk_class wndclass_desked_gsk
		;#IfWinActive,(Code)] ahk_class wndclass_desked_gsk
		^+f::
		; SourceCode_RAW_Files_17-11-11_02-00 - [C:\blue line\SourceCode_RAW_Files_17-11-11_02-00] - ...\BAWVerwaltung_BAWODBC.bas - PyCharm Community Edition 2017.2.4 ahk_class SunAwtFrame
		doSelectLine:=1
		c2:=Trim(SubStr(Clipboard,1,355))
		if(!RegExMatch(c2,"\n") && RegExMatch(c2,"\s+?")){
			; Vielleicht sind mehrere Wörter drin. Darf man gerne auch so benutzen : word1.*word2 20.11.2017 20:50
			c2 := RegExReplace(c2,"\s+",".*")
		;MsgBox,% c2
		}else
			c2:=""
		c:=copyWord2clipBoard(doSelectLine)
		;MsgBox, 'SL 17-11-20_16-31
		t=- PyCharm Community Edition 2017.2.4 ahk_class SunAwtFrame
		t=ahk_class SunAwtFrame
		ToolTip1sec(A_LineNumber   " "   A_LineFile   " "   Last_A_This) 
		WinActivate,% t
		WinWaitActive,% t,,1
		Suspend,on
		Send,^+f
		WinWaitNotActive,% t,,1 ; wait for empty title name  'SL 20.11.2017 18:18
		IfWinActive,% t
		{
			MsgBox,ups  'SL 17-11-20_18-19
			return
		}
		Sleep,400 ; bei 500 (fast) gehts immer, bei 150 geht wenn das suchfenster noch nciht offen  'SL 20.11.2017 18:27
  ;SetTitleMatchMode,1
		;WinActivate,ahk_class SunAwtFrame
		WinGetActiveTitle,activeTitle
		WinGetClass, activeClass, %activeTitle% 
		if(activeTitle=="" && activeClass=="SunAwtFrame"){
			Send,^a%c%
			; Vielleicht sind mehrere Wörter drin. Darf man gerne auch so benutzen : word1.*word2 20.11.2017 20:50
			if(c2){
				Clipboard:=c2
				ToolTip3sec(c2 . "`n=Clipboard`n" . A_LineNumber . " " . A_ScriptName . " " . Last_A_This)
			}
		}else{
			Clipboard:=c
			MsgBox,Clipboard=%Clipboard% `n `n at=%A_LineNumber%: %activeTitle% ac=%activeClass%
		}
		Suspend,Off
		return
		
  ; thats the standard editor for autohotkey. i want shortcats like i use it in phpstorm
  ; comment
		; ctrl shift b
		^NumpadDiv::
		Last_A_This:=A_ThisFunc . A_ThisLabel
		ToolTip1sec(A_LineNumber . " " . A_ScriptName . " " . Last_A_This)
		
		;Send,{CtrlDown}{ShiftDown}b{ShiftUp}{CtrlUp
		Send,^q{Down}
		return
		
		
		
		
		#IfWinActive,- IntelliJ IDEA 14.1.3 ahk_class SunAwtFrame 
			Strg_Shift_5:
		^%::
		+%::
		tipp_use_STRG_J = tipp: use STRG+J type sout
		Last_A_This:=A_ThisFunc . A_ThisLabel
		ToolTip1sec(A_LineNumber . " " . A_ScriptName . " " . Last_A_This . "`n" . tipp_use_STRG_J)
		
		if(StrLen(clipboard) < 100 )    
		{
			c := clipboard
			
			c2 := "{NumpadAdd} "" = " . c . "\n"""
			; k
			strLen_c2 := StrLen(c2) - StrLen("{NumpadAdd}") + 1
			Suspend,on
			
			Send,%c% %c2%{ShiftDown}{Left %strLen_c2%}{ShiftUp}
			Suspend,off
		}
		return
		
		
		;<<<<<<<< remoteDesktop <<<< 171115175026 <<<< 15.11.2017 17:50:26 <<<<
		
		; #IfWinActive,ahk_class TscShellContainerClass
		#IfWinActive,Microsoft Visual Basic - 
			f1:: ; search into the web 15.11.2017 19:43
		c:=RegExReplace(SubStr(Clipboard,1,500),"[^\w\d ]+","")
		; run,https://www.google.de/search?q=visual+basic+2010+%c%
		run,https://www.google.de/search?q=`%22visual+basic+6`%22+6.4+%c%
		return
		
		
		#IfWinActive,ahk_class TscShellContainerClass
			Ctrl & BackSpace::
		Suspend,on
		Last_A_This:=A_ThisFunc . A_ThisLabel
		ToolTip1sec(A_LineNumber . " " . A_ScriptName . " " . Last_A_This)
		
		if(!GetKeyState("shift", "P")){
			send,{AppsKey}
			Sleep,500
			Send,z
		}else
			Send,^{BackSpace}
		Suspend,off
		return
		
		
		
		
		
		
		SetTitleMatchMode,3 ; vermtlich ohne auswirkung ... die erste einstellung zählt. also eine methode: erst nach klasse fragen und darin dann weiter genauer differenzieren 15.11.2017 19:35
		; #IfWinActive,blue line  ahk_class TscShellContainerClass ; so funktioniert das ausserhalb des remoteDesktops 15.11.2017 17:50
		#IfWinActive,Nightly ahk_class TscShellContainerClass
		; #IfWinActive,Nightly ahk_class CabinetWClass ; <= so innerhalb des remoteDesktops, bwz normal bei windows 15.11.2017 17:53
			Shift & Del::
		msg=:( Oops: Shift & Del
		ToolTip5sec(msg . A_LineNumber . " " . A_ScriptName . " " . Last_A_This) 
		return
		
		Enter:: ; verhindern von enter ohne shift öffnet modul zum enwickeln anstatt es zu starten durch enter 15.11.2017 18:11
		if(!GetKeyState("shift", "P")){
			msg= enter without shift ... inside Nightly :( 17-11-15_18-10 `n if you press enter again in next seconds you will able to do it. hurry ;) 
			Msgbox,%msg% `n (%A_ScriptName%~%A_LineNumber%) 
		;Send,{ShiftDown}{Enter}{ShiftUp} ; <= das geht leier nicht ... auch nict über SetCapsLockState, On
		}
		return
		; ~f7:: ; öffnet modul zum enwickeln anstatt es zu starten durch enter 
		; return ; funktioniert nicht 15.11.2017 18:07
		SetCapsLockState, On
		; funktioniert nicht llll egal.
		Send,{ShiftDown}
		Sleep,1000
		Loop,99
		{
			if(1 || GetKeyState("shift", "P")){
				SetKeyDelay,80,80
				Send,+{Enter}
				break
			}
			Sleep,100
		}
		Send,{ShiftUp}
		SetCapsLockState, Off
		
		return
		;>>>>>>>> remoteDesktop >>>> 171115175030 >>>> 15.11.2017 17:50:30 >>>>
		
		#IfWinActive Chrome Remote Desktop
			^w::
		m= Oops. dont close Chrome Remote Desktop 
		ToolTip3sec(A_LineNumber . " " . A_ScriptName . "`n " . m)
		return
		
		#IfWinActive Chrome Remote Desktop
			esc::
		m= Oops. pls leave it fullscreen. Chrome Remote Desktop 
		ToolTip3sec(A_LineNumber . " " . A_ScriptName . "`n " . m)
		return
		
		
		;~ same hotkey subroutine executed by more than one variant:
		#IfWinActive In Datei speichern ahk_class #32770
			^v::
		#IfWinActive Bitte geben Sie den Dateinamen an`, unter dem die Datei gespeichert werden sollï¿½ ahk_class #32770
			^v::
		#IfWinActive Sichern als ahk_class #32770
			^v::
		#IfWinActive Enter name of file 
			^v::
		#IfWinActive Speichern unter ahk_class #32770
			^v::
		#IfWinActive Save As ahk_class #32770
			^v::
		#IfWinActive Save as ahk_class #32770
			^v::
		Last_A_This:=A_ThisFunc . A_ThisLabel
		ToolTip1sec(A_LineNumber . " " . A_ScriptName . " " . Last_A_This)
		
		
		;NewStr := clipboard
		NewStr := SubStr(clipboard, 1 , 400) ;specify 1 to start at the first character
    ;NewStr := RegExReplace(NewStr, "(\w+)", "$1") 
    ;RegExReplace
		;NewStr:= RegExReplace(NewStr, "[A-Za-z]", "")  ;  funktioniert
		NewStr := RegExReplace(NewStr, "\s+", "_") 
		NewStr:= RegExReplace(NewStr, ".*?([A-Za-z_\d\\\.\:]*)", "$1")  ;  
		NewStr := SubStr(NewStr, 1 , 255) ;specify 1 to start at the funktioniert
		
		Needle = .
		StringGetPos, pos, NewStr, %Needle%
		if pos >= 0
		{
		;MsgBox, The string was found at position %pos%.
		}
		else
		{
			NewStr=%NewStr%.txt
		}
		NewStr:=NewStr
		
		Suspend,On
		SendEvent,%NewStr%+{left 4}
		Suspend,Off
		
		;NewStr := RegExReplace(NewStr, "(\w+)", "$1") 
		return  
		
		Hotkey, IfWinActive, PowerCinema
		Hotkey, p, Lbl_p
		
;~ notepad++ hat die blï¿½de angewohnheit alt+d zu benutzen.
;~ #IfWinActive - Notepad++ ahk_class Notepad++
  ; !d::
  ; msgbox, no
		;~ return
		
		
		#IfWinActive ahk_class freemind.main.FreeMind
			#ö:: ; gï¿½ï¿½gle -suche
		Last_A_This:=A_ThisFunc . A_ThisLabel
		ToolTip1sec(A_LineNumber . " " . A_ScriptName . " " . Last_A_This)
		;SendEvent,^+c ; einfach kopiern ... reicht aber nicht bei Emails und links
		SendEvent,{f2}
		Sleep,500
		SendEvent,^a^c ; einfach kopiern ... reicht aber nicht bei Emails und links
		run,http://www.google.com/search?q=%clipboard%&esrch=BetaShortcuts
		return
		
		
		#IfWinActive PowerCinema ahk_class Koan
			p::goto Lbl_p
		
		;===================================================================
		
		
		
		
		Lbl_p:
		; zapp durch PowerCinema
		if zappPowerCinemaUp=on
		{
			;programmNummer=1
			zappPowerCinemaUp=off
		}
		else
		{
			zappPowerCinemaUp=on
			programmNummer+=1
		;SetTimer, LblPowerCinemaUp , 1000
		}
		SetTimer, LblPowerCinemaUp , %zappPowerCinemaUp%
		ToolTip, programmNummer=%programmNummer%`n zappPowerCinemaUp=%zappPowerCinemaUp%
		SetTimer, RemoveToolTip, 5000
		;msgbox,pause
		
		;SetTimer, Label [, Period|On|Off, Priority]
		return
		
		ToggleFullScreen(ByRef hWnd)
		{
			IniFile := A_ScriptName ".tmp"
			IniRead, Array, %IniFile%, Handles, %hWnd%0, Empty
			If (Array="Empty")
			{
				hMenu := DllCall("GetMenu", "UInt", hWnd)
				WinGet, Maximized, MinMax
				DllCall("SetMenu", "UInt", hWnd, "UInt", 0)
				WinMaximize
				WinSet, Style, -0xC00000
				IniWrite, %hMenu%`,%Maximized%, %IniFile%, Handles, %hWnd%
			}
			Else
			{
				StringSplit, Array, Array, `,
				hMenu := Array1
				Maximized := Array2
				DllCall("SetMenu", "UInt", hWnd, "UInt", hMenu)
				If !(Maximized)
				{
					WinRestore
				}
				WinSet, Style, +0xC00000
				IniDelete, %IniFile%, Handles, %hWnd%
			}
		}
		
		
		
		Lbl_Toggle_ReloudFirefox:
		WinGetTitle, Title, A
		if WinExist("ahk_class MozillaUIWindowClass"){
			
			WinActivate  ; Uses the last found window.
			ControlSend, , {f5}, ahk_class MozillaUIWindowClass
			Last_A_This:=A_ThisFunc . A_ThisLabel
			ToolTip3sec(A_LineNumber . " " . A_ScriptName . " " . Last_A_This)
		}
		ToolTip3sec(A_LineNumber   " "   A_LineFile   " "   Last_A_This) 
		forceWinActivate(Title)
		;run,http://www.ustream.tv/channel/gbs-papst-demo-berlin-22-09-11
		sleep,9000
		return
		
		LblPowerCinemaUp:
		ToolTip,  LblPowerCinemaUp says hello
		SetTimer, RemoveToolTip, 2000
		pc=PowerCinema ahk_class Koan
		pc=PowerCinema
		
		WinGetPos , x1, y1, w, h, %pc% ;, WinText, ExcludeTitle, 
		Sleep,50
		WinMove, %pc%, , 0, 0 ; [, Width, Height, ExcludeTitle, 
	;Sleep,750
	;WinGetPos , x, y, w, h, %pc% ;, WinText, ExcludeTitle, 
		;Sleep,50
		
		
	; lauter klicken:
	; ControlClick, x333 y%b%, PowerCinema
	; decrement programm
		;ControlClick, x412 y%b%, PowerCinema
		b:=h-20
		b2:=h-22
		; increment programm
		Sleep,100
		MouseGetPos, mX, mY 
		MouseMove, 377, %b%, 0
		ControlClick, x377 y%b%, %pc%
		;ControlClick, x376 y%b2%, %pc%
		Sleep,250
		MouseMove, %mX%, %mY%, 0
		WinMove, %pc%, , x1, y1 ; [, Width, Height, ExcludeTitle, 
		;  tooltip,%programmNummer% %pc%
		sleep,3000
		;  WinActivate , %Title%
		return
		
		
		
		
		
		openUrlInOpenFirefoxBrowser(url)
		{
			SetTitleMatchMode, 2
			firfox=Mozilla Firefox ahk_class MozillaUIWindowClass
			WinActivate,%firfox%
			WinWaitActive,%firfox%
			WinGetActiveTitle, myActiveTitle
			
			; Startseite
			if(0)
			{
				Loop, 30
				{
					send,!{home} ; startseite
					sleep,100
					IfWinNotActive,%myActiveTitle%
						break
				}
			}
			Send,^t ; neues tab
			WinGetActiveTitle, myActiveTitle
			sleep,1000
  ;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
			; nun endlich die url
			loop,5
			{
				send,{f6}
				sleep,500
    ;send,^a
				;send,{del}
				Suspend,On
				Suspend,On
				
				sendplay,%url%
				Suspend,Off
				
				send,{enter}
				Suspend,Off
				
				;WinWaitActive [, WinTitle, WinText, Seconds, ExcludeTitle, ExcludeText]
				ifWinNotActive,%myActiveTitle%
					break
			}
			;>>>>>>>>>>>>>>>>>>>>>>>><>>>>>>>>>>>>>>>>>>>>>
			return
		}
		
		
		
		
		
		
		
		
		
		forceWinActivate(t)
		{
			sleep,150
			ifwinactive,%t%
				return
	; Windows Vista verhï¿½lt sich in vielen Dingen eigenartig und eigenwillig.
			; im folgenden soll erzwungen werden, was eigentlich selbstverstï¿½ndlich sein sollte.
			Loop,10
			{
				WinActivate ,%t%
				WinWaitActive,%t%,,1
				ifwinactive,%t%
					break
			;WinWaitActive [, WinTitle, WinText, Seconds, ExcludeTitle, ExcludeText]
			}
			return
		}
		
		;~ ToolTipSec.inc.ahk
		
		
		
		
		;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
		killAllOpenWinWithoutSave(w)
		{
			MsgBox, 4,, Would you KILL KILL now all "...%w%" ? (press Yes or No) `n`n It will take seconds for KILL each of this. `nso its a good chance for making a short nap now.
			IfMsgBox Yes
				ToolTip3sec("You pressed Yes.`n OK. Now all '...%w%' - Emails will be KILLED.")
			else
				return
			
			
			a_index_backup:=0 
			Loop , 100
			{
				a_index_backup:=a_index
				SetTitleMatchMode, 2
				IfWinNotActive,%w%, , WinActivate,%w%, 
					WinWaitActive,%w%,,1 ; Muss nicht eins existieren.
				IfWinActive,%w%
				{
					;MsgBox,%w% gefunden.
					WinGetActiveTitle, wat
					;sendActiveEmail()
					WinKill , %wat%,,1
        ;WinKill [, WinTitle, WinText, SecondsToWait, ExcludeTitle, ExcludeText]
					; Nachricht speichern ahk_class #32770
					WinWaitClose,%wat%,,1
				;wiWinWaitClose, WinTitle, WinText, Seconds [, ExcludeTitle, ExcludeText]
				}
				else
					break
			}
			return
		}
		;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
		
		
		StrgAStrgA()
		{
;#IfWinActive Mobile Partner ahk_class #32770
;~ manche dialogfelder haben kein strg+a das braucht man aber
			;~ daher hier ein doppel strg+a+a macht trotzdem alles markiert.
			Last_A_This:=A_ThisFunc . A_ThisLabel
			ToolTip1sec(A_LineNumber . " " . A_ScriptName . " " . Last_A_This)
	;tooltip,wait for ^aa
	; Wait for the user to press any key. 
			;SendEvent,^a
			Transform, CtrlA, Chr, 1 ; character for Ctrl-A in the CtrlA var. 
			Input, OutputVar, L1 M I T2, {LControl}{RControl}{LAlt}{RAlt}{Shift}{LShift}{RShift}{LWin}{RWin}{AppsKey}{F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Left}{Right}{Up}{Down}{Home}{End}{PgUp}{PgDn}{Del}{Ins}{BS}{Capslock}{Numlock}{PrintScreen}{Pause}
			tooltip,
			
			;return ; demo mode: that you could see that it stops
			
			;Suspend,On
			if OutputVar = %CtrlA%
			{
				MsgBox,double STRG+A found
				Send,{Control down}{End}
				Sleep,1000 ; demo mode. slow down that you could see something
				Send,{Shift down}{Home}{Shift up}
				Sleep,1000 ; demo mode. slow down that you could see something
				Send,{Control up}
			}
			else
			{
				;Send,%OutputVar% ;  i stoped that. it not works any more at 12-11-22_10-57
				
				
				;MsgBox,double STRG+A found
				Send,{Control down}{End}
				Sleep,1000 ; demo mode. slow down that you could see something
				Send,{Shift down}{Home}{Shift up}
				Sleep,1000 ; demo mode. slow down that you could see something
				Send,{Control up}
				
				
				
			;MsgBox,else %Last_A_This%
			}
    ;Suspend,Off
			;MsgBox,return %Last_A_This%
			return
			
		}
;~ End of StrgAStrgA:
		;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
		
		return  ; probably redundant. its more secure if we do that.
		
		ReloadScript:
		GetKeyState, state, Shift
		if( GetKeyState("Shift", "P") || GetKeyState("Shift", "D") || GetKeyState("Shift", "T") || GetKeyState("Capslock", "T"))
			return ; a reload could maybe hurt your selection process of text becouse of the Send,{ShiftUp} at the biginning of this script.
		
		Last_A_This:=A_ThisFunc . A_ThisLabel
		lll(A_LineNumber, A_ScriptName,Last_A_This)
		ToolTip1sec(A_LineNumber . " " . A_ScriptName . " " . Last_A_This )
		Sleep,200
		
		Reload
		return
		
		showTitle:
  ;~ WinGetActiveTitle, at
		;setCoordModeAll()
		
		; __ ____ ______ __ __
		
		WinGetActiveStats, at, Width, Height, X, Y 
		settitlematchmode,3
		WinGetClass, ac , %at%
		
		if(!RegExMatch(at . ac, "\w+" ))
		{
    ;~ MsgBox, % at . ac
			; boring dont need it
			return
		}  
		
		; WinGetActiveStats, Title, Width, Height, X, Y  ____ __ __
		
		
		MouseGetPos,mousex,mousey,mousewindowtitle
		ControlGet ctrlVisible, Visible ; ,, SunAwtCanvas1 
		;ControlGet, OutputVar, Cmd, [Value, Control, WinTitle, WinText, ExcludeTitle, ExcludeText
		
		; ToolTip, % "TextStatusTitle`n" A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\")
		
		c0=needle=%at% ahk_class %ac%
		activeTitleFromShowTitleSetTimer=%c0% `; mouseWindowTitle=%mouseWindowTitle%  `; `n `; if(RegExMatch(at,needle:="(?P<_n>\.pdf)",found)){ }
		activeTitleFromShowTitleSetTimer .= "`n`; " A_LineNumber " " RegExReplace(A_LineFile, ".*\\")
		
		t = 
(
/*
Text:=""
WinGetPos, wX, wY, wW, wH, `% needle ; https://www.autohotkey.com/boards/viewtopic.php?f=6&t=17834&p=271791#p271791
if(ok:=FindText(wX, wY,wX+wW,wY+wH, 0.3, 0.1, Text)) ; findTextTool_demo_backwardsLoop_bottomTooTop(ok)
	for i,v in ok ;  forward loop (top to bottom)
 		if(i<=222){ ; how many immages 2 is good for demo ; ; MouseTip(v.1+v.3//2, v.2+v.4//2)
 			X:=v.1+v.3//2, Y:=v.2+v.4//2, W:=ok.1.3, H:=ok.1.4, Comment:=ok.1.5, X+=W//2, Y+=H//2
			MouseMove,`% X+50 + mod(A_Index,2)*40,`% Y ; MouseClick,left,`% X+50,`% Y	; Sleep,10
		} else
			break
*/
		)
		activeTitleFromShowTitleSetTimer .= "`n" t
		
		w2right := Width - mousex
		
		ToolTip, %ctrlVisible% `n %activeTitleFromShowTitleSetTimer% `n %ctrlVisible% `n w=%Width% (%w2right% = w-x) `n x=%mousex% y=%mousey% t=%mousewindowtitle%
		;Clipboard := c0
		SetTimer, RemoveToolTip, 4000
		return
		
		;<<<<<<<< clickBookmarklet <<<< 171016013044 <<<< 16.10.2017 01:30:44 <<<<
		clickBookmarklet(firstLetter,wintit){
			; funktioniert 15.10.2017 20:57
			if(!WinActivateTry(wintit,3))
				Msgbox,:( `n (%A_ScriptName%~%A_LineNumber%) 
			Sleep,1000
			Send,{AltDown}{ShiftDown}b{ShiftUp}{AltUp} ; select first from bookmark list (Folder BL)
			Send,{Down} ; open the list
			Sleep,100
			Send,%firstLetter% ; choose bookmarlet
			Sleep,100
			return
		}
		;>>>>>>>> clickBookmarklet >>>> 171016013049 >>>> 16.10.2017 01:30:49 >>>>
		
		
		MyLabel:
		Msgbox,17-11-16_12-36`n (%A_ScriptName%~%A_LineNumber%) 
		return
		
		lblCopyCaret2clipboard:
		if(A_TimeIdlePhysical < 3000 || A_TimeIdle < 3000)
			return
		copyWord2clipBoard() 
		Sleep,1500
		tooltip,clipboard = %clipboard% `n (line:%A_LineNumber%) `n 
		return
		
		
		ODT2everythingSearch_and_step_down(doShowItInEverything := true, doOpenFirstFileOfEverythingResult := false){
			WinGetActiveTitle,at
			Last_A_This:=A_ThisFunc . A_ThisLabel
			ToolTip1sec(A_LineNumber . " " . A_ScriptName . " " . Last_A_This)
			c:=""
			if(0)
				c := copySelection2clipBoard()
			else{
				send,^c
				c = %clipboard%
			}
			c := trim(c , " `t`n`r")
			;c := RegExReplace(c, "m)\s+" , " ")
			if(!c){
				tooltip, :(   !c (line:%A_LineNumber%)  18-05-22_18-53
				if(GetKeyState("shift","P"))
					send,{shiftup} ; dont know sometimes useful
				if(GetKeyState("ctrl","P"))
					send,{CtrlUp}  ; dont know sometimes useful
				if(GetKeyState("alt","P"))
					send,{AltUp}  ; dont know sometimes useful
				
				ifwinActive,% at
					send,{down}
				Suspend,off
				return c
			}
			Suspend,on 
			
			; sleep,1000
			if(doShowItInEverything){
				send,{CtrlDown}+2{ctrlup}
				WinWait,Everything ahk_class EVERYTHING,,3
				WinActivate,Everything ahk_class EVERYTHING    
				;msgbox,18-05-22_16-54
				WinWaitActive,Everything ahk_class EVERYTHING,,3
			}
			
			ifWinNotActive,Everything ahk_class EVERYTHING
			{
				if(GetKeyState("shift","P"))
					send,{shiftup} ; dont know sometimes useful
				if(GetKeyState("ctrl","P"))
					send,{CtrlUp}  ; dont know sometimes useful
				if(GetKeyState("alt","P"))
					send,{AltUp}  ; dont know sometimes useful
				
				
				ifwinActive,% at
					send,{down}
				Suspend,off
				tooltip,:( winNotactive Everything
				return c
			}
			
			;If (A_TimeIdle < 50 || GetKeyState("ctrl", "P") || GetKeyState("Alt", "P") || GetKeyState("Shift", "P") || GetKeyState("LWin", "P") || GetKeyState("RWin", "P")  || GetKeyState("LButton", "P") ){
			if(c){
				;clipboard := c
				ifWinActive,Everything ahk_class EVERYTHING
				{
					dir = E:\fre\private\office\amt\arge_harz\6mon_Pakete
					clipboard = path:%dir% endwith:.pdf %clipboard%
					; send,GK 08.04.2015 bis 05.05.2015.pdf
					sleep,100
					send,^v
				}
			}
    ;msgbox,%clipboard% = clipboard
    ; sleep,100
    ;send,^v
    ;16.05.2018 09:55  msgbox,test 18-05-16_08-34
			;msgbox,18-05-22_16-54
			if(GetKeyState("shift","P"))
				send,{shiftup} ; dont know sometimes useful
			if(GetKeyState("ctrl","P"))
				send,{CtrlUp}  ; dont know sometimes useful
			if(GetKeyState("alt","P"))
				send,{AltUp}  ; dont know sometimes useful
			
			if(doOpenFirstFileOfEverythingResult){
				;sleep,100
				send,{home}{down}
				;sleep,300
				send,{enter}
				;msgbox, 18-05-28_23-03
				tooltip,WinWaitNotActive Everything
				WinWaitNotActive,Everything ahk_class EVERYTHING
				sleep,4000
				WinClose,Everything ahk_class EVERYTHING
			}
			;else{
			WinActivate,% at
			WinWaitActive,% at,,2
			ifwinActive,% at
				send,{down}
			;}
			Suspend,off
			
			; EndOf: ODT2everythingSearch_and_step_down()
			return c
		}
		
		
		
		walkThrowQuote(mc, quoteName){
			smalLenDef:=180
			mc_len:=StrLen(mc)
			ToolTip1sec(A_LineNumber . " " . A_ScriptName . " " . Last_A_This)
			first7:=SubStr(mc , 1 , 7) ; [quote=
			
			;MsgBox, %mc%
			if( quoteName = "" AND first7 = "[quote=" )
			{
				mc:=SubStr(mc , 9) ; [quote=
				quoteName := RegExReplace(mc, "([\w\- ]*).*", "$1" )
				ToolTip1sec("quoteName = " . quoteName)
			;MsgBox, %quoteName%
			}
			else
			{  
				quoteName := RegExReplace(quoteName , "[\n\r\t]*", "" )
				; InputBox, OutputVar , Title, Prompt, HIDE, Width, Height, X, Y, Font, Timeout, Default
				if( mc <> ""){
					if( quoteName = "" )
						InputBox, quoteName, Enter quoteName, , , , , , , , , jeeswg
					if ErrorLevel 
						return quoteName
					;MsgBox, %mc_len%
					
					if( first7 = "[quote=" )
						mc:=SubStr(mc , 7 + strlen(quoteName)+4 ) ; [quote=
					
					
        ;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
        ; qoutes sichern
					;FormatTime, timestamp, %A_now%,dd.MM.yyyy
					FormatTime, backUpQuoteStamp, %A_now%,yyMMddHHmm
					Loop, 11
					{
            ;mc=[quote="Sebastian Lauffer"]Webseite inhaltlich weit gehend abgeschlossen 20.07.2010[/quote]
						; FoundPos := RegExMatch(Haystack, NeedleRegEx [, UnquotedOutputVar = "", StartingPosition = 1])
						
						; Findet das erste vorkommen [quote=[^=]*quote]
						FoundPos := RegExMatch(mc, "m)(\[quote=[^=]*quote])", ThisFound )  ; Returns 1 and stores "XYZ" in SubPat1.
						if ( FoundPos < 1 )
							break
						
						;MsgBox, ThisFound=%ThisFound%
						
            ;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
						; speichdrt den fund
						ArrayPosMark%A_Index% := backUpQuoteStamp . %A_Index% 
						ArrayString%A_Index% := ThisFound
						;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>><>>>>>>>>>>>
						
            ;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
            ; fï¿½gt marker ein
            ; Remove all CR+LF's from the clipboard contents: 
            ; StringReplace, clipboard, clipboard, `r`n, , All
						;StringReplace, mc, mc, ThisFound , ArrayPosMark%A_Index%, All
						
						;StringGetPos, position, mc, ThisFound
						position := InStr(mc, ThisFound ) ;
						; SubStr(String, StartingPos [, Length])
						mcTop:=SubStr(mc , 1 , position -1 ) ;  + strlen(quoteName)+4,
						;MsgBox, mcTop=%mcTop%
						mcBot:=SubStr(mc , position + strlen(ThisFound) ) ;
						;MsgBox, mcBot=%mcBot%
						mc:=mcTop . ArrayPosMark%A_Index% . mcBot   
						;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
						
						
						if(0)
						{
							test:= ArrayString%A_Index%
							MsgBox, test=%test%
						}
						;return
						
						;mc:= RegExReplace(quoteName , "[\n\r\t]*", "" )
						
            ;MsgBox, Iteration number is %A_Index%.  ; A_Index will be 1, 2, then 3
					;Sleep, 100
					}
					
					
					;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
					
					;MsgBox, mc=%mc%
					
        ;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
					; qoutes wieder einfï¿½gen
					Loop, 11
					{
            ;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
						; speichdrt den fund
						ArrayPosMark%A_Index% := backUpQuoteStamp . %A_Index% 
						; ArrayString%A_Index% := ThisFound
						ThisFound := ArrayString%A_Index%
						if(0)
						{
							MsgBox, ThisFound=%ThisFound%
							return
						}
						
						;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>><>>>>>>>>>>>
						
            ;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
						; fï¿½gt quotes an marker wieder ein
						
						;StringGetPos, position, mc, ThisFound
						position := InStr(mc, ArrayPosMark%A_Index% ) ;
						if ( position < 1 )
							break
						MsgBox, %position%
						; SubStr(String, StartingPos [, Length])
						mcTop:=SubStr(mc , 1 , position -1 ) ;  + strlen(quoteName)+4,
						;MsgBox, mcTop=%mcTop%
						mcBot:=SubStr(mc , position + strlen(ArrayPosMark%A_Index%) ) ;
						;MsgBox, mcBot=%mcBot%
						mc:=mcTop . ThisFound . mcBot   
						;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
						
						;MsgBox, mc=%mc%
						
						if(0)
						{
							test:= ArrayString%A_Index%
							MsgBox, test=%test%
						}
						
					}
					;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
					
					
					
					if(0)
					{
						MsgBox, mc=%mc%
						return
					}
					;MsgBox, mc=%mc%
					
					; `r`n`r`n
					if(mc_len > smalLenDef)
					{
						; auftrennen bei leerzeile
						StringReplace, mc, mc,  `r`n`r`n , [/quote]`r`n`r`n[quote="%quoteName%"]`n, all
					}
					;RegExReplace(quoteName, "([\w ]*).*", "$1" )
					
					backupClipboard:=clipboard
					clipboard=[quote="%quoteName%"]`n%mc%[/quote]`n`n
					Suspend, On
					SendEvent,^v
					Suspend, Off
					clipboard:=backupClipboard
					
					
					
				}
				else
				{
					quoteName := ""
					ToolTip1sec("quoteName := `"`"")
				}
				
			}
			return quoteName
		}
		
		
		;       runIfNotExist("auto_Sleep_hibernation_Shutdown_PC_in_night.ahk","auto_Sleep_hibernation_Shutdown_PC_in_night")
		
		
	; doNoTrayIcon(){
	;	#notrayicon
		;}
		
		lblCheckTrayIconStatus:
		showTempTrayIf_isNearTrayMenue(iconAdress)		
		DetectHiddenWindows,Off
		IfWinExist,%A_ScriptName%_icon,ExitApp %A_ScriptName% ; message from child DynaRun() script
		{
			WinClose,%A_ScriptName%_icon
			ExitApp
		}
		return
		
		
		;<<<<<<<< timerLbl2000
		timerLbl2000:
		
	; tooltip,% m
	;fileNameWithoutPATHandEXT := RegExReplace(A_ScriptName, ".*\\([\w\s\._]+)\.\w+$", "$1") "icon"
		;showTempTrayIf_isNearTrayMenue(){
		; check_some_keys_hanging_or_freezed:
		if( A_TimeIdlePhysical < 1000 * 7 )
			return
		fixBug_Alt_Shift_Ctrl_hanging_down()
		
;		runIfNotExist("cron.ahk","auto_Sleep_hibernation_Shutdown_PC_in_night")
		;		runIfNotExist("cron.ahk","cron.ahk")
		
		return
		;>>>>>>>> timerLbl200 ><> 180901042855 >>>> 1.0.2018 04:28:55 >>>>
		
		;<<<<<<<< check_auto_Sleep_hibernation_Shutdown_PC_in_night <<<< 1890104:02 
		check_auto_Sleep_hibernation_Shutdown_PC_in_night(){
			DetectHiddenWindows,On
			runIfNotExist("auto_Sleep_hibernation_Shutdown_PC_in_night.ahk","auto_Sleep_hibernation_Shutdown_PC_in_night")
			DetectHiddenWindows,off
		}
		;>>>>>>>> check_auto_Sleep_hibernation_Shutdown_PC_in_night >>>> 1890104}2142 >>>> 01.9.218 
		
		
		
		fixBug_Alt_Shift_Ctrl_hanging_down(){
			; 30.08.2018 13:52 it sometimes happesn. and if it happens then its really ugly !!!! :( !!
			Suspend,On
			if( GetKeyState("Alt","P") ){ 
				tip := "Alt is down"
				ToolTip3sec(A_LineNumber . " " . A_ScriptName . " `n " . tip)
				send,{AltUp}
			}
			if( GetKeyState("Ctrl","P") ){ 
				tip := "Ctrl is down"
				ToolTip3sec(A_LineNumber . " " . A_ScriptName . " `n " . tip)
				send,{CtrlUp}
			}
			if( GetKeyState("Shift","P") ){ 
				tip := "Shift is down"
				ToolTip3sec(A_LineNumber . " " . A_ScriptName . " `n " . tip)
				send,{ShiftUp}
			}
			Suspend, Off
			return
		} ; endOf: fixBug_Alt_Shift_Ctrl_hanging_down
		

		
		
		1::! 
		6::&
		7::{
			8::[
			9::]
			+0::
			Suspend,On
			send,{text}=  ; solved the problem 27.10.2018 21:36
			Suspend,off
			+1::!
; 012346789%%%
			; 01346789s=e=i=i=SendRaw, % Chr(178) ; 
			+3::§ ; paragraph
			+4::$
			+6::&
			+7::/
			+8::(
			+9::)
			
			RAlt & 0::
			Last_A_This:=A_ThisFunc . A_ThisLabel
			ToolTip1sec(A_LineNumber . " " . A_ScriptName . " " . Last_A_This)
			Send,{}}
			return 
			RAlt & 3::SendRaw, % Chr(179) ; 
; RAlt & 4::
; RAlt & 5::}}}}}}
			; RAlt & 6::
			RAlt & 7::
			Send,{{}
			return
			RAlt & 8::
			Send,[
			return
			RAlt & 9::
			Send,]
			return
			
			DetectHiddenWindows,on
			SetTitleMatchMode, 2
			
			
			#Include *i %A_ScriptDir%\inc_ahk\findTextTool.inc.ahk
			#Include *i %A_ScriptDir%\inc_ahk\functions_global.inc.ahk
;#Include %A_ScriptDir%\inc_ahk\copy2clipBoard.functions.inc.ahk
;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
			;~ subroutinen beispielsweise mï¿½sen ans Dateiende
			#Include *i %A_ScriptDir%\inc_ahk\functions_global_dateiende.inc.ahk
			;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
			#Include *i %A_ScriptDir%\inc_ahk\UPDATEDSCRIPT_global.inc.ahk
			
			
			closeKill_FindTextGUI(){	
				SetTitleMatchMode,1
				wTit := "Capture Image To Text And Find Text Tool ahk_class AutoHotkeyGUI"
				WinClose,% wTit
				wTit2 := "FindText_GUI_CatchImage.ahk"
				DetectHiddenWindows,On
				wCapture=Capture Image To Text ahk_class AutoHotkeyGUI ; mouseWindowTitle=0x261cfc  ; 
				tooltip,% A_LineNumber ,,,19
				winwait,% wCapture,,2
				WinClose,% wCapture
				WinKill,% wCapture
				tooltip,% A_LineNumber ,,,19
				winwait,% wTit2,,2
				WinClose,% wTit2
				WinKill,% wTit2
				WinKill,% wTit2
				tooltip, ,,,19
				
				SetTitleMatchMode,1
				wSuccess=* ahk_class #32770 ; mouseWindowTitle=0x312060  ; 
				WinClose,% wSuccess,Failed
				SetTitleMatchMode,RegEx
				wSuccess=\d+ ahk_class #32770 ; mouseWindowTitle=0x312060  ; 
				WinClose,% wSuccess,Success
				return
			}
			
			