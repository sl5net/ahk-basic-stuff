
;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
;~ please use this ! as first line in every script before all includes! :)
isDevellopperMode:= true ; enthällt auch update script.
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
#Include *i %A_ScriptDir%\inc_ahk\init_global.init.inc.ahk
#notrayicon
SetTimer,lblCheckTrayIconStatus,100 ; ; 30.08.2018 13:52 it sometimes happesn. and if it happens then its really ugly !!!! :( !!
SetTimer,timerLbl2000,2000 ; ; 30.08.2018 13:52 it sometimes happesn. and if it happens then its really ugly !!!! :( !!

#Include *i %A_ScriptDir%\StringReplaceEveryWhere_PRIVATE.inc.ahk

; cmd=C:\Windows\System32\cmd.exe c:\gulp & gulp ; visible
; run,gulp , c:\gulp ; funktioniert, öffnet DOS und funktioniert.

;cmd=C:\Windows\System32\cmd.exe /k "cd c:\gulp & gulp" ; unvisible
;run,gulp , c:\gulp,Hide ; funktiniert unsichtbar 29.10.2017 11:56
;run, gulp , c:\gulp,Min ; funktiniert


; runIfNotExist("E:\fre\private\HtmlDevelop\AutoHotKey\tools\TypingAid-master\Source\TypingAid.ahk","TypingAid")
; runIfNotExist("E:\fre\private\HtmlDevelop\AutoHotKey\tools\TypingAid-master\Typing_Aid_everywhere_multi_clone.ahk","Typing_Aid_everywhere_multi_clone")

global g_doRunLogFiles
if(g_doRunLogFiles)
	run,log\%A_ScriptName%.log.txt

::qdir::C:\Program Files\_\Q-Dir\Q-Dir.exe


#IfWinActive, 

::shopw::Shopware
::stockw::Shopware


:*:sgh::
Last_A_This:=A_ThisFunc . A_ThisLabel
ToolTip1sec(A_LineNumber . " " . A_ScriptName . " " . Last_A_This)
msg := "Sehr geehrter Herr"
sendClipboard(msg)
return
:*:sgf::
Last_A_This:=A_ThisFunc . A_ThisLabel
ToolTip1sec(A_LineNumber . " " . A_ScriptName . " " . Last_A_This)
msg := "Sehr geehrte Frau"
sendClipboard(msg)
return
:*:sgdh::Sehr geehrte Damen und Herren
:*:fgsl::Freundliche Grüße`n



#IfWinActive,ahk_class TscShellContainerClass
:*:\n::
send," & vbCrLf & vbCrLf & "
Last_A_This:=A_ThisFunc . A_ThisLabel 
ToolTip1sec(A_LineNumber . " " . A_ScriptName . " " . Last_A_This)
return

#IfWinActive, 

:*:sendmsg::



; #IfWinActive,WhatsApp
:*:`:)::{Space}:-) ; some sillies 24.03.2018 20:13
  ; Send,% chr(94) . "_" . chr(94)  ; 23.10.2017 19:34 some sillies
; return
:*:`:-)::{Space}`^_`^  ; 23.10.2017 19:34 some sillies
:*:`:D::{Space}:-D ; some sillies 18-03-24_20-09

#IfWinActive,
:*:a_idle::A_TimeIdle
:*:sourct::sourceTree
:*:soucet::sourceTree
:*:Threma::Threema

#IfWinActive,
:*:gulfiles::gulpfiles ; 10.10.2017 11:25

:*:wlan::WLAN ; 11.10.2017 14:30
:*:WÖAN::WLAN ; 11.10.2017 14:30

:*:gemerate::generate

#IfWinActive, 

;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

; trema
:*:trema::threema ; 29.10.2017 10:24


; E:\portable\dfu\stscan.5.4._64-bit\netscan5.4_64bit.exe
:*:netscan::netscan5.4_64bit.exe ; 14.07.2017 16:24


; meine typische seh vertipper 20.06.2017 16:38
:*:schruben::schrubben ; 08.07.2017 14:40
:*:gefailt::gefeilt ; 08.07.2017 14:40
:*:geschrubt::geschrubbt ; 08.07.2017 14:40
:*:gimick::Gimmick ; 26.07.2017 14:04

::ack::ACK ; 31.07.2017 15:06 17-07-31_15-06
::nack::NaCK ; 31.07.2017 15:06 17-07-31_15-06
:*:dip4::DIP4 ; 31.07.2017 15:06 17-07-31_15-06
:*:dip2::DIP2 ; 31.07.2017 15:06 17-07-31_15-06
:*:get(::GET(0;blabefore) ; 31.07.2017 15:06 17-07-31_15-06
; ack NaCK ACK NaCK ACK 
:*:frameware::firmware ; 11.07.2017 15:53
:*:firmeware::firmware ; 11.07.2017 15:53

:*:registriy::Registry
;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
; DSC_0026 CD for CPU FANs 17-07-25_11-47 ASUS DSEB-DG
; das ist düsenjet
:*:ASUS D::ASUS DSEB-DG ; 25.07.2017 11:49
:*:DSEB::ASUS DSEB-DG ; 25.07.2017 11:49
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>



:*:skyp::skype oder google hangout?

:*:thight::tight ; 20.06.2017 13:22

:*:syncting::syncthing ; 15.07.2017 11:59

:*:thight::tight ; 20.06.2017 13:22
:*:vullservice::full service ; 20.06.2017 13:22
:*:synfony::symfony ; 02.07.2017 14:19
:*:fullservice::full service ; 20.06.2017 13:22

:*:statistigk::Statistik ; 19.06.2017 11:05
:*:plazt::platz ; 15.06.2017 14:14 ; plazt plazt 
:*:nplazt::platz ; 15.06.2017 14:14
:*:heite::heute  ; 22.06.2017 15:45
:*:Nabend::’n Abend ; 20.07.2017 19:23
:*:schwehr::schwer   ; 24.06.2017 09:41 ich finde halt mit vielen hhhh und lange gesprochen klingt es vieeeel schweeeeehhhhhrer. warum ohne h ? komisch. 24.06.2017 09:42
:*:wohlte::wollte   ; 25.05.2017 19:50
:*:Fön::Föhn  ; 26.06.2017 09:43 ... ohne h galt bis 1996
:*:bisl::bissl  ; 26.06.2017 
:*:vorraussichtlich::voraussichtlich ; 26.06.2017 
:*:Packet::Paket  ; 25.05.2017 19:50
:*:Wohung::Wohnung ; 02.05.2017 10:53 wenn ich halt schnell tippe.
:*:joombla::Joomla ; 03.05.2017 19:53 und nochmal am 24.06.2017 19:13
:*:joobla::Joomla ; 02.05.2017 12:18
:*:jombl::Joomla ; 02.05.2017 11:44
:*:joombla::Joomla ; 01.05.2017 14:46
:*:jombla::Joomla ; 01.05.2017 14:46
:*:jomla::Joomla ; 01.05.2017 14:46
:*:initialicing::initializing ; 29.04.2017 13:42
:*:qoute::quote ; 28.04.2017 17:20
:*:fux::Fuchs ; 24.04.2017 13:53
:*:forne::vorne  ; 23.05.2017 15:16
:*:Festamstellung::Festanstellung  ; 23.05.2017 19:16
:*:drimester::Trimester ; 23.05.2017 18:04
:*:ausschlieslich::ausschließlich  ; 23.05.2017 17:31
:*:trägger::Trigger ; 24.05.2017 14:06
:*:GmBH::GmbH ; 24.05.2017 14:06
:*:Tepich::Teppich ; 17.04.2017 14:54
:*:singeleinstance::SingleInstance  ; 15.04.2017 19:39
:*:gelicked ::geliked  ; 15.04.2017 12:21
:*:Mietbew::Mitbewohner ; 15.04.2017 09:50
:*:ausgeworefn::ausgeworfen ; 05.05.2017 07:09
:*:immernoch::immer noch ; 15.04.2017 09:50
:*:gelich::gleich ; 15.04.2017 09:50
:*:im erzählt::ihm erzählt ; 13.04.2017 08:38 hatte im erzählt
:*:kontextabhängige::kontextabhängige  ; 15.04.2017 09:24
:*:intelisense::IntelliSense ; 14.07.2017 18:46
:*:intelisene::IntelliSense ; 14.07.2017 18:46
:*:InteliS::IntelliSense ; 15.04.2017 09:14
:*:global Intel::global IntelliSense ; 15.04.2017 09:14
:*:global intel::global IntelliSense ; 15.04.2017 09:14
:*:globalIntel::global IntelliSense ; 15.04.2017 09:14
:*:drehten::treten ; 11.04.2017 16:50 warum so? auf den Schlips treten ... vermutlich war mir es mit T zu hart. zu brutal 
:*:stöhren::stören
:*:stöhrt::stört ; 24.03.2017 
:*:verschütet::verschüttet ; 24.03.2017 15:26
:*:Gunther::Gunter ; 24.03.2017 20:32 ; Gunther ist: ein männlicher Vorname, siehe Gunther (Vorname) .... Gunter bezeichnet: Gunter (Texas), Stadt in Texas. Gunter ist der Familienname folgender Personen: Bill Gunter (* 1934),



;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
; vertipper mit gegenständen tools
:*:frissbee::Frisbee
:*:Edelried::Edelrid
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>


:*:192.::192.168.178.1.106
:*:heigth::height

;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
; sorten to long mont names. Lange Monath Names
:*:Janu::Januar
:*:Febr::Februar
:*:septe::September
:*:Nove::November
:*:Deze::Dezember

#IfWinActive

;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
:*:RaZb::RaZberry 
:*:RaZzb::RaZberry 
:*:rasb::RaZberry 
;~ RaZberry rasb
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

:*:debat::debategraph . com

;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
sendSlow(m,t)
{
	Loop, parse, m, `n, `r  ; Specifying `n prior to `r allows both Windows and Unix files to be parsed.
	{
		Suspend,On
		send,%A_LoopField%`n
		Suspend,Off
		t2 := t * StrLen(A_LoopField) 
		Sleep,%t2%
	}
}
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
:*:ttyl::TTYL (Talk to you later)
TTYL (Talk to you later)
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
;~ vertipper
:*:sebastian::Sebastian
:*:autohtkey::Autohotkey 
:*:Bootstarb::Bootstrap
:*:jQuary::jQuery
:*:auhotkey::Autohotkey 
:*:autohtkey::deutschsparachig::deutschsprachig
:*:autohtkey::sparachig::sprachig
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

;<<<<<<<<<<<<<< <<< <<<< 170813173504 <<<< 13.08.2017 17:35:04 <<<<
:*:`;<::
FormatTime, timestampyyMMddHHmmss, %A_now%,yyMMddHHmmss
; FormatTime, timestampyyMMddHHmmssShort, %A_now%,yyMMddHHmmss
FormatTime, timestampyyMMddHHmmssPrett, %A_now%,dd.MM.yyyy HH:mm:ss
FormatTime, timestampyyMMddHHmmssPrettShort, %A_now%,dd.MM.yyyy HH:mm
SetTitleMatchMode,2
needle=ahk_class TscShellContainerClass    
IfWinActive,% needle
{
	Last_A_This:=A_ThisFunc . A_ThisLabel 
	ToolTip1sec(" (" A_LineNumber " " RegExReplace(A_LineFile,".*\\") " " Last_A_This)
    ; Vorlage: deshalb hier raus MP 20121021  ... 07.11.2017 15:13
	Send,'/¯¯ SL %timestampyyMMddHHmmss% ; (%timestampyyMMddHHmmssPrettShort%)
	return
}
Last_A_This:=A_ThisFunc . A_ThisLabel
ToolTip1sec(" (" A_LineNumber " " RegExReplace(A_LineFile,".*\\") " " Last_A_This)
c := RegExReplace(Clipboard, "m).*?([^\s]+)[\s\S]*", "$1")
    ; Msgbox,>%c%< `n (%A_ScriptName%~%A_LineNumber%) 
    ; c := ";<<<<<<<< " c " <<<< " timestampyyMMddHHmmss " <<<< " timestampyyMMddHHmmssPrett " <<<<"
c := ";`/¯¯¯¯ " c " ¯¯ " timestampyyMMddHHmmss " ¯¯ " timestampyyMMddHHmmssPrett " ¯¯\"
    ; Msgbox,>%c%< `n (%A_ScriptName%~%A_LineNumber%) 
sendClipboard(c)
return
;>>>>>>>>>>>>>> <<< >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

;<<<<<<<< <<< <<<< 170813173649 <<<< 13.08.2017 17:36:49 <<<<
:*:`;>::
Last_A_This:=A_ThisFunc . A_ThisLabel
ToolTip1sec(" (" A_LineNumber " " RegExReplace(A_LineFile,".*\\") " " Last_A_This)
FormatTime, timestampyyMMddHHmmss, %A_now%,yyMMddHHmmss
FormatTime, timestampyyMMddHHmmssPrett, %A_now%,dd.MM.yyyy HH:mm:ss
SetTitleMatchMode,2
needle=ahk_class TscShellContainerClass    
IfWinActive,% needle
{
	Last_A_This:=A_ThisFunc . A_ThisLabel 
	ToolTip1sec(" (" A_LineNumber " " RegExReplace(A_LineFile,".*\\") " " Last_A_This)
    ; Vorlage: deshalb hier raus MP 20121021  ... 07.11.2017 15:13
	Send,'\__ SL %timestampyyMMddHHmmss% ; (%timestampyyMMddHHmmssPrettShort%)
	return
}




    ;Msgbox,%c% `n (%A_ScriptName%~%A_LineNumber%)  

    ;Send,`;>>>>>>>> %c% >>>> %timestampyyMMddHHmmss% >>>> %timestampyyMMddHHmmssPrett% >>>>
c := RegExReplace(Clipboard, "m).*?([^\s]+)[\s\S]*", "$1")
    ;Msgbox,>%c%< `n (%A_ScriptName%~%A_LineNumber%) 
    ; c := ";<<<<<<<< " c " <<<< " timestampyyMMddHHmmss " <<<< " timestampyyMMddHHmmssPrett " <<<<"
c := ";\____ " c " __ " timestampyyMMddHHmmss " __ " timestampyyMMddHHmmssPrett " __`/"
sendClipboard(c)
return
;>>>>>>>>>>>>>> >>>  >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

;yxxycvyxcv
;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
;~ JetBrains PhpStorm ahk_class SunAwtFrame
#IfWinActive ahk_class SunAwtFrame
;~ php commands. if its a only word write it in uppercase
::pdo::PDO
:*:ö::$
;:*:pdo-::PDO->

#IfWinActive,

;~ doppelte ^ verhindern
:*:^^::
test:="{^}{space}"
Send,%test%
return

#IfWinActive ahk_class SciTEWindow 
:*:\n::
Last_A_This:=A_ThisFunc . A_ThisLabel
ToolTip1sec(A_LineNumber . " " . A_ScriptName . " " . Last_A_This)
Send,``n{Space}
return

return  ; probably redundant. its more secure if we do that.

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


#Include *i %A_ScriptDir%\inc_ahk\functions_global.inc.ahk
;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
;~ subroutinen beispielsweise müsen ans Dateiende
#Include *i %A_ScriptDir%\inc_ahk\functions_global_dateiende.inc.ahk
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
#Include *i %A_ScriptDir%\inc_ahk\UPDATEDSCRIPT_global.inc.ahk 

