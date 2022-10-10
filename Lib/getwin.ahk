GetMonitorFromHwnd(winId)
{
	/*
	This is optional code. Commenting out due to the fact that it's probably better to make sure that winId references a valid window before calling this function.
	if !WinExist("ahk_id " . winId) {
		return false
	}
	else if (!RegExMatch(winId, Runtime.hwnd_regex)) {
		Throw Exception("Invalid window id passed: " . winId)
	}
	*/
	SysGet mCount, MonitorCount
	if (mCount = 1)
	{	; If there is only one monitor, there is only one answer.
		return 1
	}
	
	/*
		Refer to microsoft documentation for user32.dll method MonitorFromWindow
		https://docs.microsoft.com/en-us/windows/win32/api/winuser/nf-winuser-monitorfromwindow
		MONITOR_DEFAULTTONULL = 0
		MONITOR_DEFAULTTOPRIMARY = 1
		MONITOR_DEFAULTTONEAREST = 2
	*/
	if !(monitorHandle := DllCall("User32.dll\MonitorFromWindow", "UInt", winId, "UInt", 2))
	{
		Throw Exception("Error in DllCall - Unable to set monitorHandle.")
	}
	/*
		Refer to microsoft documentation for user32.dll method GetMonitorInfo
		https://docs.microsoft.com/en-us/windows/desktop/api/winuser/nf-winuser-getmonitorinfoa
		BOOL GetMonitorInfoA(
		  HMONITOR	  hMonitor,
		  LPMONITORINFO lpmi
		);
	*/
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
	;	Even for debugging purposes this isn't very helpful. I'm pretty sure it's just a pointer to monitorInfo.
	;monitorZero		:= NumGet(monitorInfo,  0, "Int")
	;	Create a bounding rectangle
	monitorLeft		:= NumGet(monitorInfo,  4, "Int")
	monitorTop		:= NumGet(monitorInfo,  8, "Int")
	monitorRight	:= NumGet(monitorInfo, 12, "Int")
	monitorBottom	:= NumGet(monitorInfo, 16, "Int")
	/*
	; 	These point to the dimensions of the monitor with the taskbar taken out.
	workLeft	:= NumGet(monitorInfo, 20, "Int")
	workTop		:= NumGet(monitorInfo, 24, "Int")
	workRight	:= NumGet(monitorInfo, 28, "Int")
	workBottom	:= NumGet(monitorInfo, 32, "Int")
	;	If this is the primary monitor (the monitor with all your desktop icons) this should be 1.
	isPrimary	:= NumGet(monitorInfo, 36, "Int") ; & 1
	*/
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
