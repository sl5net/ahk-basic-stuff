﻿run,FindText_GUI_CatchImage.ahk
exitapp


;/*
;===========================================
;  FindText - Capture screen image into text and then find it
;  https://autohotkey.com/boards/viewtopic.php?f=6&t=17834
;
;  Author  :  FeiYue
;  Version :  6.7
;  Date    :  2019-04-13
;
;  Usage:
;  1. Capture the image to text string.
;  2. Test find the text string on full Screen.
;  3. When test is successful, you may copy the code
;     and paste it into your own script.
;     Note: Copy the "FindText()" function and the following
;     functions and paste it into your own script Just once.
;
;  Note:
;     After upgrading to v6.0, the search scope using WinAPI's
;     upper left corner X, Y coordinates, and width, height.
;     This will be better understood and used.
;
;===========================================
;  Introduction of function parameters:
;
;  returnArray := FindText(
;      X --> the search scope's upper left corner X coordinates
;    , Y --> the search scope's upper left corner Y coordinates
;    , W --> the search scope's Width
;    , H --> the search scope's Height
;    , Character "0" fault-tolerant in percentage --> 0.1=10%
;    , Character "_" fault-tolerant in percentage --> 0.1=10%
;    , Text --> The Base64 encoding string for the text to find
;    , ScreenShot --> if the value is 0, the last screenshot will be used
;    , FindAll --> if the value is 0, Just find one result and return.
;    , JoinText --> if the value is 1, Merge all Text for combination lookup.
;    , offsetX --> Set the max text offset for combination text lookup.
;    , offsetY --> Set the max text offset for combination text lookup.
;  )
;
;  The range used by AHK is determined by the upper left
;  corner and the lower right corner: (x1, y1, x2, y2),
;  it can be converted to: FindText(x1, y1, x2-x1+1, y2-y1+1, ...).
;
;  The fault-tolerant parameters allow the loss of specific characters.
;
;  Text parameters can be a lot of text to find, separated by "|".
;
;  ScreenShot if the value is 0, the last screenshot will be used.
;
;  return a second-order array contains the [X,Y,W,H,Comment] of Each Find,
;  if no image is found, the function returns 0.
;
;===========================================
;*/

if (A_IsCompiled or A_LineFile!=A_ScriptFullPath)
  Goto, ft_End

ft_Start:

IfNotEqual, ft_ToolTip_Text,, Goto, ft_Main_Window
#NoEnv
#SingleInstance force
SetBatchLines, -1
Menu, Tray, Add
Menu, Tray, Add, FinText, ft_Main_Window
if (!A_IsCompiled && A_LineFile=A_ScriptFullPath)
{
  Menu, Tray, Default, FinText
  Menu, Tray, Click, 1
  Menu, Tray, Icon, Shell32.dll, 23
}
; The capture range can be changed by adjusting the numbers
;----------------------------
  ft_ww:=35, ft_hh:=12
;----------------------------
ft_nW:=2*ft_ww+1, ft_nH:=2*ft_hh+1
Gosub, ft_MakeCaptureWindow
Gosub, ft_MakeMainWindow
Gosub, ft_Load_ToolTip_Text
return

ft_Load_ToolTip_Text:
ft_ToolTip_Text=
(LTrim
Capture   = Initiate Image Capture Sequence
Test      = Test Results of Code
Copy      = Copy Code to Clipboard
AddFunc   = Additional FindText() in Copy
U         = Cut the Upper Edge by 1
U3        = Cut the Upper Edge by 3
L         = Cut the Left Edge by 1
L3        = Cut the Left Edge by 3
R         = Cut the Right Edge by 1
R3        = Cut the Right Edge by 3
D         = Cut the Lower Edge by 1
D3        = Cut the Lower Edge by 3
SelR      = Red component of the selected color
SelG      = Green component of the selected color
SelB      = Blue component of the selected color
DiffR     = Red Difference which Determines Black or White Pixel Conversion (0-255)
DiffG     = Green Difference which Determines Black or White Pixel Conversion (0-255)
DiffB     = Blue Difference which Determines Black or White Pixel Conversion (0-255)
Auto      = Automatic Cutting Edge
Similar   = Adjust color similarity as Equivalent to The Selected Color
Similar2  = Adjust color similarity as Equivalent to The Selected Color
SelColor  = The selected color
SelGray   = Gray value of the selected color
Threshold = Gray Threshold which Determines Black or White Pixel Conversion (0-255)
GrayDiff  = Gray Difference which Determines Black or White Pixel Conversion (0-255)
UsePos    = Use position instead of color value to suit any color
Modify    = Allows Modify the Black and White Image
Reset     = Reset to Original Captured Image
Comment   = Optional Comment used to Label Code ( Within <> )
SplitAdd  = Using Markup Segmentation to Generate Text Library
AllAdd    = Append Another FindText Search Text into Previously Generated Code
OK        = Create New FindText Code for Testing
Close     = Close the Window Don't Do Anything
Gray2Two      = Converts Image Pixels from Grays to Black or White
GrayDiff2Two  = Converts Image Pixels from Gray Difference to Black or White
Color2Two     = Converts Image Pixels from Color to Black or White
ColorPos2Two  = Converts Image Pixels from Color Position to Black or White
ColorDiff2Two = Converts Image Pixels from Color Difference to Black or White
)
return

ft_Main_Window:
Gui, ft_Main:Show, Center
return

ft_MakeMainWindow:
Gui, ft_Main:Default
Gui, +AlwaysOnTop
Gui, Margin, 15, 15
Gui, Color, DDEEFF
Gui, Font, s6 bold, Verdana
Gui, Add, Edit, xm w660 r25 vft_MyPic -Wrap -VScroll
Gui, Font, s12 norm, Verdana
Gui, Add, Button, w220 gft_MainRun, Capture
Gui, Add, Button, x+0 wp gft_MainRun, Test
Gui, Add, Button, x+0 wp gft_MainRun Section, Copy
Gui, Font, s10
Gui, Add, Text, xm, Click Text String to See ASCII Search Text in the Above
Gui, Add, Checkbox, xs yp w220 r1 -Wrap Checked vft_AddFunc, Additional FindText() in Copy
Gui, Font, s12 cBlue, Verdana
Gui, Add, Edit, xm w660 h350 vft_scr Hwndft_hscr -Wrap HScroll
Gui, Show,, Capture Image To Text And Find Text Tool
;---------------------------------------
OnMessage(0x100, Func("ft_EditEvents1"))  ; WM_KEYDOWN
OnMessage(0x201, Func("ft_EditEvents2"))  ; WM_LBUTTONDOWN
OnMessage(0x200, Func("ft_ShowToolTip"))  ; WM_MOUSEMOVE
return

ft_EditEvents1()
{
  ListLines, Off
  if (A_Gui="ft_Main" && A_GuiControl="ft_scr")
    SetTimer, ft_ShowPic, -100
}

ft_EditEvents2()
{
  ListLines, Off
  if (A_Gui="ft_Capture")
    ft_WM_LBUTTONDOWN()
  else
    ft_EditEvents1()
}

ft_ShowPic:
ListLines, Off
Critical
ControlGet, i, CurrentLine,,, ahk_id %ft_hscr%
ControlGet, s, Line, %i%,, ahk_id %ft_hscr%
GuiControl, ft_Main:, ft_MyPic, % Trim(ASCII(s),"`n")
return

ft_ShowToolTip()
{
  ListLines, Off
  global ft_ToolTip_Text
  static CurrControl, PrevControl, _TT
  CurrControl := A_GuiControl
  if (CurrControl != PrevControl)
  {
    PrevControl := CurrControl
    ToolTip
    if (CurrControl != "")
      SetTimer, ft_DisplayToolTip, -500
  }
  return

  ft_DisplayToolTip:
  ListLines, Off
  MouseGetPos,,, _TT
  WinGetClass, _TT, ahk_id %_TT%
  if (_TT = "AutoHotkeyGUI")
  {
    ToolTip, % RegExMatch(ft_ToolTip_Text, "m`n)^"
      . StrReplace(CurrControl,"ft_") . "\K\s*=.*", _TT)
      ? StrReplace(Trim(_TT,"`t ="),"\n","`n") : ""
    SetTimer, ft_RemoveToolTip, -5000
  }
  return

  ft_RemoveToolTip:
  ToolTip
  return
}

ft_MainRun:
k:="ft_" . A_GuiControl
WinMinimize
Gui, Hide
DetectHiddenWindows, Off
Gui, +LastFound
WinWaitClose, % "ahk_id " WinExist()
if IsLabel(k)
  Gosub, %k%
Gui, ft_Main: Show
GuiControl, ft_Main: Focus, ft_scr
return

ft_Copy:
GuiControlGet, s,, ft_scr
GuiControlGet, r,, ft_AddFunc
if (r != 1)
  s:=RegExReplace(s,"\n\K[\s;=]+ Copy The[\s\S]*")
Clipboard:=StrReplace(s,"`n","`r`n")
s=
return

ft_Capture:
Gui, ft_Mini:Default
Gui, +LastFound +AlwaysOnTop -Caption +ToolWindow +E0x08000000
Gui, Color, Red
d:=2, w:=ft_nW+2*d, h:=ft_nH+2*d, i:=w-d, j:=h-d
Gui, Show, Hide w%w% h%h%
s=0-0 %w%-0 %w%-%h% 0-%h% 0-0
s=%s%  %d%-%d% %i%-%d% %i%-%j% %d%-%j% %d%-%d%
WinSet, Region, %s%
;------------------------------
Hotkey, $*RButton, ft_RButton_Off, On
ListLines, Off
CoordMode, Mouse
ft_oldx:=ft_oldy:=""
Loop {
  Sleep, 50
  MouseGetPos, x, y
  if (ft_oldx=x && ft_oldy=y)
    Continue
  ft_oldx:=x, ft_oldy:=y
  ;---------------
  Gui, Show, % "NA x" (x-w//2) " y" (y-h//2)
  ToolTip, % "The Capture Position : " x "," y
    . "`nFirst click RButton to start capturing"
    . "`nSecond click RButton to end capture"
} Until GetKeyState("RButton", "P")
KeyWait, RButton
ft_px:=x, ft_py:=y, ft_oldx:=ft_oldy:=""
Loop {
  Sleep, 50
  MouseGetPos, x, y
  if (ft_oldx=x && ft_oldy=y)
    Continue
  ft_oldx:=x, ft_oldy:=y
  ;---------------
  ToolTip, % "The Capture Position : " ft_px "," ft_py
    . "`nFirst click RButton to start capturing"
    . "`nSecond click RButton to end capture"
} Until GetKeyState("RButton", "P")
KeyWait, RButton
ToolTip
ListLines, On
Gui, Destroy
WinWaitClose
ft_cors:=ft_getc(ft_px,ft_py,ft_ww,ft_hh)
Hotkey, $*RButton, ft_RButton_Off, Off
Goto, ft_ShowCaptureWindow
ft_RButton_Off:
return

ft_ShowCaptureWindow:
ft_cors.Event:="", ft_cors.Result:=""
;--------------------------------
Gui, ft_Capture:Default
k:=ft_nW*ft_nH+1
Loop, % ft_nW
  GuiControl,, % ft_C_[k++], 0
Loop, 6
  GuiControl,, Edit%A_Index%
GuiControl,, ft_Modify, % ft_Modify:=0
GuiControl,, ft_GrayDiff, 50
GuiControl, Focus, ft_Threshold
Gosub, ft_Reset
Gui, Show, Center
DetectHiddenWindows, Off
Gui, +LastFound
WinWaitClose, % "ahk_id " WinExist()
;--------------------------------
if InStr(ft_cors.Event,"OK")
{
  if !A_IsCompiled
  {
    FileRead, s, %A_LineFile%
    s:=SubStr(s, s~="i)\n[;=]+ Copy The")
  } else s:=""
  GuiControl, ft_Main:, ft_scr, % ft_cors.Result "`n" s
  ft_cors.Result:=s:=""
  return
}
if InStr(ft_cors.Event,"Add")
  ft_add(ft_cors.Result, 0), ft_cors.Result:=""
return

ft_WM_LBUTTONDOWN()
{
  global
  ListLines, Off
  Critical
  MouseGetPos,,,, j
  IfNotInString, j, progress
    return
  Gui, ft_Capture:Default
  MouseGetPos,,,, j, 2
  For k,v in ft_C_
    if (v=j)
    {
      if (k>ft_nW*ft_nH)
      {
        GuiControlGet, i,, %v%
        GuiControl,, %v%, % i ? 0:100
      }
      else if (ft_Modify && ft_bg!="")
      {
        c:=ft_ascii[k], ft_ascii[k]:=c="0" ? "_" : c="_" ? "0" : c
        c:=c="0" ? "White" : c="_" ? "Black" : ft_WindowColor
        Gosub, ft_SetColor
      }
      else
      {
        c:=ft_cors[k], ft_cors.SelPos:=k
        r:=(c>>16)&0xFF, g:=(c>>8)&0xFF, b:=c&0xFF
        GuiControl,, ft_SelGray, % (r*38+g*75+b*15)>>7
        GuiControl,, ft_SelColor, %c%
        GuiControl,, ft_SelR, %r%
        GuiControl,, ft_SelG, %g%
        GuiControl,, ft_SelB, %b%
      }
      return
    }
}

ft_getc(px, py, ww, hh)
{
  xywh2xywh(px-ww,py-hh,2*ww+1,2*hh+1,x,y,w,h)
  if (w<1 or h<1)
    return, 0
  bch:=A_BatchLines
  SetBatchLines, -1
  ;--------------------------------------
  GetBitsFromScreen(x,y,w,h,Scan0,Stride,1)
  ;--------------------------------------
  cors:=[], k:=0, nW:=2*ww+1, nH:=2*hh+1
  lls:=A_ListLines=0 ? "Off" : "On"
  ListLines, Off
  fmt:=A_FormatInteger
  SetFormat, IntegerFast, H
  Loop, %nH% {
    j:=py-hh+A_Index-1
    Loop, %nW% {
      i:=px-ww+A_Index-1, k++
      if (i>=x && i<=x+w-1 && j>=y && j<=y+h-1)
        c:=NumGet(Scan0+0,(j-y)*Stride+(i-x)*4,"uint")
          , cors[k]:="0x" . SubStr(0x1000000|c,-5)
      else
        cors[k]:="0xFFFFFF"
    }
  }
  SetFormat, IntegerFast, %fmt%
  ListLines, %lls%
  cors.LeftCut:=Abs(px-ww-x)
  cors.RightCut:=Abs(px+ww-(x+w-1))
  cors.UpCut:=Abs(py-hh-y)
  cors.DownCut:=Abs(py+hh-(y+h-1))
  SetBatchLines, %bch%
  return, cors
}

ft_Test:
GuiControlGet, s, ft_Main:, ft_scr
s:="`n#NoEnv`nMenu, Tray, Click, 1`n"
  . "Gui, _ok_:Show, Hide, _ok_`n"
  . s "`nExitApp`n#SingleInstance off`n"
if (!A_IsCompiled) && InStr(s,"MCode(")
{
  ft_Exec(s)
  DetectHiddenWindows, On
  WinWait, _ok_ ahk_class AutoHotkeyGUI,, 3
  if !ErrorLevel
    WinWaitClose, _ok_ ahk_class AutoHotkeyGUI
}
else
{
  CoordMode, Mouse
  t:=A_TickCount, RegExMatch(s,"\[\d+,\s*\d+\]",r)
  RegExMatch(s,"=""\K[^$\n]+\$\d+\.[\w+/]+",v)
  k:=FindText(0, 0, A_ScreenWidth, A_ScreenHeight, 0, 0, v)
  X:=k.1.1, Y:=k.1.2, W:=k.1.3, H:=k.1.4, X+=W//2, Y+=H//2
  MsgBox, 4096,, % "Time:`t" (A_TickCount-t) " ms`n`n"
    . "Pos:`t" r "  " X ", " Y "`n`n"
    . "Result:`t" (k ? "Success !":"Failed !"), 3
  (k) && MouseTip(X, Y)
  k:=""
}
return

ft_Exec(s)
{
  Ahk:=A_IsCompiled ? A_ScriptDir "\AutoHotkey.exe":A_AhkPath
  s:=RegExReplace(s, "\R", "`r`n")
  Try {
    shell:=ComObjCreate("WScript.Shell")
    oExec:=shell.Exec(Ahk " /f /ErrorStdOut *")
    oExec.StdIn.Write(s)
    oExec.StdIn.Close()
  }
  catch {
    f:=A_Temp "\~test1.tmp", s:="`r`n FileDelete, " f "`r`n" s
    FileDelete, %f%
    FileAppend, %s%, %f%
    Run, %Ahk% /f "%f%",, UseErrorLevel
  }
}

ft_MakeCaptureWindow:
ft_WindowColor:="0xCCDDEE"
Gui, ft_Capture:Default
Gui, +LastFound +AlwaysOnTop +ToolWindow
Gui, Margin, 15, 15
Gui, Color, %ft_WindowColor%
Gui, Font, s14, Verdana
Gui, -Theme
w:=800//ft_nW, h:=(A_ScreenHeight-300)//ft_nH, w:=h<w ? h-1:w-1
Loop, % ft_nW*(ft_nH+1) {
  i:=A_Index, j:=i=1 ? "" : Mod(i,ft_nW)=1 ? "xm y+1" : "x+1"
  j.=i>ft_nW*ft_nH ? " cRed BackgroundFFFFAA":""
  Gui, Add, Progress, w%w% h%w% %j%
}
WinGet, s, ControlListHwnd
ft_C_:=StrSplit(s,"`n"), s:=""
Loop, % ft_nW*(ft_nH+1)
  Control, ExStyle, -0x20000,, % "ahk_id " ft_C_[A_Index]
Gui, +Theme
Gui, Add, Button, xm+95  w45 gft_Run, U
Gui, Add, Button, x+0    wp gft_Run, U3
;--------------
Gui, Add, Text,   x+45 yp+3 Section, Gray
Gui, Add, Edit,   x+3 yp-3 w60 vft_SelGray ReadOnly
Gui, Add, Text,   x+15 ys, Color
Gui, Add, Edit,   x+2 yp-3 w120 vft_SelColor ReadOnly
Gui, Add, Text,   x+15 ys, R
Gui, Add, Edit,   x+3 yp-3 w60 vft_SelR ReadOnly
Gui, Add, Text,   x+5 ys, G
Gui, Add, Edit,   x+3 yp-3 w60 vft_SelG ReadOnly
Gui, Add, Text,   x+5 ys, B
Gui, Add, Edit,   x+3 yp-3 w60 vft_SelB ReadOnly
;--------------
Gui, Add, Button, xm     w45 gft_Run, L
Gui, Add, Button, x+0    wp gft_Run, L3
Gui, Add, Button, x+15   w70 gft_Run, Auto
Gui, Add, Button, x+15   w45 gft_Run, R
Gui, Add, Button, x+0    wp gft_Run Section, R3
Gui, Add, Button, xm+95  w45 gft_Run, D
Gui, Add, Button, x+0    wp gft_Run, D3
;------------------
Gui, Add, Tab3,   ys -Wrap, Gray|GrayDiff|Color|ColorPos|ColorDiff
Gui, Tab, 1
Gui, Add, Text,   x+15 y+15, Gray Threshold
Gui, Add, Edit,   x+15 w100 vft_Threshold
Gui, Add, Button, x+15 yp-3 gft_Run Default, Gray2Two
Gui, Tab, 2
Gui, Add, Text,   x+15 y+15, Gray Difference
Gui, Add, Edit,   x+15 w100 vft_GrayDiff, 50
Gui, Add, Button, x+15 yp-3 gft_Run, GrayDiff2Two
Gui, Tab, 3
Gui, Add, Text,   x+15 y+15, Similarity 0
Gui, Add, Slider
  , x+0 w100 vft_Similar gft_Run Page1 NoTicks ToolTip Center, 100
Gui, Add, Text,   x+0, 100
Gui, Add, Button, x+15 yp-3 gft_Run, Color2Two
Gui, Tab, 4
Gui, Add, Text,   x+15 y+15, Similarity 0
Gui, Add, Slider
  , x+0 w100 vft_Similar2 gft_Run Page1 NoTicks ToolTip Center, 100
Gui, Add, Text,   x+0, 100
Gui, Add, Button, x+15 yp-3 gft_Run, ColorPos2Two
Gui, Tab, 5
Gui, Add, Text,   x+15 y+15, R
Gui, Add, Edit,   x+2 w70 vft_DiffR Limit3
Gui, Add, UpDown, vft_dR Range0-255
Gui, Add, Text,   x+10, G
Gui, Add, Edit,   x+2 w70 vft_DiffG Limit3
Gui, Add, UpDown, vft_dG Range0-255
Gui, Add, Text,   x+10, B
Gui, Add, Edit,   x+2 w70 vft_DiffB Limit3
Gui, Add, UpDown, vft_dB Range0-255
Gui, Add, Button, x+15 yp-3 gft_Run, ColorDiff2Two
Gui, Tab
;------------------
Gui, Add, Checkbox, xm   gft_Run vft_Modify, Modify
Gui, Add, Button, x+5    yp-3 gft_Run, Reset
Gui, Add, Text,   x+15   yp+3, Comment
Gui, Add, Edit,   x+5    w132 vft_Comment
Gui, Add, Button, x+10   yp-3 gft_Run, SplitAdd
Gui, Add, Button, x+10   gft_Run, AllAdd
Gui, Add, Button, x+10   w80 gft_Run, OK
Gui, Add, Button, x+10   gft_Run, Close
Gui, Show, Hide, Capture Image To Text
return

ft_Run:
Critical
k:=A_GuiControl
k:= k="L" ? "LeftCut"  : k="L3" ? "LeftCut3"
  : k="R" ? "RightCut" : k="R3" ? "RightCut3"
  : k="U" ? "UpCut"    : k="U3" ? "UpCut3"
  : k="D" ? "DownCut"  : k="D3" ? "DownCut3" : k
Gui, +OwnDialogs
k:=InStr(k,"ft_") ? k : "ft_" k
if IsLabel(k)
  Gosub, %k%
return

ft_Close:
Gui, Cancel
return

ft_Modify:
GuiControlGet, ft_Modify
return

ft_Similar:
ft_Similar2:
ListLines, Off
GuiControl,, % InStr(A_ThisLabel,"2")
  ? "ft_Similar":"ft_Similar2", % %A_ThisLabel%
return

ft_SetColor:
c:=c="White" ? 0xFFFFFF : c="Black" ? 0x000000
  : ((c&0xFF)<<16)|(c&0xFF00)|((c&0xFF0000)>>16)
SendMessage, 0x2001, 0, c,, % "ahk_id " . ft_C_[k]
return

ft_Reset:
if !IsObject(ft_ascii)
  ft_ascii:=[], ft_gs:=[]
ft_left:=ft_right:=ft_up:=ft_down:=k:=0, ft_bg:=""
Loop, % ft_nW*ft_nH {
  ft_ascii[++k]:=1, c:=ft_cors[k]
  ft_gs[k]:=(((c>>16)&0xFF)*38+((c>>8)&0xFF)*75+(c&0xFF)*15)>>7
  Gosub, ft_SetColor
}
Loop, % ft_cors.LeftCut
  Gosub, ft_LeftCut
Loop, % ft_cors.RightCut
  Gosub, ft_RightCut
Loop, % ft_cors.UpCut
  Gosub, ft_UpCut
Loop, % ft_cors.DownCut
  Gosub, ft_DownCut
return

ft_Gray2Two:
GuiControl, Focus, ft_Threshold
GuiControlGet, ft_Threshold
if (ft_Threshold="")
{
  ft_pp:=[]
  Loop, 256
    ft_pp[A_Index-1]:=0
  Loop, % ft_nW*ft_nH
    if (ft_ascii[A_Index]!="")
      ft_pp[ft_gs[A_Index]]++
  ft_Threshold:=ft_GetThreshold(ft_pp)
  GuiControl,, ft_Threshold, %ft_Threshold%
}
ft_Threshold:=Round(ft_Threshold)
ft_color:="*" ft_Threshold, k:=i:=0
Loop, % ft_nW*ft_nH {
  if (ft_ascii[++k]="")
    Continue
  if (ft_gs[k]<=ft_Threshold)
    ft_ascii[k]:="0", c:="Black", i++
  else
    ft_ascii[k]:="_", c:="White", i--
  Gosub, ft_SetColor
}
ft_bg:=i>0 ? "0":"_"
return

ft_GetThreshold(pp)
{
  IP:=IS:=0
  Loop, 256
    k:=A_Index-1, IP+=k*pp[k], IS+=pp[k]
  NewThreshold:=Floor(IP/IS)
  Loop, 20 {
    Threshold:=NewThreshold
    IP1:=IS1:=0
    Loop, % Threshold+1
      k:=A_Index-1, IP1+=k*pp[k], IS1+=pp[k]
    IP2:=IP-IP1, IS2:=IS-IS1
    if (IS1!=0 && IS2!=0)
      NewThreshold:=Floor((IP1/IS1+IP2/IS2)/2)
    if (NewThreshold=Threshold)
      Break
  }
  return, NewThreshold
}

ft_GrayDiff2Two:
GuiControlGet, ft_GrayDiff
if (ft_GrayDiff="")
{
  MsgBox, 4096, Tip
    , `n  Please Set Gray Difference First !  `n, 1
  Return
}
if (ft_left=ft_cors.LeftCut)
  Gosub, ft_LeftCut
if (ft_right=ft_cors.RightCut)
  Gosub, ft_RightCut
if (ft_up=ft_cors.UpCut)
  Gosub, ft_UpCut
if (ft_down=ft_cors.DownCut)
  Gosub, ft_DownCut
ft_GrayDiff:=Round(ft_GrayDiff)
ft_color:="**" ft_GrayDiff, k:=i:=0
Loop, % ft_nW*ft_nH {
  if (ft_ascii[++k]="")
    Continue
  c:=ft_gs[k]+ft_GrayDiff
  if (ft_gs[k-1]>c || ft_gs[k+1]>c
  || ft_gs[k-ft_nW]>c || ft_gs[k+ft_nW]>c)
    ft_ascii[k]:="0", c:="Black", i++
  else
    ft_ascii[k]:="_", c:="White", i--
  Gosub, ft_SetColor
}
ft_bg:=i>0 ? "0":"_"
return

ft_Color2Two:
ft_ColorPos2Two:
GuiControlGet, c,, ft_SelColor
if (c="")
{
  MsgBox, 4096, Tip
    , `n  Please Select a Color First !  `n, 1
  return
}
ft_UsePos:=InStr(A_ThisLabel,"ColorPos2Two") ? 1:0
GuiControlGet, n,, ft_Similar
n:=Round(n/100,2), ft_color:=c "@" n
n:=Floor(9*255*255*(1-n)*(1-n)), k:=i:=0
ft_rr:=(c>>16)&0xFF, ft_gg:=(c>>8)&0xFF, ft_bb:=c&0xFF
Loop, % ft_nW*ft_nH {
  if (ft_ascii[++k]="")
    Continue
  c:=ft_cors[k], r:=((c>>16)&0xFF)-ft_rr
    , g:=((c>>8)&0xFF)-ft_gg, b:=(c&0xFF)-ft_bb
  if (3*r*r+4*g*g+2*b*b<=n)
    ft_ascii[k]:="0", c:="Black", i++
  else
    ft_ascii[k]:="_", c:="White", i--
  Gosub, ft_SetColor
}
ft_bg:=i>0 ? "0":"_"
return

ft_ColorDiff2Two:
GuiControlGet, c,, ft_SelColor
if (c="")
{
  MsgBox, 4096, Tip
    , `n  Please Select a Color First !  `n, 1
  return
}
GuiControlGet, ft_dR
GuiControlGet, ft_dG
GuiControlGet, ft_dB
ft_rr:=(c>>16)&0xFF, ft_gg:=(c>>8)&0xFF, ft_bb:=c&0xFF
n:=Format("{:06X}",(ft_dR<<16)|(ft_dG<<8)|ft_dB)
ft_color:=StrReplace(c "-" n,"0x"), k:=i:=0
Loop, % ft_nW*ft_nH {
  if (ft_ascii[++k]="")
    Continue
  c:=ft_cors[k], r:=(c>>16)&0xFF, g:=(c>>8)&0xFF, b:=c&0xFF
  if ( Abs(r-ft_rr)<=ft_dR
    && Abs(g-ft_gg)<=ft_dG
    && Abs(b-ft_bb)<=ft_dB )
      ft_ascii[k]:="0", c:="Black", i++
  else
    ft_ascii[k]:="_", c:="White", i--
  Gosub, ft_SetColor
}
ft_bg:=i>0 ? "0":"_"
return

ft_gui_del:
ft_ascii[k]:="", c:=ft_WindowColor
Gosub, ft_SetColor
return

ft_LeftCut3:
Loop, 3
  Gosub, ft_LeftCut
return

ft_LeftCut:
if (ft_left+ft_right>=ft_nW)
  return
ft_left++, k:=ft_left
Loop, %ft_nH% {
  Gosub, ft_gui_del
  k+=ft_nW
}
return

ft_RightCut3:
Loop, 3
  Gosub, ft_RightCut
return

ft_RightCut:
if (ft_left+ft_right>=ft_nW)
  return
ft_right++, k:=ft_nW+1-ft_right
Loop, %ft_nH% {
  Gosub, ft_gui_del
  k+=ft_nW
}
return

ft_UpCut3:
Loop, 3
  Gosub, ft_UpCut
return

ft_UpCut:
if (ft_up+ft_down>=ft_nH)
  return
ft_up++, k:=(ft_up-1)*ft_nW
Loop, %ft_nW% {
  k++
  Gosub, ft_gui_del
}
return

ft_DownCut3:
Loop, 3
  Gosub, ft_DownCut
return

ft_DownCut:
if (ft_up+ft_down>=ft_nH)
  return
ft_down++, k:=(ft_nH-ft_down)*ft_nW
Loop, %ft_nW% {
  k++
  Gosub, ft_gui_del
}
return

ft_getwz:
ft_wz:=""
if (ft_bg="")
  return
k:=0
Loop, %ft_nH% {
  v:=""
  Loop, %ft_nW%
    v.=ft_ascii[++k]
  ft_wz.=v="" ? "" : v "`n"
}
return

ft_Auto:
Gosub, ft_getwz
if (ft_wz="")
{
  MsgBox, 4096, Tip
    , `nPlease Click Color2Two or Gray2Two First !, 1
  return
}
While InStr(ft_wz, ft_bg) {
  if (ft_wz~="^" ft_bg "+\n")
  {
    ft_wz:=RegExReplace(ft_wz,"^" ft_bg "+\n")
    Gosub, ft_UpCut
  }
  else if !(ft_wz~="m`n)[^\n" ft_bg "]$")
  {
    ft_wz:=RegExReplace(ft_wz,"m`n)" ft_bg "$")
    Gosub, ft_RightCut
  }
  else if (ft_wz~="\n" ft_bg "+\n$")
  {
    ft_wz:=RegExReplace(ft_wz,"\n\K" ft_bg "+\n$")
    Gosub, ft_DownCut
  }
  else if !(ft_wz~="m`n)^[^\n" ft_bg "]")
  {
    ft_wz:=RegExReplace(ft_wz,"m`n)^" ft_bg)
    Gosub, ft_LeftCut
  }
  else Break
}
ft_wz:=""
return

ft_OK:
ft_AllAdd:
ft_SplitAdd:
Gosub, ft_getwz
if ft_wz=
{
  MsgBox, 4096, Tip
    , `nPlease Click Color2Two or Gray2Two First !, 1
  return
}
if InStr(ft_color,"@") and (ft_UsePos)
{
  StringSplit, r, ft_color, @
  k:=i:=j:=0
  Loop, % ft_nW*ft_nH {
    if (ft_ascii[++k]="")
      Continue
    i++
    if (k=ft_cors.SelPos)
    {
      j:=i
      Break
    }
  }
  if (j=0)
  {
    MsgBox, 4096, Tip
      , Please select the core color again !, 2
    return
  }
  ft_color:="#" . j . "@" . r2
}
GuiControlGet, ft_Comment
ft_cors.Event:=A_ThisLabel
if InStr(A_ThisLabel, "SplitAdd")
{
  SetFormat, IntegerFast, d
  ft_bg:=StrLen(StrReplace(ft_wz,"_"))
    > StrLen(StrReplace(ft_wz,"0")) ? "0":"_"
  s:="", k:=ft_nW*ft_nH+1+ft_left
    , i:=0, w:=ft_nW-ft_left-ft_right
  Loop, % w {
    i++
    GuiControlGet, j,, % ft_C_[k++]
    if (j=0 && A_Index<w)
      Continue
    v:=RegExReplace(ft_wz,"m`n)^(.{" i "}).*","$1")
    ft_wz:=RegExReplace(ft_wz,"m`n)^.{" i "}"), i:=0
    While InStr(v, ft_bg) {
      if (v~="^" ft_bg "+\n")
        v:=RegExReplace(v,"^" ft_bg "+\n")
      else if !(v~="m`n)[^\n" ft_bg "]$")
        v:=RegExReplace(v,"m`n)" ft_bg "$")
      else if (v~="\n" ft_bg "+\n$")
        v:=RegExReplace(v,"\n\K" ft_bg "+\n$")
      else if !(v~="m`n)^[^\n" ft_bg "]")
        v:=RegExReplace(v,"m`n)^" ft_bg)
      else Break
    }
    if v!=
      s.=ft_towz(ft_color, v, SubStr(ft_Comment,1,1))
    ft_Comment:=SubStr(ft_Comment, 2)
  }
  ft_cors.Result:=s
  Gui, Hide
  return
}
s:=ft_towz(ft_color, ft_wz, ft_Comment)
if InStr(A_ThisLabel, "AllAdd")
{
  ft_cors.Result:=s
  Gui, Hide
  return
}
x:=ft_px-ft_ww+ft_left+(ft_nW-ft_left-ft_right)//2
y:=ft_py-ft_hh+ft_up+(ft_nH-ft_up-ft_down)//2
s:=StrReplace(s, "Text.=", "Text:=")
s=
(
t1:=A_TickCount
%s%
if (ok:=FindText(0, 0, A_ScreenWidth, A_ScreenHeight, 0, 0, Text))
{
  CoordMode, Mouse
  X:=ok.1.1, Y:=ok.1.2, W:=ok.1.3, H:=ok.1.4, Comment:=ok.1.5, X+=W//2, Y+=H//2
  ; Click, `%X`%, `%Y`%
}

MsgBox, 4096, `% ok.MaxIndex(), `% "Time:``t" (A_TickCount-t1) " ms``n``n"
  . "Pos:``t[%x%, %y%]  " X ", " Y "``n``n"
  . "Result:``t" (ok ? "Success ! " Comment : "Failed !")

for i,v in ok
  if i<=2
    MouseTip(v.1+v.3//2, v.2+v.4//2)

)
ft_cors.Result:=s
Gui, Hide
return

ft_towz(color,wz,comment="")
{
  SetFormat, IntegerFast, d
  wz:=StrReplace(StrReplace(wz,"0","1"),"_","0")
  wz:=(InStr(wz,"`n")-1) "." bit2base64(wz)
  return, "`nText.=""|<" comment ">" color "$" wz """`n"
}

ft_add(s, rn=1)
{
  global ft_hscr
  if (rn=1)
    s:="`n" s "`n"
  s:=RegExReplace(s,"\R","`r`n")
  ControlGet, i, CurrentCol,,, ahk_id %ft_hscr%
  if i>1
    ControlSend,, {Home}{Down}, ahk_id %ft_hscr%
  Control, EditPaste, %s%,, ahk_id %ft_hscr%
}

ft_End:
Trim("")


;===== Copy The Following Functions To Your Own Code Just once =====


;--------------------------------
; FindText - Find images restored by Base64 text on screen
;--------------------------------
; X, Y       is the search scope's upper left corner coordinates.
; W, H       is the search scope's Width and Height.
; err1, err0 is the character "0" or "_" fault-tolerant in percentage.
; Text       can be a lot of text to find, separated by "|".
; ScreenShot if the value is 0, the last screenshot will be used.
; FindAll    if the value is 0, Just find one result and return.
; JoinText   if the value is 1, Merge all Text for combination lookup.
; offsetX, offsetY Set the Max text offset for combination text lookup.
; ruturn a second-order array contains the [X,Y,W,H,Comment] of Each Find.
;--------------------------------

FindText( x, y, w, h, err1, err0, text, ScreenShot=1
  , FindAll=1, JoinText=0, offsetX=20, offsetY=10 )
{
  xywh2xywh(x,y,w,h,x,y,w,h)
  if (w<1 or h<1)
    return, 0
  bch:=A_BatchLines
  SetBatchLines, -1
  ;-------------------------------
  GetBitsFromScreen(x,y,w,h,Scan0,Stride,ScreenShot,zx,zy)
  ;-------------------------------
  sx:=x-zx, sy:=y-zy, sw:=w, sh:=h
  , arr:=[], info:=[], allv:=""
  Loop, Parse, text, |
  {
    v:=A_LoopField
    IfNotInString, v, $, Continue
    comment:="", e1:=err1, e0:=err0
    ; You Can Add Comment Text within The <>
    if RegExMatch(v,"<([^>]*)>",r)
      v:=StrReplace(v,r), comment:=Trim(r1)
    ; You can Add two fault-tolerant in the [], separated by commas
    if RegExMatch(v,"\[([^\]]*)]",r)
    {
      v:=StrReplace(v,r), r1.=","
      StringSplit, r, r1, `,
      e1:=r1, e0:=r2
    }
    StringSplit, r, v, $
    color:=r1, v:=r2
    StringSplit, r, v, .
    w1:=r1, v:=base64tobit(r2), h1:=StrLen(v)//w1
    if (r0<2 or h1<1 or w1>sw or h1>sh or StrLen(v)!=w1*h1)
      Continue
    mode:=InStr(color,"-") ? 4 : InStr(color,"#") ? 3
      : InStr(color,"**") ? 2 : InStr(color,"*") ? 1 : 0
    if (mode=4)
    {
      color:=StrReplace(color,"0x")
      StringSplit, r, color, -
      color:="0x" . r1, n:="0x" . r2
    }
    else
    {
      color:=RegExReplace(color,"[*#]") . "@"
      StringSplit, r, color, @
      color:=mode=3 ? ((r1-1)//w1)*Stride+Mod(r1-1,w1)*4 : r1
      n:=Round(r2,2)+(!r2), n:=Floor(9*255*255*(1-n)*(1-n))
    }
    StrReplace(v,"1","",len1), len0:=StrLen(v)-len1
    e1:=Round(len1*e1), e0:=Round(len0*e0)
    info.Push( [StrLen(allv),w1,h1,len1,len0,e1,e0
      ,mode,color,n,comment] ), allv.=v
  }
  if (allv="")
  {
    SetBatchLines, %bch%
    return, 0
  }
  num:=info.MaxIndex(), VarSetCapacity(input, num*7*4)
  , VarSetCapacity(gs, sw*sh)
  , VarSetCapacity(ss, sw*sh), k:=StrLen(allv)*4
  , VarSetCapacity(s1, k), VarSetCapacity(s0, k)
  , allpos_max:=FindAll ? 1024 : 1
  , VarSetCapacity(allpos, allpos_max*4)
  ;-------------------------------------
  Loop, 2 {
  if (JoinText)
  {
    mode:=info.1.8, color:=info.1.9, n:=info.1.10
    , w1:=-1, h1:=info.1.3, comment:="", k:=0
    Loop, % num {
      i:=A_Index, w1+=info[i].2+1, comment.=info[i].11
      Loop, 7
        NumPut(info[i][A_Index], input, 4*(k++), "int")
    }
    ok:=PicFind( mode,color,n,offsetX,offsetY
      ,Scan0,Stride,sx,sy,sw,sh,gs,ss,allv,s1,s0
      ,input,num*7,allpos,allpos_max )
    Loop, % ok
      pos:=NumGet(allpos, 4*(A_Index-1), "uint")
      , rx:=(pos&0xFFFF)+zx, ry:=(pos>>16)+zy
      , arr.Push( [rx,ry,w1,h1,comment] )
  }
  else
  {
    For i,j in info
    {
      mode:=j.8, color:=j.9, n:=j.10, comment:=j.11
      , w1:=j.2, h1:=j.3, v:=SubStr(allv, j.1+1, w1*h1)
      Loop, 7
        NumPut(j[A_Index], input, 4*(A_Index-1), "int")
      NumPut(0, input, "int")
      ok:=PicFind( mode,color,n,offsetX,offsetY
        ,Scan0,Stride,sx,sy,sw,sh,gs,ss,v,s1,s0
        ,input,7,allpos,allpos_max )
      Loop, % ok
        pos:=NumGet(allpos, 4*(A_Index-1), "uint")
        , rx:=(pos&0xFFFF)+zx, ry:=(pos>>16)+zy
        , arr.Push( [rx,ry,w1,h1,comment] )
    }
  }
  if (err1=0 && err0=0 && !arr.MaxIndex())
  {
    err1:=err0:=0.1
    For i,j in info
      if (j.6=0 && j.7=0)
        j.6:=Round(j.4*err1), j.7:=Round(j.5*err0)
  }
  else Break
  }
  SetBatchLines, %bch%
  return, arr.MaxIndex() ? arr:0
}

PicFind(mode, color, n, offsetX, offsetY
  , Scan0, Stride, sx, sy, sw, sh
  , ByRef gs, ByRef ss, ByRef text, ByRef s1, ByRef s0
  , ByRef input, input_num, ByRef allpos, allpos_max)
{
  static MyFunc, Int:="Int", Ptr:=A_PtrSize ? "UPtr" : "UInt"
  if !MyFunc
  {
    x32:="5557565383EC788B8424CC0000008BBC24CC000000C7442"
    . "424000000008B40048B7F148944243C8B8424CC000000897C2"
    . "42C8BBC24CC0000008B40088B7F18894424348B8424CC00000"
    . "0897C24308B400C89C6894424288B8424CC0000008B401039C"
    . "6894424200F4DC68944241C8B8424D000000085C00F8E09010"
    . "0008BBC24CC0000008B4424248B7487048B0C878B448708897"
    . "4241085C0894424180F8ECD00000089CD894C2414C744240C0"
    . "0000000C744240800000000C744240400000000890C248B5C2"
    . "4108B7424088B4C24148B54240C89DF89F029F101F78BB424C"
    . "000000001CE85DB7E5E8B0C2489EB893C2489D7EB198BAC24C"
    . "800000083C70483C00189548D0083C101390424742C83BC248"
    . "C0000000389FA0F45D0803C063175D48BAC24C400000083C70"
    . "483C00189549D0083C30139042475D48B7424100174241489D"
    . "D890C2483442404018BB424B00000008B442404017424088BB"
    . "C24A4000000017C240C394424180F8554FFFFFF83442424078"
    . "B442424398424D00000000F8FF7FEFFFF83BC248C000000030"
    . "F849C0600008B8424A40000008BB424A80000000FAF8424AC0"
    . "000008BBC24A40000008B9C248C0000008D2CB08B8424B0000"
    . "000F7D885DB8D0487894424100F84F302000083BC248C00000"
    . "0010F845B08000083BC248C000000020F840F0900008B84249"
    . "00000008B9C24940000000FB6BC24940000000FB6B42490000"
    . "000C744241800000000C744242400000000C1E8100FB6DF0FB"
    . "6D08B84249000000089D10FB6C4894424088B842494000000C"
    . "1F8100FB6C029C101D08904248B442408894C24408B4C24080"
    . "1D829D9894424088D043E894C240489F129F9894424148BBC2"
    . "4B40000008B8424B0000000894C240C89E98B6C2440C1E0028"
    . "5FF894424380F8EB60000008BB424B000000085F60F8E8D000"
    . "0008B8424A00000008B542424039424BC00000001C8034C243"
    . "889CF894C244003BC24A0000000EB398DB600000000391C247"
    . "C3D394C24047F37394C24087C3189F30FB6F33974240C0F9EC"
    . "3397424140F9DC183C00483C20121D9884AFF39F8741E0FB65"
    . "8020FB648010FB63039DD7EBE31C983C00483C201884AFF39F"
    . "875E28BB424B0000000017424248B4C24408344241801034C2"
    . "4108B442418398424B40000000F854AFFFFFF8B8424B000000"
    . "02B44243C8944240C8B8424B40000002B442434894424600F8"
    . "8160900008BB424C40000008B442428C744241000000000C74"
    . "4243800000000C7442434000000008D3C868B74243C89C5897"
    . "C246C83EE01897424748B44240C85C00F88E70000008B74243"
    . "88B8424AC000000BF00000000C704240000000001F0C1E0108"
    . "944246489F02B84249C0000000F49F88B84249C000000897C2"
    . "4680FAFBC24B000000001F089442470897C245C8DB60000000"
    . "08B04240344241089C1894424088B442430394424200F84AA0"
    . "100008B5C241C89C6038C24BC00000031C08B54242C85DB0F8"
    . "EC8010000897424048B7C2420EB2D39C77E1C8BB424C800000"
    . "08B1C8601CB803B00740B836C240401782B8D74260083C0013"
    . "944241C0F849101000039C57ECF8BB424C40000008B1C8601C"
    . "B803B0174BE83EA0179B9830424018B04243944240C0F8D68F"
    . "FFFFF83442438018BB424B00000008B4424380174241039442"
    . "4600F8DEFFEFFFF8B4C243483C47889C85B5E5F5DC250008B8"
    . "424900000008B8C24B4000000C744240C00000000C74424140"
    . "0000000C1E8100FB6C08904248B8424900000000FB6C489442"
    . "4040FB6842490000000894424088B8424B0000000C1E00285C"
    . "98944242489E88BAC24940000000F8E24FEFFFF8B9424B0000"
    . "00085D27E758B9C24A00000008B7424148BBC24A000000003B"
    . "424BC00000001C3034424248944241801C78D76008DBC27000"
    . "000000FB643020FB64B012B04242B4C24040FB6132B5424080"
    . "FAFC00FAFC98D04400FAFD28D04888D045039C50F9D0683C30"
    . "483C60139DF75C98BBC24B0000000017C24148B44241883442"
    . "40C01034424108B74240C39B424B40000000F8566FFFFFFE98"
    . "5FDFFFF85ED7E358B7424088BBC24BC00000031C08B54242C8"
    . "D1C378BB424C40000008B0C8601D9803901740983EA010F889"
    . "0FEFFFF83C00139C575E683BC24D0000000070F8EAA0100008"
    . "B442474030424C744244007000000896C2444894424288B842"
    . "4CC00000083C0208944243C8B44243C8B9424B00000008B7C2"
    . "4288B0029C28944244C8B84249800000001F839C20F4EC289C"
    . "68944245439FE0F8C090100008B44243C8B700C8B78108B680"
    . "8897424148B7014897C242489C7897424508BB424B40000002"
    . "B700489F08B74247039C60F4EC68BB424C4000000894424188"
    . "B47FC89442404C1E00201C6038424C8000000894424588B442"
    . "4688B7C2428037C245C39442418894424040F8C8700000085E"
    . "D7E268B8C24BC0000008B54242431C08D1C398B0C8601D9803"
    . "901740583EA01784A83C00139C575EA8B4424148B4C245039C"
    . "8747E85C07E7A8B9C24BC000000896C244831C08B6C245801F"
    . "BEB0983C00139442414745C8B54850001DA803A0074EC83E90"
    . "179E78B6C244890834424040103BC24B00000008B442404394"
    . "424180F8D79FFFFFF83442428018B442428394424540F8D4CF"
    . "FFFFF830424018B6C24448B04243944240C0F8D7EFCFFFFE91"
    . "1FDFFFF8B4424288B7C244C83442440078344243C1C8D4438F"
    . "F894424288B442440398424D00000000F8F7FFEFFFF8B6C244"
    . "48B7424348B0424038424A80000008BBC24D40000000B44246"
    . "48D4E01398C24D80000008904B70F8ED8FCFFFF85ED7E278BB"
    . "424BC0000008B7C24088B8424C40000008D1C3E8B74246C8B1"
    . "083C00401DA39F0C6020075F283042401894C24348B0424394"
    . "4240C0F8DDEFBFFFFE971FCFFFF89F68DBC27000000008B842"
    . "4B0000000038424A80000002B44243C894424248B8424AC000"
    . "000038424B40000002B442434398424AC000000894424380F8"
    . "F1B0400008B8424A40000008BB424A80000000FAF8424AC000"
    . "000C7442418000000008D04B0038424900000008BB424A0000"
    . "000894424348B442424398424A80000000F8F2B0100008B842"
    . "4AC000000C1E0108944243C8B442434894424148B8424A8000"
    . "000894424088B4424140FB67C060289C52BAC2490000000893"
    . "C240FB67C0601897C24040FB63C068B44241C85C00F8E14010"
    . "0008B442430894424108B44242C8944240C31C0EB5D3944242"
    . "07E4A8B9C24C80000008B0C8301E90FB6540E020FB65C0E012"
    . "B14242B5C24040FB60C0E0FAFD20FAFDB29F98D14520FAFC98"
    . "D149A8D144A399424940000007C0C836C2410017865908D742"
    . "60083C0013944241C0F84A3000000394424287E9D8B9C24C40"
    . "000008B0C8301E90FB6540E020FB65C0E012B14242B5C24040"
    . "FB60C0E0FAFD20FAFDB29F98D14520FAFC98D149A8D144A3B9"
    . "424940000000F8E5BFFFFFF836C240C010F8950FFFFFF83442"
    . "4080183442414048B442408394424240F8DF6FEFFFF838424A"
    . "C000000018BBC24A40000008B442438017C24343B8424AC000"
    . "0000F8DA0FEFFFF8B4C241883C4785B5E89C85F5DC250008D7"
    . "426008B7C24188B44243C0B4424088B9C24D40000008D4F013"
    . "B8C24D80000008904BB0F8D84FAFFFF894C2418EB848B84249"
    . "0000000C7042400000000C74424040000000083C001C1E0078"
    . "9C68B8424B0000000C1E002894424088B8424B400000085C00"
    . "F8ED3F8FFFF89E889F58BBC24B000000085FF7E5F8B8C24A00"
    . "000008B5C2404039C24BC00000001C1034424088944240C038"
    . "424A000000089C70FB651020FB641010FB6316BC04B6BD2260"
    . "1C289F0C1E00429F001D039C50F970383C10483C30139F975D"
    . "58BBC24B0000000017C24048B44240C83042401034424108B3"
    . "42439B424B40000007582E94CF8FFFF8B8424B00000008BB42"
    . "4B400000089EFC7042400000000C744240400000000C1E0028"
    . "5F6894424080F8E1EF8FFFF8B9C24B000000085DB7E598B8C2"
    . "4A00000008B5C24048BAC24A0000000039C24B800000001F90"
    . "37C240801FD0FB651020FB6410183C1040FB671FC83C3016BC"
    . "04B6BD22601C289F0C1E00429F001D0C1F8078843FF39E975D"
    . "38BB424B00000000174240483042401037C24108B042439842"
    . "4B400000075888B8424B000000031EDC74424040000000083E"
    . "8018904248B8424B400000083E801894424088B8424B000000"
    . "0F7D88944240C8B7424048B9424B800000031C08B8C24B0000"
    . "0008BBC24BC00000001F285C98D1C377F62EB738D742600390"
    . "424745B85ED7457396C240874510FB6320FB67AFFB90100000"
    . "003B4249000000039FE7C240FB67A0139FE7C1C8B7C240C0FB"
    . "63C3A39FE7C108BBC24B00000000FB60C3A39CE0F9CC1880C0"
    . "383C20183C001398424B0000000740885C075A031C9EBE68BB"
    . "424B00000000174240483C50139AC24B40000000F8557FFFFF"
    . "FE9C6F6FFFF83C47831C95B89C85E5F5DC2500090909090"
    x64:="4157415641554154555756534881EC88000000488B84245"
    . "0010000488BB42450010000448B94245801000089542430448"
    . "944241044898C24E80000008B40048B76144C8BBC244001000"
    . "04C8BB42448010000C744240C0000000089442438488B84245"
    . "001000089742420488BB424500100008B40088B76188944244"
    . "0488B842450010000897424248B400C89C789442444488B842"
    . "4500100008B401039C7894424180F4DC74585D289442448488"
    . "B84245001000048894424280F8ECC000000488B442428448B0"
    . "8448B68048B400885C0894424080F8E950000004489CE44894"
    . "C24044531E431FF31ED0F1F80000000004585ED7E624863542"
    . "404418D5C3D0089F848039424380100004589E0EB1C669083C"
    . "0014D63D94183C0044183C1014883C20139C34789149E74288"
    . "3F9034589C2440F45D0803A3175D783C0014C63DE4183C0048"
    . "3C6014883C20139C34789149F75D844016C240483C50103BC2"
    . "4180100004403A42400010000396C240875818344240C07488"
    . "34424281C8B44240C398424580100000F8F34FFFFFF83F9030"
    . "F846C0600008B8424000100008BBC24080100000FAF8424100"
    . "100008BB424000100008D3CB88B842418010000F7D885C9448"
    . "D2C860F841101000083F9010F844C08000083F9020F84EB080"
    . "0008B742430C744240800000000C744240C0000000089F0440"
    . "FB6CEC1E8104589CC0FB6D84889F08B7424100FB6D44189DB8"
    . "9F0440FB6C64889F1C1F8100FB6CD89D60FB6C08D2C0A8B942"
    . "4200100004129C301C3438D040129CE4529C4894424048B842"
    . "418010000C1E00285D2894424100F8E710100004C89BC24400"
    . "10000448BBC24180100004585FF0F8EBF040000488B8C24F80"
    . "000004863C74C6354240C31D24C03942430010000488D44010"
    . "2EB390F1F4400004439C37C4139CE7F3D39CD7C394539CC410"
    . "F9EC044394C24040F9DC14421C141880C124883C2014883C00"
    . "44139D70F8E5C040000440FB6000FB648FF440FB648FE4539C"
    . "37EBA31C9EBD58B5C2430448B8C242001000031ED4531E4488"
    . "9D84189DB0FB6DB0FB6F48B84241801000041C1EB10450FB6D"
    . "BC1E0024585C9894424040F8EAC0000004C89BC24400100004"
    . "C89B42448010000448B7C2410448BB424180100004585F67E6"
    . "B488B8C24F80000004D63D44C039424300100004863C74531C"
    . "94C8D440102662E0F1F840000000000410FB600410FB648FF4"
    . "10FB650FE4429D829F10FAFC029DA0FAFC98D04400FAFD28D0"
    . "4888D04504139C7430F9D040A4983C1014983C0044539CE7FC"
    . "4037C24044501F483C5014401EF39AC242001000075814C8BB"
    . "C24400100004C8BB424480100008B8424180100002B4424388"
    . "94424048B8424200100002B4424408944246C0F883B0800008"
    . "B7C24444531E44C8BAC2430010000448964240C448B6424484"
    . "8C744243000000000C74424280000000089F883E801498D6C8"
    . "7048B44243848896C24104C89FD4189FF4C89F7448B7424188"
    . "3E801894424788B44240485C00F88EA000000488B5C24308B8"
    . "424100100004889BC244801000001D8C1E0108944247089D82"
    . "B8424F000000089C6B8000000000F49C631F6894424644889F"
    . "74889EE0FAF842418010000488BAC2448010000894424688B8"
    . "424F000000001D8894424748B44240C897C24088D1C388B442"
    . "4244139C60F84AF0000004189C131C04585E4448B4424207F3"
    . "5E9C80000000F1F004139CE7E1B8B54850001DA4863D241807"
    . "C150000740A4183E901782E0F1F40004883C0014139C40F8E9"
    . "80000004139C789C17ECC8B148601DA4863D241807C1500017"
    . "4BC4183E80179B64883C701397C24040F8D79FFFFFF4889EF4"
    . "889F54883442430018B9C2418010000488B442430015C240C3"
    . "944246C0F8DEAFEFFFF8B4C242889C84881C4880000005B5E5"
    . "F5D415C415D415E415FC34585FF7E288B4C24204C8B4424104"
    . "889F28B0201D8489841807C050001740583E901788E4883C20"
    . "44939D075E483BC2458010000070F8EF00100008B442478488"
    . "B8C245001000003442408448964244C448BA42418010000448"
    . "97C24444883C1204889742418C744244007000000448974244"
    . "848897C24504989CF895C247C89C648896C2438418B074489E"
    . "229C2894424588B8424E800000001F039C20F4EC239F089442"
    . "4600F8CD6000000418B47148BBC2420010000412B7F0449635"
    . "FFC458B4F08418B6F0C8944245C8B442474458B771039C70F4"
    . "FF8488B44241848C1E3024C8D141848035C24388B442468448"
    . "D04068B44246439F84189C37F784585C97E244489F131D2418"
    . "B04924401C0489841807C050001740583E901784C4883C2014"
    . "139D17FE18B44245C39C50F84B500000085ED0F8EAD0000008"
    . "9C131D2EB140F1F8400000000004883C20139D50F8E9300000"
    . "08B04934401C0489841807C05000074E483E90179DF4183C30"
    . "14501E04439DF7D8883C601397424600F8D68FFFFFF488B7C2"
    . "450448B7C2444448B742448448B64244C488B742418488B6C2"
    . "4384883C701397C24040F8D8BFDFFFFE90DFEFFFF0F1F44000"
    . "0037C241044017C240C83442408014401EF8B4424083984242"
    . "00100000F851FFBFFFF4C8BBC2440010000E973FCFFFF8B442"
    . "45883442440074983C71C8D7406FF8B4424403984245801000"
    . "00F8F7DFEFFFF448B7C2444448B742448448B64244C488B7C2"
    . "4508B5C247C488B742418488B6C243848634424288B5424080"
    . "39424080100004C8B9C24600100000B5424708D4801398C246"
    . "8010000418914830F8E8FFDFFFF4585FF7E1E4C8B442410488"
    . "9F08B104883C00401DA4C39C04863D241C64415000075EA488"
    . "3C701397C2404894C24280F8DA9FCFFFFE92BFDFFFF0F1F008"
    . "B842418010000038424080100002B442438894424388B84241"
    . "0010000038424200100002B442440398424100100008944244"
    . "C0F8FE80300008B8424000100008BBC24080100000FAF84241"
    . "0010000448B642444448B6C24484C8B8C24F8000000C744242"
    . "8000000008D04B803442430894424408B44243839842408010"
    . "0000F8F3C0100008B8424100100008B6C2440C1E0108944244"
    . "48B842408010000894424048D450289EF2B7C24304585ED489"
    . "8450FB61C018D45014898410FB61C014863C5410FB634010F8"
    . "E230100008B4424248944240C8B4424208944240831C0EB6C4"
    . "4395424187E58418B0C8601F98D5102448D41014863C9410FB"
    . "60C094863D24D63C0410FB61411470FB6040129F10FAFC9442"
    . "9DA4129D80FAFD2450FAFC08D1452428D14828D144A3954241"
    . "07C11836C240C017875662E0F1F8400000000004883C001413"
    . "9C50F8EA30000004139C44189C27E8C418B0C8701F98D51024"
    . "48D41014863C9410FB60C094863D24D63C0410FB61411470FB"
    . "6040129F10FAFC94429DA4129D80FAFD2450FAFC08D1452428"
    . "D14828D144A3B5424100F8E41FFFFFF836C2408010F8936FFF"
    . "FFF834424040183C5048B442404394424380F8DE1FEFFFF838"
    . "42410010000018BBC24000100008B44244C017C24403B84241"
    . "00100000F8D8FFEFFFFE964FBFFFF660F1F440000486344242"
    . "88B5424440B542404488BBC24600100008D48013B8C2468010"
    . "0008914870F8D3AFBFFFF894C2428EB8D448B5C2430448B842"
    . "42001000031DB8B84241801000031F6448B942418010000418"
    . "3C30141C1E3074585C08D2C85000000000F8E6CF9FFFF4585D"
    . "27E57488B8C24F80000004C63CE4C038C24300100004863C74"
    . "531C0488D4C01020FB6110FB641FF440FB661FE6BC04B6BD22"
    . "601C24489E0C1E0044429E001D04139C3430F9704014983C00"
    . "14883C1044539C27FCC01EF4401D683C3014401EF399C24200"
    . "100007595E9FCF8FFFF8B8C24200100008B842418010000453"
    . "1DB31DB448B94241801000085C98D3485000000000F8ED2F8F"
    . "FFF4585D27E53488B8C24F80000004C63CB4C038C242801000"
    . "04863C74531C0488D4C01020FB6110FB641FF4883C1040FB66"
    . "9FA6BC04B6BD22601C289E8C1E00429E801D0C1F8074388040"
    . "14983C0014539C27FD001F74401D34183C3014401EF44399C2"
    . "42001000075978B8424180100004863BC24180100004531DB4"
    . "48B84241801000031F68D58FF8B8424200100004989FC49F7D"
    . "C8D68FF4585C07E7D4C8B8C24300100004863CE31C04889CA4"
    . "8039424280100004901C9EB5539C374554585DB74504439DD7"
    . "44B440FB612440FB66AFFB90100000044035424304539EA7C1"
    . "E440FB66A014539EA7C14460FB62C224539EA7C0A0FB60C3A4"
    . "139CA0F9CC141880C014883C0014883C2014139C07E0885C07"
    . "5A731C9EBE74401C64183C30144399C24200100000F856CFFF"
    . "FFFE9A1F7FFFF31C9E92AF9FFFF9090909090909090"
    MCode(MyFunc, A_PtrSize=8 ? x64:x32)
  }
  return, DllCall(&MyFunc
    , Int,mode, "uint",color, Int,n, Int,offsetX, Int,offsetY
    , Ptr,Scan0, Int,Stride, Int,sx, Int,sy, Int,sw, Int,sh
    , Ptr,&gs, Ptr,&ss, "AStr",text, Ptr,&s1, Ptr,&s0
    , Ptr,&input, Int,input_num, Ptr,&allpos, Int,allpos_max)
}

xywh2xywh(x1,y1,w1,h1,ByRef x,ByRef y,ByRef w,ByRef h)
{
  SysGet, zx, 76
  SysGet, zy, 77
  SysGet, zw, 78
  SysGet, zh, 79
  left:=x1, right:=x1+w1-1, up:=y1, down:=y1+h1-1
  left:=left<zx ? zx:left, right:=right>zx+zw-1 ? zx+zw-1:right
  up:=up<zy ? zy:up, down:=down>zy+zh-1 ? zy+zh-1:down
  x:=left, y:=up, w:=right-left+1, h:=down-up+1
}

GetBitsFromScreen(x, y, w, h, ByRef Scan0, ByRef Stride
  , ScreenShot=1, ByRef zx="", ByRef zy="")
{
  static bits, bpp, oldx, oldy, oldw, oldh
  if (ScreenShot or x<oldx or y<oldy
    or x+w>oldx+oldw or y+h>oldy+oldh)
  {
    oldx:=x, oldy:=y, oldw:=w, oldh:=h, ScreenShot:=1
    VarSetCapacity(bits, w*h*4), bpp:=32
  }
  Scan0:=&bits, Stride:=((oldw*bpp+31)//32)*4, zx:=oldx, zy:=oldy
  if (!ScreenShot or w<1 or h<1)
    return
  Ptr:=A_PtrSize ? "UPtr" : "UInt", PtrP:=Ptr . "*"
  win:=DllCall("GetDesktopWindow", Ptr)
  hDC:=DllCall("GetWindowDC", Ptr,win, Ptr)
  mDC:=DllCall("CreateCompatibleDC", Ptr,hDC, Ptr)
  ;-------------------------
  VarSetCapacity(bi, 40, 0), NumPut(40, bi, 0, "int")
  NumPut(w, bi, 4, "int"), NumPut(-h, bi, 8, "int")
  NumPut(1, bi, 12, "short"), NumPut(bpp, bi, 14, "short")
  ;-------------------------
  if hBM:=DllCall("CreateDIBSection", Ptr,mDC, Ptr,&bi
    , "int",0, PtrP,ppvBits, Ptr,0, "int",0, Ptr)
  {
    oBM:=DllCall("SelectObject", Ptr,mDC, Ptr,hBM, Ptr)
    DllCall("BitBlt", Ptr,mDC, "int",0, "int",0, "int",w, "int",h
      , Ptr,hDC, "int",x, "int",y, "uint",0x00CC0020|0x40000000)
    DllCall("RtlMoveMemory", Ptr,Scan0, Ptr,ppvBits, Ptr,Stride*h)
    DllCall("SelectObject", Ptr,mDC, Ptr,oBM)
    DllCall("DeleteObject", Ptr,hBM)
  }
  DllCall("DeleteDC", Ptr,mDC)
  DllCall("ReleaseDC", Ptr,win, Ptr,hDC)
}

MCode(ByRef code, hex)
{
  bch:=A_BatchLines
  SetBatchLines, -1
  VarSetCapacity(code, len:=StrLen(hex)//2)
  lls:=A_ListLines=0 ? "Off" : "On"
  ListLines, Off
  Loop, % len
    NumPut("0x" SubStr(hex,2*A_Index-1,2),code,A_Index-1,"uchar")
  ListLines, %lls%
  Ptr:=A_PtrSize ? "UPtr" : "UInt", PtrP:=Ptr . "*"
  DllCall("VirtualProtect",Ptr,&code, Ptr,len,"uint",0x40,PtrP,0)
  SetBatchLines, %bch%
}

base64tobit(s)
{
  Chars:="0123456789+/ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    . "abcdefghijklmnopqrstuvwxyz"
  SetFormat, IntegerFast, d
  StringCaseSense, On
  lls:=A_ListLines=0 ? "Off" : "On"
  ListLines, Off
  Loop, Parse, Chars
  {
    i:=A_Index-1, v:=(i>>5&1) . (i>>4&1)
      . (i>>3&1) . (i>>2&1) . (i>>1&1) . (i&1)
    s:=StrReplace(s,A_LoopField,v)
  }
  ListLines, %lls%
  StringCaseSense, Off
  s:=SubStr(s,1,InStr(s,"1",0,0)-1)
  s:=RegExReplace(s,"[^01]+")
  return, s
}

bit2base64(s)
{
  s:=RegExReplace(s,"[^01]+")
  s.=SubStr("100000",1,6-Mod(StrLen(s),6))
  s:=RegExReplace(s,".{6}","|$0")
  Chars:="0123456789+/ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    . "abcdefghijklmnopqrstuvwxyz"
  SetFormat, IntegerFast, d
  lls:=A_ListLines=0 ? "Off" : "On"
  ListLines, Off
  Loop, Parse, Chars
  {
    i:=A_Index-1, v:="|" . (i>>5&1) . (i>>4&1)
      . (i>>3&1) . (i>>2&1) . (i>>1&1) . (i&1)
    s:=StrReplace(s,v,A_LoopField)
  }
  ListLines, %lls%
  return, s
}

ASCII(s)
{
  if RegExMatch(s,"\$(\d+)\.([\w+/]+)",r)
  {
    s:=RegExReplace(base64tobit(r2),".{" r1 "}","$0`n")
    s:=StrReplace(StrReplace(s,"0","_"),"1","0")
  }
  else s=
  return, s
}

; You can put the text library at the beginning of the script,
; and Use Pic(Text,1) to add the text library to Pic()'s Lib,
; Use Pic("comment1|comment2|...") to get text images from Lib

Pic(comments, add_to_Lib=0)
{
  static Lib:=[]
  if (add_to_Lib)
  {
    re:="<([^>]*)>[^$]+\$\d+\.[\w+/]+"
    Loop, Parse, comments, |
      if RegExMatch(A_LoopField,re,r)
        Lib[Trim(r1)]:=r
    Lib[""]:=""
  }
  else
  {
    Text:=""
    Loop, Parse, comments, |
      Text.="|" . Lib[Trim(A_LoopField)]
    return, Text
  }
}

PicN(Number)
{
  return, Pic( RegExReplace(Number, ".", "|$0") )
}

; Use PicX(Text) to automatically cut into multiple characters
; Can't be used in ColorPos mode, because it can cause position errors

PicX(Text)
{
  if !RegExMatch(Text,"\|([^$]+)\$(\d+)\.([\w+/]+)",r)
    return, Text
  w:=r2, v:=base64tobit(r3), Text:=""
  c:=StrLen(StrReplace(v,"0"))<=StrLen(v)//2 ? "1":"0"
  wz:=RegExReplace(v,".{" w "}","$0`n")
  SetFormat, IntegerFast, d
  While InStr(wz,c) {
    While !(wz~="m`n)^" c)
      wz:=RegExReplace(wz,"m`n)^.")
    i:=0
    While (wz~="m`n)^.{" i "}" c)
      i++
    v:=RegExReplace(wz,"m`n)^(.{" i "}).*","$1")
    wz:=RegExReplace(wz,"m`n)^.{" i "}")
    if v!=
      Text.="|" r1 "$" i "." bit2base64(v)
  }
  return, Text
}

; Screenshot and retained as the last screenshot.

ScreenShot()
{
  n:=150000
  xywh2xywh(-n,-n,2*n+1,2*n+1,x,y,w,h)
  GetBitsFromScreen(x,y,w,h,Scan0,Stride,1)
}

FindTextOCR(nX, nY, nW, nH, err1, err0, Text, Interval=20)
{
  OCR:="", RightX:=nX+nW-1, ScreenShot()
  While (ok:=FindText(nX, nY, nW, nH, err1, err0, Text, 0))
  {
    For k,v in ok
    {
      ; X is the X coordinates of the upper left corner
      ; and W is the width of the image have been found
      x:=v.1, y:=v.2, w:=v.3, h:=v.4, comment:=v.5
      ; We need the leftmost X coordinates
      if (A_Index=1 or x<LeftX)
        LeftX:=x, LeftY:=y, LeftW:=w, LeftH:=h, LeftOCR:=comment
      else if (x=LeftX)
      {
        Loop, 100
        {
          err:=A_Index/100
          if FindText(x, y, w, h, err, err, Text, 0)
          {
            LeftX:=x, LeftY:=y, LeftW:=w, LeftH:=h, LeftOCR:=comment
            Break
          }
          if FindText(LeftX, LeftY, LeftW, LeftH, err, err, Text, 0)
            Break
        }
      }
    }
    ; If the interval exceeds the set value, add "*" to the result
    OCR.=(A_Index>1 && LeftX-nX-1>Interval ? "*":"") . LeftOCR
    ; Update nX and nW for next search
    nX:=LeftX+LeftW-1, nW:=RightX-nX+1
  }
  return, OCR
}

; Reordering the objects returned from left to right,
; from top to bottom, ignore slight height difference

SortOK(ok, dy=10) {
  if !IsObject(ok)
    return, ok
  SetFormat, IntegerFast, d
  For k,v in ok
  {
    x:=v.1+v.3//2, y:=v.2+v.4//2
    y:=A_Index>1 && Abs(y-lasty)<dy ? lasty : y, lasty:=y
    n:=(y*150000+x) "." k, s:=A_Index=1 ? n : s "-" n
  }
  Sort, s, N D-
  ok2:=[]
  Loop, Parse, s, -
    ok2.Push( ok[(StrSplit(A_LoopField,".")[2])] )
  return, ok2
}

; Reordering according to the nearest distance

SortOK2(ok, px, py) {
  if !IsObject(ok)
    return, ok
  SetFormat, IntegerFast, d
  For k,v in ok
  {
    x:=v.1+v.3//2, y:=v.2+v.4//2
    n:=((x-px)**2+(y-py)**2) "." k
    s:=A_Index=1 ? n : s "-" n
  }
  Sort, s, N D-
  ok2:=[]
  Loop, Parse, s, -
    ok2.Push( ok[(StrSplit(A_LoopField,".")[2])] )
  return, ok2
}

; Prompt mouse position in remote assistance

MouseTip(x="", y="") {
  if (x="")
  {
    VarSetCapacity(pt,16,0), DllCall("GetCursorPos","ptr",&pt)
    x:=NumGet(pt,0,"uint"), y:=NumGet(pt,4,"uint")
  }
  x:=Round(x-10), y:=Round(y-10), w:=h:=2*10+1
  ;-------------------------
  Gui, _MouseTip_: +AlwaysOnTop -Caption +ToolWindow +Hwndmyid +E0x08000000
  Gui, _MouseTip_: Show, Hide w%w% h%h%
  ;-------------------------
  dhw:=A_DetectHiddenWindows
  DetectHiddenWindows, On
  d:=4, i:=w-d, j:=h-d
  s=0-0 %w%-0 %w%-%h% 0-%h% 0-0
  s=%s%  %d%-%d% %i%-%d% %i%-%j% %d%-%j% %d%-%d%
  WinSet, Region, %s%, ahk_id %myid%
  DetectHiddenWindows, %dhw%
  ;-------------------------
  Gui, _MouseTip_: Show, NA x%x% y%y%
  Loop, 4 {
    Gui, _MouseTip_: Color, % A_Index & 1 ? "Red" : "Blue"
    Sleep, 500
  }
  Gui, _MouseTip_: Destroy
}


/***** C source code of machine code *****

int __attribute__((__stdcall__)) PicFind(
  int mode, unsigned int c, int n, int offsetX, int offsetY
  , unsigned char * Bmp, int Stride
  , int sx, int sy, int sw, int sh
  , unsigned char * gs, char * ss, char * text
  , int * s1, int * s0, int * input, int input_num
  , unsigned int * allpos, int allpos_max)
{
  int o, i, j, x, y, r, g, b, rr, gg, bb, max, e1, e0, ok;
  int o1, x1, y1, w1, h1, sx1, sy1, len1, len0, err1, err0;
  int o2, x2, y2, w2, h2, sx2, sy2, len21, len20, err21, err20;
  int r_min, r_max, g_min, g_max, b_min, b_max;
  //----------------------
  ok=0; w1=input[1]; h1=input[2]; len1=input[3]; len0=input[4];
  err1=input[5]; err0=input[6]; max=len1>len0 ? len1 : len0;
  //----------------------
  // Generate Lookup Table
  for (j=0; j<input_num; j+=7)
  {
    o=o1=o2=input[j]; w2=input[j+1]; h2=input[j+2];
    for (y=0; y<h2; y++)
    {
      for (x=0; x<w2; x++)
      {
        i=(mode==3) ? y*Stride+x*4 : y*sw+x;
        if (text[o++]=='1')
          s1[o1++]=i;
        else
          s0[o2++]=i;
      }
    }
  }
  // Color Position Mode
  // This mode is not support combination lookup
  // only used to recognize multicolored Verification Code
  if (mode==3)
  {
    sx1=sx+sw-w1; sy1=sy+sh-h1;
    for (y=sy; y<=sy1; y++)
    {
      for (x=sx; x<=sx1; x++)
      {
        o=y*Stride+x*4; e1=err1; e0=err0;
        j=o+c; rr=Bmp[2+j]; gg=Bmp[1+j]; bb=Bmp[j];
        for (i=0; i<max; i++)
        {
          if (i<len1)
          {
            j=o+s1[i]; r=Bmp[2+j]-rr; g=Bmp[1+j]-gg; b=Bmp[j]-bb;
            if (3*r*r+4*g*g+2*b*b>n && (--e1)<0)
              goto NoMatch3;
          }
          if (i<len0)
          {
            j=o+s0[i]; r=Bmp[2+j]-rr; g=Bmp[1+j]-gg; b=Bmp[j]-bb;
            if (3*r*r+4*g*g+2*b*b<=n && (--e0)<0)
              goto NoMatch3;
          }
        }
        allpos[ok++]=y<<16|x;
        if (ok>=allpos_max)
          goto Return1;
        NoMatch3:
        continue;
      }
    }
    goto Return1;
  }
  // Generate Two Value Image
  o=sy*Stride+sx*4; j=Stride-4*sw; i=0;
  if (mode==0)  // Color Mode
  {
    rr=(c>>16)&0xFF; gg=(c>>8)&0xFF; bb=c&0xFF;
    for (y=0; y<sh; y++, o+=j)
      for (x=0; x<sw; x++, o+=4, i++)
      {
        r=Bmp[2+o]-rr; g=Bmp[1+o]-gg; b=Bmp[o]-bb;
        ss[i]=(3*r*r+4*g*g+2*b*b<=n) ? 1:0;
      }
  }
  else if (mode==1)  // Gray Threshold Mode
  {
    c=(c+1)*128;
    for (y=0; y<sh; y++, o+=j)
      for (x=0; x<sw; x++, o+=4, i++)
        ss[i]=(Bmp[2+o]*38+Bmp[1+o]*75+Bmp[o]*15<c) ? 1:0;
  }
  else if (mode==2)  // Gray Difference Mode
  {
    for (y=0; y<sh; y++, o+=j)
    {
      for (x=0; x<sw; x++, o+=4, i++)
        gs[i]=(Bmp[2+o]*38+Bmp[1+o]*75+Bmp[o]*15)>>7;
    }
    sx1=sw-1; sy1=sh-1; i=0;
    for (y=0; y<sh; y++)
      for (x=0; x<sw; x++, i++)
      {
        j=gs[i]+c;
        ss[i]=(x!=0 && x!=sx1 && y!=0 && y!=sy1
          && (gs[i-1]>j || gs[i+1]>j
          || gs[i-sw]>j || gs[i+sw]>j)) ? 1:0;
      }
  }
  else // (mode==4) Color Difference Mode
  {
    r=(c>>16)&0xFF; g=(c>>8)&0xFF; b=c&0xFF;
    rr=(n>>16)&0xFF; gg=(n>>8)&0xFF; bb=n&0xFF;
    r_min=r-rr; g_min=g-gg; b_min=b-bb;
    r_max=r+rr; g_max=g+gg; b_max=b+bb;
    for (y=0; y<sh; y++, o+=j)
      for (x=0; x<sw; x++, o+=4, i++)
      {
        r=Bmp[2+o]; g=Bmp[1+o]; b=Bmp[o];
        ss[i]=(r>=r_min && r<=r_max
            && g>=g_min && g<=g_max
            && b>=b_min && b<=b_max) ? 1:0;
      }
  }
  // Start Lookup
  sx1=sw-w1; sy1=sh-h1;
  for (y=0; y<=sy1; y++)
  {
    for (x=0; x<=sx1; x++)
    {
      o=y*sw+x; e1=err1; e0=err0;
      if (e0==len0)
      {
        for (i=0; i<len1; i++)
          if (ss[o+s1[i]]!=1 && (--e1)<0)
            goto NoMatch1;
      }
      else
      {
        for (i=0; i<max; i++)
        {
          if (i<len1 && ss[o+s1[i]]!=1 && (--e1)<0)
            goto NoMatch1;
          if (i<len0 && ss[o+s0[i]]!=0 && (--e0)<0)
            goto NoMatch1;
        }
      }
      //------------------
      if (input_num>7)
      {
        x1=x+w1-1; y1=y-offsetY; if (y1<0) y1=0;
        for (j=7; j<input_num; j+=7)
        {
          o2=input[j]; w2=input[j+1]; h2=input[j+2];
          len21=input[j+3]; len20=input[j+4];
          err21=input[j+5]; err20=input[j+6];
          sx2=sw-w2; i=x1+offsetX; if (i<sx2) sx2=i;
          sy2=sh-h2; i=y+offsetY; if (i<sy2) sy2=i;
          for (x2=x1; x2<=sx2; x2++)
          {
            for (y2=y1; y2<=sy2; y2++)
            {
              o1=y2*sw+x2; e1=err21; e0=err20;
              for (i=0; i<len21; i++)
              {
                if (ss[o1+s1[o2+i]]!=1 && (--e1)<0)
                  goto NoMatch2;
              }
              if (e0!=len20)
              {
                for (i=0; i<len20; i++)
                  if (ss[o1+s0[o2+i]]!=0 && (--e0)<0)
                    goto NoMatch2;
              }
              goto MatchOK;
              NoMatch2:
              continue;
            }
          }
          goto NoMatch1;
          MatchOK:
          x1=x2+w2-1;
        }
      }
      //------------------
      allpos[ok++]=(sy+y)<<16|(sx+x);
      if (ok>=allpos_max)
        goto Return1;
      // Clear the image that has been found
      for (i=0; i<len1; i++)
        ss[o+s1[i]]=0;
      NoMatch1:
      continue;
    }
  }
  Return1:
  return ok;
}

*/

;================= The End =================

;