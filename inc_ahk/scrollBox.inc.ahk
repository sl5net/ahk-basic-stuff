; Indentation_style: https://de.wikipedia.org/wiki/EinrÃ¼ckungsstil#SL5small-Stil


ScrollBox(String, Options := "-w")	; Option = "w" for Word Wrap, "-w" for No Word Wrap, "p" for Pause Until Gui Closes
{
	Static ScrollBox_Gui_Hwnd
	Gui, ScrollBox_Gui_Label:+MinSize200x200 +Resize
	Gui, ScrollBox_Gui_Label:Color, FFFFFF
	if (Options ~= "i)-w") ; No Word Wrap, Vertical and Horizontal Scrollbars
		Gui, ScrollBox_Gui_Label:Add, Edit, hwndScrollBox_Gui_Hwnd ReadOnly -E0x200 +0x300000 -wrap, %String%
	else if (Options ~= "i)(?<!-)w") ; Word Wrap, Vertical Scrollbar
		Gui, ScrollBox_Gui_Label:Add, Edit, hwndScrollBox_Gui_Hwnd ReadOnly -E0x200, %String%
	Gui, ScrollBox_Gui_Label:Show, AutoSize, ScrollBox
	ControlSend,,^{Home}, ahk_id %ScrollBox_Gui_Hwnd% ; Unselect Text and Move to Top of Control
	DllCall("HideCaret", "Int", ScrollBox_Gui_Hwnd)
	if (Options ~= "i)p")
		while WinExist("ahk_id" ScrollBox_Gui_Hwnd)
			Sleep 50
	return

	ScrollBox_Gui_LabelGuiSize:
		NewWidth := A_GuiWidth - 20
		NewHeight := A_GuiHeight - 20
		GuiControl, Move, %ScrollBox_Gui_Hwnd%, W%NewWidth% H%NewHeight%
	return

	ScrollBox_Gui_LabelGuiEscape:
	ScrollBox_Gui_LabelGuiClose:
		Gui, ScrollBox_Gui_Label:Destroy
	return
}

ExitApp


S = 
(
Each script is a plain text file containing commands to be executed by the program (AutoHotkey.exe). A script may also contain hotkeys and hotstrings, or even consist entirely of them. However, in the absence of hotkeys and hotstrings, a script will perform its commands sequentially from top to bottom the moment it is launched.

To create a new script:
1.Download and install AutoHotkey.
2.Right-click an empty spot on your desktop or in a folder of your choice.
3.In the menu that appears, select New -> AutoHotkey Script. (Alternatively, select New -> Text Document.)
4.Type a name for the file, ensuring that it ends in .ahk. For example: Test.ahk
5.Right-click the file and choose Edit Script.
6.On a new blank line, type the following:
 #space::Run www.google.com

)


Loop 20
{
	T := T "`n" S
}


ScrollBox(T ,"WP") ; Word Wrap and Pause
MsgBox Done
