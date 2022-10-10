#Persistent
#NoEnv
SendMode Input
Knobdown := false
Knobdownt := false
AppName := "com.squirrel.Discord.Discord"
idList := ""
global notifysinhtml := ""
global Layernum := 10
Zoomnum := 1.0
notecount := 0
global Protools := false
global h_midiout
global magloaded := false
global Zoomnum := 0
GroupAdd, MyGroup, ahk_exe IndianaWindowsStore-Win64-Shipping.exe 
GroupAdd, MyGroup, ahk_exe destiny2.exe
GroupAdd, MyGroup, ahk_exe r5apex.exe
GroupAdd, MyGroup, ahk_exe FortniteClient-Win64-Shipping.exe
GroupAdd, MyGroup, ahk_exe csgo.exe
GroupAdd, MyGroup, ahk_exe Overwatch.exe
GroupAdd, MyGroup, ahk_exe ModernWarfare.exe
GroupAdd, MyGroup, ahk_exe GWT.exe
GroupAdd, MyGroup, ahk_exe GameOverlayUI.exe
GroupAdd, MyGroup, ahk_exe GameBar.exe
GroupAdd, MyGroup, ahk_exe GameBarFTServer.exe
GroupAdd, MyGroup, ahk_exe GameBarPresenceWriter.exe
GroupAdd, MyGroup, ahk_exe LEGOSTARWARSSKYWALKERSAGA_DX11.exe
GroupAdd, MyGroup, ahk_exe haloinfinite.exe
GroupAdd, MyGroup, ahk_exe NMS.exe
GroupAdd, MyGroup, ahk_exe Prey.exe
GroupAdd, MyGroup, ahk_exe javaw.exe ;minecraft
GroupAdd, MyGroup, ahk_exe sniperelite5.exe
GroupAdd, MyGroup, ahk_exe sniper5_dx12.exe
GroupAdd, MyGroup, ahk_exe Dishonored2.exe
GroupAdd, MyGroup, ahk_exe RDR2.exe
GroupAdd, MyGroup, ahk_exe FallGuys_client_game.exe
I_Icon = C:\Program Files\AutoHotkey\Lib\AHK.ico
IfExist, %I_Icon%
Menu, Tray, Icon, %I_Icon%
Menu, tray, add, Work_Startup
Menu, tray, add, VPN_Work
Menu, tray, add, Kill_XBOX_OVERLAY
SetBatchLines, -1
Mididothing()
Checknote()
settimez()
SetTimer, Checknote, 300000
SetTimer, settimez, 200000
SetTimer, checkforp, 1000
return
/*
Left Foot = F16
Middle Foot = F17
Right Foot = F18
Mouse 4 = XButton1
Mouse 5 = XButton2
Mouse 6 = PgUp
Mouse 7 = PgDn
*/
; --- Hotkeys ---
Kill_XBOX_OVERLAY(){
	DetectHiddenWindows, On
	Process, close, GameBar.exe
	DetectHiddenWindows, Off
}
checkforp(){
	global Protools
	global Layernum
	IfWinExist, ahk_exe ProTools.exe
	{
		if (Protools == false){
			Process,Close,voicemeeterpro.exe
			Process,Close,lighthost.exe
			global Layernum := 30
			SentaCC(117, 30)
			Protools := true
			clostmidi()
		}
	}
	IfWinNotExist, ahk_exe ProTools.exe
	{
		if (Protools == true)
		{
			
			SentaCC(117, 30)
			Mididothing()
			Protools := false
		}
		IfWinExist,	ahk_group MyGroup
		{
			global Layernum := 20
			SentaCC(117, 20)
		}
		IfWinNotExist, ahk_group MyGroup
		{
			global Layernum := 10
			SentaCC(117, 10)
		}
	}
}
Work_Startup()
{
	Run https://outlook.office.com/
	Run microsoft-edge:https://outlook.office.com/
	Run, "C:\Program Files (x86)\WatchGuard\WatchGuard Mobile VPN with SSL\wgsslvpnc.exe"
	Sleep, 300
	Send, {Tab}
	Send, {Tab}
	Sleep, 300
	Send, 1060M
	Send, {@}
	Send, {!}
	Send, tl
	Send, {@}
	Send, nd
	Send, {!}
	Sleep, 100
	Send, {Enter}
	Sleep, 1500
	Run, Open "\\192.168.1.200\jda_data\"

}
VPN_Work()
{
	Run, "C:\Program Files (x86)\WatchGuard\WatchGuard Mobile VPN with SSL\wgsslvpnc.exe"
	Sleep, 300
	Send, {Tab}
	Send, {Tab}
	Sleep, 300
	Send, 1060M
	Send, {@}
	Send, {!}
	Send, tl
	Send, {@}
	Send, nd
	Send, {!}
	Sleep, 100
	Send, {Enter}
}
settimez(){
	global Layernum
	SentaCC(117, Layernum)

}
Phonelined(){
	global notifysinhtml
	FileDelete, C:\temp\image.html
	HTMLPT1 := "<!DOCTYPE html> <html lang=""en""> <head> </head> <body style=""background: black;"">"
	HTMLPT2 := "</body> </html>"
	FileAppend,%HTMLPT1% %notifysinhtml% %HTMLPT2%, C:\temp\image.html
	run, %comspec% /c C:\Users\legoc\Documents\Arduino\sketch_apr08a\wkhtmltoimage.exe --enable-local-file-access --load-error-handling ignore --height 500 --width 500 "C:\temp\image.html" "C:\temp\image.png",,hide
	file=C:\temp\image.png
    pToken := Gdip_Startup()
    pBitmap := Gdip_BitmapFromHWND(hwnd)
    Gdip_SaveBitmapToFile(pBitmap,file)
    Gdip_DisposeImage(pBitmap)
    Gdip_Shutdown(pToken)
	ImageX := 0 ;Change "20" to your own needs etc.
	ImageY := 0 ; Same here
	;Highh := 1000
	;Loww := 1000
	SplashImage, %file%, B X%ImageX% Y%ImageY% ,,, Phonelinedz ;H%Highh% W%Loww%
	WinSet, Transparent, 150, Phonelinedz

	if (State = -1){
		WinMinimize, Phone Link
		WinShow, Phone Link
	}
	DetectHiddenWindows, Off
}

Phonelinedoff(){
	SplashImage, Off
}
Newnote(text)
{
	
}
Checknote(){
global Zoomnum
if (Zoomnum < 1){
	Zoomnum = 0
	Process,Close,Magnify.exe
}
Notesz := ""
Namezs := ""
idlistb := []
global notifysinhtml := ""
CreateClass("Windows.UI.Notifications.Management.UserNotificationListener", IUserNotificationListenerStatics := "{FF6123CF-4386-4AA3-B73D-B804E5B63B23}", UserNotificationListenerStatics)
DllCall(NumGet(NumGet(UserNotificationListenerStatics+0)+6*A_PtrSize), "ptr", UserNotificationListenerStatics, "ptr*", listener)   ; get_Current
DllCall(NumGet(NumGet(listener+0)+6*A_PtrSize), "ptr", listener, "int*", accessStatus)   ; RequestAccessAsync
WaitForAsync(accessStatus)
if (accessStatus != 1)
{
   exitapp
}
   DllCall(NumGet(NumGet(listener+0)+10*A_PtrSize), "ptr", listener, "int", 1, "ptr*", UserNotificationReadOnlyList)   ; GetNotificationsAsync
   WaitForAsync(UserNotificationReadOnlyList)
   DllCall(NumGet(NumGet(UserNotificationReadOnlyList+0)+7*A_PtrSize), "ptr", UserNotificationReadOnlyList, "int*", count)   ; count
   loop % count
   {
      DllCall(NumGet(NumGet(UserNotificationReadOnlyList+0)+6*A_PtrSize), "ptr", UserNotificationReadOnlyList, "int", A_Index-1, "ptr*", UserNotification)   ; get_Item
      DllCall(NumGet(NumGet(UserNotification+0)+8*A_PtrSize), "ptr", UserNotification, "uint*", id)   ; get_Id
      if InStr(idList, "|" id "|")
      {
         ObjRelease(UserNotification)
         Continue
      }
      idList .= "|" id "|"
      if !DllCall(NumGet(NumGet(UserNotification+0)+7*A_PtrSize), "ptr", UserNotification, "ptr*", AppInfo)   ; get_AppInfo
      {
         DllCall(NumGet(NumGet(AppInfo+0)+8*A_PtrSize), "ptr", AppInfo, "ptr*", AppDisplayInfo)   ; get_DisplayInfo
         DllCall(NumGet(NumGet(AppDisplayInfo+0)+6*A_PtrSize), "ptr", AppDisplayInfo, "ptr*", hText)   ; get_DisplayName
         buffer := DllCall("Combase.dll\WindowsGetStringRawBuffer", "ptr", hText, "uint*", length, "ptr")
         text := StrGet(buffer, "UTF-16")
         DeleteHString(hText)
         ObjRelease(AppDisplayInfo)
         ObjRelease(AppInfo)
         ;if inStr(text, AppName)
            ;Continue
		idlistb.Push("|" id "|")
		;if (A_Index = 1)
		Namezs := text
      }
      else
         Continue
      DllCall(NumGet(NumGet(UserNotification+0)+6*A_PtrSize), "ptr", UserNotification, "ptr*", Notification)   ; get_Notification
      DllCall(NumGet(NumGet(Notification+0)+8*A_PtrSize), "ptr", Notification, "ptr*", NotificationVisual)   ; get_Visual
      DllCall(NumGet(NumGet(NotificationVisual+0)+8*A_PtrSize), "ptr", NotificationVisual, "ptr*", NotificationBindingList)   ; get_Bindings
      DllCall(NumGet(NumGet(NotificationBindingList+0)+7*A_PtrSize), "ptr", NotificationBindingList, "int*", count)   ; count
      loop % count
      {
         DllCall(NumGet(NumGet(NotificationBindingList+0)+6*A_PtrSize), "ptr", NotificationBindingList, "int", A_Index-1, "ptr*", NotificationBinding)   ; get_Item
         DllCall(NumGet(NumGet(NotificationBinding+0)+11*A_PtrSize), "ptr", NotificationBinding, "ptr*", AdaptiveNotificationTextReadOnlyList)   ; GetTextElements
         DllCall(NumGet(NumGet(AdaptiveNotificationTextReadOnlyList+0)+7*A_PtrSize), "ptr", AdaptiveNotificationTextReadOnlyList, "int*", count)   ; count
         loop % count
         {
            DllCall(NumGet(NumGet(AdaptiveNotificationTextReadOnlyList+0)+6*A_PtrSize), "ptr", AdaptiveNotificationTextReadOnlyList, "int", A_Index-1, "ptr*", AdaptiveNotificationText)   ; get_Item
            DllCall(NumGet(NumGet(AdaptiveNotificationText+0)+6*A_PtrSize), "ptr", AdaptiveNotificationText, "ptr*", hText)   ; get_Text
            buffer := DllCall("Combase.dll\WindowsGetStringRawBuffer", "ptr", hText, "uint*", length, "ptr")
            if (A_Index = 1){
               text := StrGet(buffer, "UTF-16")
			   notifysinhtml .= "<h1 style="""
			   notifysinhtml .= "color:white; font-size:x-large; font-family: 'Courier New', Courier, monospace;"">"
			   notifysinhtml .= text
			   notifysinhtml .= "</h1>"
			}
            if (A_Index = 3){
			   notifysinhtml .= "<p style="""
			   notifysinhtml .= "color:white; font-size: large; font-family: 'Courier New', Courier, monospace;"">"
               text := " " StrGet(buffer, "UTF-16")
			   notifysinhtml .= text
			   ;text := " " StrGet(buffer, "UTF-16")
			   notifysinhtml .= text
			   notifysinhtml .= "</p>"
			}
            DeleteHString(hText)
            ObjRelease(AdaptiveNotificationText)
         }
		 Notesz := text
         ObjRelease(AdaptiveNotificationTextReadOnlyList)
         ObjRelease(NotificationBinding)
		 ;Notesz .=  - 
      }
      ObjRelease(NotificationBindingList)
      ObjRelease(NotificationVisual)
      ObjRelease(Notification)
      ObjRelease(UserNotification)
	  ;SetFormat, Integer, DEC
	  notecount := idlistb.MaxIndex()
	  ;OutputDebug, % notifysinhtml
	  global Protools
	  if (Protools == False){
	  ;SentaCC(116, notecount)
	  }
   }
   ObjRelease(UserNotificationReadOnlyList)
   DllCall("psapi.dll\EmptyWorkingSet", "ptr", -1)
}

base(num,inputbase,outputbase){
  VarSetCapacity(S,65,0)
  toDec := DllCall("msvcrt\_strtoui64", Str,num, Uint,0, Int,inputbase, "CDECL Int64")
  DllCall("msvcrt\_i64toa", Int64,toDec, Str,S, Int,outputbase)
  return, S
}
CreateClass(string, interface, ByRef Class)
{
   CreateHString(string, hString)
   VarSetCapacity(GUID, 16)
   DllCall("ole32\CLSIDFromString", "wstr", interface, "ptr", &GUID)
   result := DllCall("Combase.dll\RoGetActivationFactory", "ptr", hString, "ptr", &GUID, "ptr*", Class, "uint")
   if (result != 0)
   {
      if (result = 0x80004002)
         msgbox No such interface supported
      else if (result = 0x80040154)
         msgbox Class not registered
      else
         msgbox error: %result%
      ExitApp
   }
   DeleteHString(hString)
}

CreateHString(string, ByRef hString)
{
   DllCall("Combase.dll\WindowsCreateString", "wstr", string, "uint", StrLen(string), "ptr*", hString)
}

DeleteHString(hString)
{
   DllCall("Combase.dll\WindowsDeleteString", "ptr", hString)
}

WaitForAsync(ByRef Object)
{
   AsyncInfo := ComObjQuery(Object, IAsyncInfo := "{00000036-0000-0000-C000-000000000046}")
   loop
   {
      DllCall(NumGet(NumGet(AsyncInfo+0)+7*A_PtrSize), "ptr", AsyncInfo, "uint*", status)   ; IAsyncInfo.Status
      if (status != 0)
      {
         if (status != 1)
         {
            DllCall(NumGet(NumGet(AsyncInfo+0)+8*A_PtrSize), "ptr", AsyncInfo, "uint*", ErrorCode)   ; IAsyncInfo.ErrorCode
            msgbox AsyncInfo status error: %ErrorCode%
            ExitApp
         }
         ObjRelease(AsyncInfo)
         break
      }
      sleep 10
   }
   DllCall(NumGet(NumGet(Object+0)+8*A_PtrSize), "ptr", Object, "ptr*", ObjectResult)   ; GetResults
   ObjRelease(Object)
   Object := ObjectResult
}
Showdesktopmon(Monitorid := 1){
	WinGet,WinList,List,,,Program Manager
	List=
	loop,%WinList%{
		winId:=WinList%A_Index%
		WinGetTitle,WinTitle,ahk_id %winId%
		indexm := GetMonitorFromHwnd(winId)
		if (indexm == Monitorid) {
			WinMinimize, % WinTitle
		}
	}
}
activeMonitorInfo()
{ ; retrieves the size of the monitor, the mouse is on
	global Monitornum
	CoordMode, Mouse, Screen
	MouseGetPos, mouseX , mouseY
	SysGet, monCount, MonitorCount
	Loop %monCount%
    { 	SysGet, curMon, Monitor, %a_index%
        if ( mouseX >= curMonLeft and mouseX <= curMonRight and mouseY >= curMonTop and mouseY <= curMonBottom )
            {
				Monitornum := A_Index
				return
			}
    }
}
GetMonitorFromHwnd(winId)
{

	SysGet mCount, MonitorCount
	if (mCount = 1)
	{	; If there is only one monitor, there is only one answer.
		return 1
	}

	if !(monitorHandle := DllCall("User32.dll\MonitorFromWindow", "UInt", winId, "UInt", 2))
	{
		Throw Exception("Error in DllCall - Unable to set monitorHandle.")
	}

	VarSetCapacity(monitorInfo, 40)
	NumPut(40, monitorInfo)
	
	if (SubStr(A_OSVersion, 1, 2) = 10)
	{	;	Windows 10
		DllCall("User32.dll\GetMonitorInfoA", "UInt", monitorHandle, "UInt", &monitorInfo)
	}
	else
	{	;	Not Windows 10
		DllCall("User32.dll\GetMonitorInfo", "UInt", monitorHandle, "UInt", &monitorInfo)
	}
	monitorLeft		:= NumGet(monitorInfo,  4, "Int")
	monitorTop		:= NumGet(monitorInfo,  8, "Int")
	monitorRight	:= NumGet(monitorInfo, 12, "Int")
	monitorBottom	:= NumGet(monitorInfo, 16, "Int")
	Loop %mCount%
	{
		; MonitorGet(A_Index, tempMonLeft, tempMonTop, tempMonRight, tempMonBottom)
		SysGet, tempMon, Monitor, %A_Index%
		/* ; This can be really helpful for debugging purposes to see
		MsgBox, % "monitorLeft:`t"					monitorLeft						"`n"
			. "monitorTop:`t"						monitorTop						"`n"
			. "monitorRight:`t"						monitorRight					"`n"
			. "monitorBottom:`t"					monitorBottom					"`n`n"
			. "workLeft:`t"							workLeft						"`n"
			. "workTop:`t"							workTop							"`n"
			. "workRight:`t"						workRight						"`n"
			. "workBottom:`t"						workBottom						"`n`n"
			. "isPrimary:`t"						isPrimary						"`n`n"
			. "Monitor Number:`t"					A_Index							"`n"
			. "tempMonLeft:`t"						tempMonLeft						"`n"
			. "tempMonTop:`t"						tempMonTop						"`n"
			. "tempMonRight:`t"						tempMonRight					"`n"
			. "tempMonBottom:`t"					tempMonBottom					"`n`n"
			. "monitorLeft = tempMonLeft:`t"		(monitorLeft = tempMonLeft)		"`n"
			. "monitorTop = tempMonTop:`t"			(monitorTop = tempMonTop)		"`n"
			. "monitorRight = tempMonRight:`t"		(monitorRight = tempMonRight)	"`n"
			. "monitorBottom = tempMonBottom:`t" 	(monitorBottom = tempMonBottom)
		*/
		if (monitorLeft = tempMonLeft && monitorTop = tempMonTop && monitorRight = tempMonRight && monitorBottom = tempMonBottom)
		{	;	We found the monitor by matching its bounding rectangle.
			return A_Index
		}
	}
	;	A value is expected.
	return 0
}

bufferToHex(byRef buffer, sizeBytes)
{
	loop % sizeBytes
		s .= Format("{:02X} ", NumGet(&buffer + 0, A_Index - 1, "UChar"))
	return rtrim(s, A_space)
}
Hex2ASCII(fHexString)
{	Loop Parse, fHexString
	NewHexString .= A_LoopField (Mod(A_Index,2) ? "" : ",")
	Loop Parse, NewHexString, `,
		ConvString .= Chr("0x" A_LoopField)
Return ConvString
}	




/*
	#IfWinActive ahk_exe starwarsjedifallenorder.exe
	XButton1::
		Send {1}
	return
	XButton2::
		Send {2}
	return
	PgUp::
		Send {3}
	return
	PgDn::
		Send {m}
	return
	F16::
		Send {[}
	return
	F17::
		Send {]}
	return
	F18::
		Send {. down}
		keywait, F18
		Send {. up}
	return

	#IfWinActive ahk_exe javaw.exe
	XButton1::
		Send {XButton1}
	return
	XButton2::
		Send {XButton2}
	return
	PgUp::
		SetKeyDelay, 50
		Send, //copy
		Send {Enter}
		SetKeyDelay, 0
	return
	PgDn::
		SetKeyDelay, 50
		Send {t}
		Send, //paste
		Send {Enter}
		SetKeyDelay, 0
	return
	F16::
		Send {[}
	return
	F17::
		Send {]}
	return
	F18::
		Send {. down}
		keywait, F18
		Send {. up}
	return
	
	#IfWinActive ahk_exe haloinfinite.exe
	F16::
		Send {[}
	return
	F17::
		Send {]}
	return
	F18::
		Send {Shift}
	return
	PgUp::
		Send {4}
	return
	PgDn::
		Send {x}
	return
	
	#IfWinActive ahk_exe GTA5.exe
	F16::
		Send {\ down}
		keywait, F16
		Send {\ up}
	return
	F17::
		Send {[ down}
		keywait, F17
		Send {[ up}
	return
	F18::
		Send {] down}
		keywait, F18
		Send {] up}
	return
	PgUp::
		Send {m}
	return
	PgDn::
		Send {v}
	return
*/
	#IfWinActive ahk_exe protools.exe
	F16::
		Send {e}
	return
	F17::
		Send {m}
	return
	F18::
		Send {Control down}
		Send {Shift down}
		Send {n}
		Send {Shift up}
		Send {Control up}
	return
	PgUp::
		Send {x}
		Send {p}
		Send {v}
	return
	PgDn::
		Send {x}
		Send ";"
		Send {v}
	return
	XButton1:: 
		Send {-}
	return
	XButton2::
		Send {Del}
	return
	#IfWinActive ahk_exe chrome.exe
	F16::
		Send {Control down}
		Send {Shift down}
		Send {TAB}
		Send {Shift up}
		Send {Control up}
	return
	F17::
		Send {Control down}
		Send {l}
		Send {Control up}
	return
	F18::
		Send {Control down}
		Send {TAB}
		Send {Control up}
	return
	PgUp::
		Send {}
	return
	PgDn::
		Send {}
	return
	XButton1::
		Send {Control down}
		Send {t}
		Send {Control up}
	return
	XButton2::
		Send {Delete}
	return

	#IfWinActive ahk_exe Code.exe
	F16::
		Send {Control down}
		Send {PgUp}
		Send {Control up}
	return
	F17::
		Send {Control down}
		Send {Shift down}
		Send {p}
		Send {Shift up}
		Send {Control up}
	return
	F18::
		Send {Control down}
		Send {PgDn}
		Send {Control up}
	return
	
	#IfWinActive ahk_class SunAwtFrame
	F16::
		Send {Control down}
		Send {PgUp}
		Send {Control up}
	return
	F17::
		Send {Control down}
		Send {Shift down}
		Send {p}
		Send {Shift up}
		Send {Control up}
	return
	F18::
		Send {Control down}
		Send {PgDn}
		Send {Control up}
	return
	#IfWinActive ahk_exe Explorer.EXE
	XButton1::
		Send {F2}
	return
	#IfWinActive ahk_exe teardown.exe
		XButton1::
			Send {XButton1}
		return
		XButton2::
			Send {XButton2}
		return
		PgUp::
			Send {F5}
		return
		PgDn::
			Send {F9}
		return
		F16::
		Send {[ down}
		keywait, F16
		Send {[ up}
	return
	F17::
		Send {] down}
		keywait, F17
		Send {] up}
	return
	F18::
		Send {. down}
		keywait, F18
		Send {. up}
	return
	!right::
		Send {Control down}
		Send {right}
		Send {Control up}
	return
	!left::
		Send {Control down}
		Send {left}
		Send {Control up}
	return
	F1::Send {F1}
	F2::Send {F2}
	F3::Send {F3}
	F4::Send {F4}
	F5::Send {F5}
	;F6::Send {F6}
	F7::Send {F7}
	F8::Send {F8}
	F9::Send {F9}
	F10::Send {F10}
	F11::Send {F11}
	F12::Send {F12}
	#IfWinActive ahk_group MyGroup
	XButton1::
		Send {XButton1 down}
		keywait, XButton1
		Send {XButton1 up}
	return
	XButton2::
		Send {XButton2 down}
		keywait, XButton2
		Send {XButton2 up}
	return
	PgUp::
		Send {PgUp down}
		keywait, PgUp
		Send {PgUp up}
	return
	PgDn::
		Send {PgDn down}
		keywait, PgDn
		Send {PgDn up}
	return
	F16::
		Send {[ down}
		keywait, F16
		Send {[ up}
	return
	F17::
		Send {] down}
		keywait, F17
		Send {] up}
	return
	F18::
		Send {. down}
		keywait, F18
		Send {. up}
	return
	!right::
		Send {Control down}
		Send {right}
		Send {Control up}
	return
	!left::
		Send {Control down}
		Send {left}
		Send {Control up}
	return
	F1::Send {F1}
	F2::Send {F2}
	F3::Send {F3}
	F4::Send {F4}
	F5::Send {F5}
	;F6::Send {F6}
	F7::Send {F7}
	F8::Send {F8}
	F9::Send {F9}
	F10::Send {F10}
	F11::Send {F11}
	F12::Send {F12}


#IfWinActive

/*



`::
	
Return
*/
XButton2::
	Send {Del}
return
F16::
	Send {[ down}
	keywait, F16
	Send {[ up}
return
F17::
	Send {Control down}
	Send {N}
	Send {Control up}
return
F18::
	Send {] down}
	keywait, F18
	Send {] up}
return
!right::
	Send {Control down}
	Send {right}
	Send {Control up}
return
!left::
	Send {Control down}
	Send {left}
	Send {Control up}
return
sc15D::
	FNkey := "true"
	KeyWait, sc15D
	FNkey := "false"
Return
F4::
	if(FNkey == "true"){
		send {F4}
	}
	Else{
		OutputDebug, % FNkey
		send {LWin down}
		Sleep, 9
		Send {h}
		Send {LWin Up}
	}
return
F5::
	if(FNkey == "true"){
		send {F5}
	}
	Else{
		
		send {Media_Next}
	}
return
F6::
	if(FNkey == "true"){
		send {F6}
	}
	Else{
		send {Media_Play_Pause}
	}
return
F7::
	if(FNkey == "true"){
		send {F7}
	}
	Else{
		send {Media_Next}
	}
return
F8::
	if(FNkey == "true"){
		send {F8}
	}
	Else{
		send {LWin down}
		send {tab down}
		Sleep, 10
		send {tab up}
		send {LWin up}
	}
return
F9::
	if(FNkey == "true"){
		send {F9}
	}
	Else{
		send {LWin down}
		send {ctrl down}
		send {Left}
		Sleep, 10
		send {ctrl up}
		send {LWin up}
	}
Return
F10::
	if(FNkey == "true"){
		send {F10}
	}
	Else{
		send {LWin down}
		send {ctrl down}
		send {Right}
		Sleep, 10
		send {ctrl up}
		send {LWin up}
	}
Return
btone(msgNum){
		if (msgNum == 100){
			if (global Layernum == 10)
			{
				if (magloaded == true){
					DllCall("magnification.dll\MagUninitialize")
					magloaded := false
				}
				global Layernum = 11
				SentaCC(117, 11)
			}
			else if (global Layernum == 11)
			{
				if (magloaded == true){
					DllCall("magnification.dll\MagUninitialize")
					magloaded := false
				}
				SentaCC(117, 10)
				global Layernum = 10
			}
			else if (global Layernum == 20)
			{
				if (magloaded == true){
					DllCall("magnification.dll\MagUninitialize")
					magloaded := false
				}
				SentaCC(117, 21)
				global Layernum = 21
			}
			else if (global Layernum == 21)
			{
				if (magloaded == true){
					DllCall("magnification.dll\MagUninitialize")
					magloaded := false
				}
				SentaCC(117, 20)
				global Layernum = 20
			}
		}
		Else{
		
		}
if (msgNum == 1){
OutputDebug, % "thing"
OutputDebug, % Layernum
}

}
bttwo(msgNum){
		if (msgNum > 50){
			if (global Layernum == 20)
			{
				settitlematchmode 2
				winactivate, Discord
			}
			else if (global Layernum == 21)
			{
				settitlematchmode 2
				winactivate, Discord
			}
			else if (global Layernum == 10){
				settitlematchmode 2
				winactivate, Google Chrome
			}

			else if (global Layernum == 11){
				Send {Ctrl Down}{Shift Down}{Esc}{Ctrl Up}{Shift Up}
			}

		}
		Else{
		
		}
}
btthree(msgNum){
	if (msgNum > 50){
		if (global Layernum == 20){
				Run, C:\Users\legoc\Pictures\Screenshots

		}
	
		else if (global Layernum == 21){
				Run, C:\Users\legoc\Pictures\Screenshots

		}

		else if (global Layernum == 10){
				Run, C:\Users\legoc\Pictures\Screenshots
		}

		else if (global Layernum == 11){
				Run, C:\Users\legoc\Pictures\Screenshots
		}
	}
	Else{
		
	}
}
btfour(msgNum){
	if (msgNum > 50){
		if (global Layernum == 20){
			WinGet, hwnd,ID,A  ;get handle of active window 
			filenmae = C:\Users\legoc\Pictures\Screenshots\%A_MM%_%A_DD%_%A_YYYY%_t_%A_Hour%-%A_Min%.%A_Sec%.png
			filedz := filenmae
			pToken:=Gdip_Startup()
			pBitmap:=Gdip_BitmapFromHWND(hwnd)
			Gdip_SaveBitmapToFile(pBitmap, filedz)
			Gdip_DisposeImage(pBitmap)
			Gdip_Shutdown(pToken)
		}
	
		else if (global Layernum == 21){
			WinGet, hwnd,ID,A  ;get handle of active window 
			filenmae = C:\Users\legoc\Pictures\Screenshots\%A_MM%_%A_DD%_%A_YYYY%_t_%A_Hour%-%A_Min%.%A_Sec%.png
			filedz := filenmae
			pToken:=Gdip_Startup()
			pBitmap:=Gdip_BitmapFromHWND(hwnd)
			Gdip_SaveBitmapToFile(pBitmap, filedz)
			Gdip_DisposeImage(pBitmap)
			Gdip_Shutdown(pToken)
		}
		
		else if (global Layernum == 10){
			WinGet, hwnd,ID,A  ;get handle of active window 
			filenmae = C:\Users\legoc\Pictures\Screenshots\%A_MM%_%A_DD%_%A_YYYY%_t_%A_Hour%-%A_Min%.%A_Sec%.png
			filedz := filenmae
			pToken:=Gdip_Startup()
			pBitmap:=Gdip_BitmapFromHWND(hwnd)
			Gdip_SaveBitmapToFile(pBitmap, filedz)
			Gdip_DisposeImage(pBitmap)
			Gdip_Shutdown(pToken)

		}

		else if (global Layernum == 11){
			WinGet, hwnd,ID,A  ;get handle of active window 
			filenmae = C:\Users\legoc\Pictures\Screenshots\%A_MM%_%A_DD%_%A_YYYY%_t_%A_Hour%-%A_Min%.%A_Sec%.png
			filedz := filenmae
			pToken:=Gdip_Startup()
			pBitmap:=Gdip_BitmapFromHWND(hwnd)
			Gdip_SaveBitmapToFile(pBitmap, filedz)
			Gdip_DisposeImage(pBitmap)
			Gdip_Shutdown(pToken)
		}
	}
	Else{
		
	}
}
btfive(msgNum){
		if (msgNum > 50){
			if (global Layernum == 10)
			{
				Showdesktopmon(1)
			}
			else if (global Layernum == 11)
			{
				Showdesktopmon(1)
			}
			else if (global Layernum == 20)
			{
				Showdesktopmon(1)
			}
			else if (global Layernum == 21)
			{
				Showdesktopmon(1)
			}
		}
		Else{
		
		}
}
btsix(msgNum){
		if (msgNum > 50){
			if (global Layernum == 10){
				WinGet, active_id, PID, A
				run, taskkill /PID %active_id% /F,,Hide
			}
			Else if (global Layernum == 11){
				WinGet, active_id, PID, A
				run, taskkill /PID %active_id% /F,,Hide
			}
			Else if (global Layernum == 21){
				WinGet, active_id, PID, A
				run, taskkill /PID %active_id% /F,,Hide
			}
			Else if (global Layernum == 20){
				WinGet, active_id, PID, A
				run, taskkill /PID %active_id% /F,,Hide
			}
		}
		Else{
		
		}
}
btseven(msgNum){
		if (msgNum > 50){
			if (global Layernum == 20){
				DetectHiddenWindows, On
				Process, close, GameBar.exe
				run "C:\Users\legoc\Documents\Xbox Game Bar - Shortcut.lnk"
				DetectHiddenWindows, Off
			}
			if (global Layernum == 21){
				DetectHiddenWindows, On
				Process, close, GameBar.exe
				run "C:\Users\legoc\Documents\Xbox Game Bar - Shortcut.lnk"
				DetectHiddenWindows, Off
			}
			if (global Layernum == 10){
				DetectHiddenWindows, On
				Process, close, GameBar.exe
				DetectHiddenWindows, Off
			}
			if (global Layernum == 11){
				DetectHiddenWindows, On
				Process, close, GameBar.exe
				DetectHiddenWindows, Off
			}
		
		}
		Else{
		
		}
}
bteight(msgNum){
	if (msgNum > 50){
		Phonelined()
	}
	Else{
		Phonelinedoff()
	}
	;msgbox, "ccfor bank change sent"
}
btnine(msgNum){

	if (msgNum > 50){
		Knobdown = true
	}
	Else{
		Knobdown = false
	}
}
btten(msgNum){
	if (msgNum > 50){
		Knobdownt = true
	}
	Else{
		Knobdownt = false
	}
}

Onecw(msgNum){
	if (Knobdown == true)
		Send +{WheelDown}
	Else
		Send +{WheelDown}
		Send +{WheelDown}
}
Twocw(msgNum){
	if (msgNum > 50){
		if (global Layernum == 20)
			if (Knobdownt == true){
				WinGet, active_id, ID, A
				ShiftAppVolume("",+0.05)
				Volumeupordown()
			}
			Else{
				WinGet, active_id, ID, A
				ShiftAppVolume("",+0.10)
				Volumeupordown()
			}
		Else if (global Layernum == 21)
			if (Knobdownt == true){
				WinGet, active_id, ID, A
				ShiftAppVolume("",+0.05)
				Volumeupordown()
			}
			Else{
				WinGet, active_id, ID, A
				ShiftAppVolume("",+0.10)
				Volumeupordown()
			}
		Else if (global Layernum == 10)
			if (Knobdownt == true){
				global Zoomnum
				DetectHiddenWindows, On
				IfWinNotExist, ahk_class MagUIClass
				{
					OutputDebug, "Magnify not found"
					Send {LWin Down} {NumpadAdd} {LWin Up}
					WinWait, ahk_class MagUIClass	
				}
				WinHide, ahk_exe Magnify.exe
				Zoomnum := Zoomnum + 1
				Send ^!{WheelUp}
				DetectHiddenWindows, Off
			}
			Else{
				global Zoomnum
				DetectHiddenWindows, On
				IfWinNotExist, ahk_class MagUIClass
				{
					OutputDebug, "Magnify not found"
					Send {LWin Down} {NumpadAdd} {LWin Up}
					WinWait, ahk_class MagUIClass	
				}
				WinHide, ahk_exe Magnify.exe
				Zoomnum := Zoomnum + 2
				Send ^!{WheelUp}
				Send ^!{WheelUp}
				DetectHiddenWindows, Off
			}
		Else if (global Layernum == 11)
			if (Knobdownt == true){
				WinGet, active_id, ID, A
				ShiftAppVolume("",+0.05)
				Volumeupordown()
			}
			Else{
				WinGet, active_id, ID, A
				ShiftAppVolume("",+0.10)
				Volumeupordown()
			}
	
	}
	Else{
	
	}
}
Oneccw(msgNum){
	if (Knobdown == true)
	{
		Send +{WheelUp}
	}
	Else{
		Send +{WheelUp}
		Send +{WheelUp}
	}
}
Twoccw(msgNum){
		if (msgNum > 50){
			if (global Layernum == 20)
				if (Knobdownt == true){
					WinGet, active_id, ID, A
					ShiftAppVolume("",-0.05)
					Volumeupordown()
				}
				Else{
					WinGet, active_id, ID, A
					ShiftAppVolume("",-0.10)
					Volumeupordown()
				}
			Else if (global Layernum == 21)
				if (Knobdownt == true){
					WinGet, active_id, ID, A
					ShiftAppVolume("",-0.05)
					Volumeupordown()
				}
				Else{
					WinGet, active_id, ID, A
					ShiftAppVolume("",-0.10)
					Volumeupordown()
				}
			Else if (global Layernum == 10)
				if (Knobdownt == true){
					global Zoomnum
					DetectHiddenWindows, On
					IfWinExist, ahk_class MagUIClass
					{
						WinHide, ahk_class MagUIClass
						if (Zoomnum > 0){
							Send ^!{WheelDown}
							Zoomnum := Zoomnum - 1
						}
					}
					DetectHiddenWindows, Off					
				}
				Else{
					global Zoomnum
					DetectHiddenWindows, On
					IfWinExist, ahk_class MagUIClass
					{
						WinHide, ahk_class MagUIClass
						if (Zoomnum > 0){
							Send ^!{WheelDown}
							Send ^!{WheelDown}
							Zoomnum := Zoomnum - 2
						}
					}
					DetectHiddenWindows, Off
				}
			Else if (global Layernum == 11)
				if (Knobdownt == true){
					WinGet, active_id, ID, A
					ShiftAppVolume("",-0.05)
					Volumeupordown()
				}
				Else{
					WinGet, active_id, ID, A
					ShiftAppVolume("",-0.10)
					Volumeupordown()
				}
		
		}
		Else{
		
		}
}
Volumeupordown(){
	filezz = C:\Program Files\AutoHotkey\Lib\volume.png
	ImageX := 50 ;Change "20" to your own needs etc.
	ImageY := 50 ; Same here

	SplashImage, %filezz%, B X%ImageX% Y%ImageY% ,,, volumeupdown ;H%Highh% W%Loww%
	WinSet, Transparent, 150, volumeupdown
	Sleep, 100
	WinSet, Transparent, 100, volumeupdown
	Sleep, 100
	WinSet, Transparent, 50, volumeupdown
	Sleep, 100
	SplashImage, Off
}	


ShiftAppVolume(appName, incr)
{
    if !appName
    {
        WinGet, activePID, ID, A
        WinGet, activeName, ProcessName, ahk_id %activePID%
        appName := activeName        
    }
    
    IMMDeviceEnumerator := ComObjCreate( "{BCDE0395-E52F-467C-8E3D-C4579291692E}", "{A95664D2-9614-4F35-A746-DE8DB63617E6}" )
    DllCall( NumGet( NumGet( IMMDeviceEnumerator+0 ) + 4*A_PtrSize ), "UPtr", IMMDeviceEnumerator, "UInt", 0, "UInt", 1, "UPtrP", IMMDevice, "UInt" )
    ObjRelease(IMMDeviceEnumerator)

    VarSetCapacity( GUID, 16 )
    DllCall( "Ole32.dll\CLSIDFromString", "Str", "{77AA99A0-1BD6-484F-8BC7-2C654C9A9B6F}", "UPtr", &GUID)
    DllCall( NumGet( NumGet( IMMDevice+0 ) + 3*A_PtrSize ), "UPtr", IMMDevice, "UPtr", &GUID, "UInt", 23, "UPtr", 0, "UPtrP", IAudioSessionManager2, "UInt" )

    DllCall( NumGet( NumGet( IAudioSessionManager2+0 ) + 5*A_PtrSize ), "UPtr", IAudioSessionManager2, "UPtrP", IAudioSessionEnumerator, "UInt" )
    ObjRelease( IAudioSessionManager2 )
    
    DllCall( NumGet( NumGet( IAudioSessionEnumerator+0 ) + 3*A_PtrSize ), "UPtr", IAudioSessionEnumerator, "UIntP", SessionCount, "UInt" )
    levels := []
    maxlevel := 0
    targets := []
    t := 0
    ISAVs := []
    Loop % SessionCount
    {
        DllCall( NumGet( NumGet( IAudioSessionEnumerator+0 ) + 4*A_PtrSize ), "UPtr", IAudioSessionEnumerator, "Int", A_Index-1, "UPtrP", IAudioSessionControl, "UInt" )
        IAudioSessionControl2 := ComObjQuery( IAudioSessionControl, "{BFB7FF88-7239-4FC9-8FA2-07C950BE9C6D}" )
        ObjRelease( IAudioSessionControl )
        
        DllCall( NumGet( NumGet( IAudioSessionControl2+0 ) + 14*A_PtrSize ), "UPtr", IAudioSessionControl2, "UIntP", PID, "UInt" )
        
        PHandle := DllCall( "OpenProcess", "uint", 0x0010|0x0400, "Int", false, "UInt", PID )
        if !( ErrorLevel or PHandle == 0 )
        {
            name_size = 1023
            VarSetCapacity( PName, name_size )
            DllCall( "psapi.dll\GetModuleFileNameEx" . ( A_IsUnicode ? "W" : "A" ), "UInt", PHandle, "UInt", 0, "Str", PName, "UInt", name_size )
            DllCall( "CloseHandle", PHandle )
            SplitPath PName, PName
            
            if incr
            {
                t += 1
                
                ISimpleAudioVolume := ComObjQuery(IAudioSessionControl2, "{87CE5498-68D6-44E5-9215-6DA47EF883D8}")
                DllCall( NumGet( NumGet( ISimpleAudioVolume+0 ) + 4*A_PtrSize ), "UPtr", ISimpleAudioVolume, "FloatP", level, "UInt" )  ; Get volume
                
				
                if ( PName == appName )
                {
					if (incr < 0){
						tempin := -1*incr
						
						if (tempin > level){
							level := 0
						}
						else{
							level += incr
						}
					}
					If (incr > 0){
                    	level += incr
					}
                    targets.push( t )
                    DllCall( NumGet( NumGet( ISimpleAudioVolume+0 ) + 5*A_PtrSize ), "UPtr", ISimpleAudioVolume, "Int", 0, "UPtr", 0, "UInt" )  ; Unmute
					ISAVs.push( ISimpleAudioVolume )
					levels.push( level )
                	maxlevel := max( maxlevel, level )
					Break
                }
                
            }
            else
            {
                if ( PName == appName )
                {
                    ISimpleAudioVolume := ComObjQuery(IAudioSessionControl2, "{87CE5498-68D6-44E5-9215-6DA47EF883D8}")
                    DllCall( NumGet( NumGet( ISimpleAudioVolume+0 ) + 6*A_PtrSize ), "UPtr", ISimpleAudioVolume, "IntP", muted )  ; Get mute status
                    maxlevel := maxlevel or muted
                    ISAVs.push( ISimpleAudioVolume )
                }
            }
        }
        ObjRelease(IAudioSessionControl2)
    }
    ObjRelease(IAudioSessionEnumerator)
    
    if incr
    {
        if ( maxlevel == 0.0 ) or ( maxlevel == 1.0 )
        {
            for i, t in targets
                DllCall( NumGet( NumGet( ISAVs[t]+0 ) + 3*A_PtrSize ), "UPtr", ISAVs[t], "Float", levels[t], "UPtr", 0, "UInt" )
				
        }
        else
        {
            VarSetCapacity( GUID, 16 )
            DllCall( "Ole32.dll\CLSIDFromString", "Str", "{5CDF2C82-841E-4546-9722-0CF74078229A}", "UPtr", &GUID)
            DllCall( NumGet( NumGet( IMMDevice+0 ) + 3*A_PtrSize ), "UPtr", IMMDevice, "UPtr", &GUID, "UInt", 7, "UPtr", 0, "UPtrP", IEndpointVolume, "UInt" )
            DllCall( NumGet( NumGet( IEndpointVolume+0 ) + 9*A_PtrSize ), "UPtr", IEndpointVolume, "FloatP", MasterLevel ) ; Get master level
            ;DllCall( NumGet( NumGet( IEndpointVolume+0 ) + 7*A_PtrSize ), "UPtr", IEndpointVolume, "Float", MasterLevel * maxlevel, "UPtr", 0, "UInt" ) ; Set master level
            ObjRelease( IEndpointVolume )
            for i, ISimpleAudioVolume in ISAVs

				DllCall( NumGet( NumGet( ISimpleAudioVolume+0 ) + 3*A_PtrSize ), "UPtr", ISimpleAudioVolume, "Float", min( 1.0, levels[i]) , "UPtr", 0, "UInt" )  ; Set volume
        }        
    }
    else
    {
        for i, ISimpleAudioVolume in ISAVs
            DllCall( NumGet( NumGet( ISimpleAudioVolume+0 ) + 5*A_PtrSize ), "UPtr", ISimpleAudioVolume, "Int", !maxlevel, "UPtr", 0, "UInt" )  ; Toggle mute status
    }
    ObjRelease( IMMDevice )
    for i, ISimpleAudioVolume in ISAVs
        ObjRelease(ISimpleAudioVolume)
}
#Include <Gdip_All>
#Include <VA>
#Include <Generic_midi_App_ 07>
#Include <MidiRules>
#Include <hotkeyTOmidi_2>
#include <mio2>