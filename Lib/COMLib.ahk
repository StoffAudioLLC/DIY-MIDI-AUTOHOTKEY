/*Loop{
  
	data := Read_from_COM(128)
	MsgBox, data
	word_array := StrSplit(data, "|")
	comint := 0
	Loop, word_array.Length()
	{
		tempword := word_array[%comint%]
		If InStr(tempword, "D:")
			If InStr(tempword, "-")
			Knobccw()
		Else
			Knobcw()
		If InStr(tempword, "B")
			Buttonone()
		comint = comint + 1
	}
}
*/
;########################################################################
;######    Hex2ASCII              #######################################
;########################################################################

Hex2ASCII(fHexString)
{	Loop Parse, fHexString
	NewHexString .= A_LoopField (Mod(A_Index,2) ? "" : ",")
	Loop Parse, NewHexString, `,
		ConvString .= Chr("0x" A_LoopField)
Return ConvString
}	

;########################################################################
;###### Convert HEX               #######################################
;########################################################################

hex2str(string)
{
	if !(DllCall("crypt32\CryptStringToBinary", "ptr", &string, "uint", 0, "uint", 0x4, "ptr", 0, "uint*", size, "ptr", 0, "ptr", 0))
		throw Exception("CryptStringToBinary failed", -1)
	VarSetCapacity(buf, size, 0)
	if !(DllCall("crypt32\CryptStringToBinary", "ptr", &string, "uint", 0, "uint", 0x4, "ptr", &buf, "uint*", size, "ptr", 0, "ptr", 0))
		throw Exception("CryptStringToBinary failed", -1)
return StrGet(&buf, size, "UTF-8")
}
;COM_Port := 20 ; Arduno nano
COM_Port := 3 ; STM32F1 BluePill

Serial := new _Serial_(COM_Port)
SetTimer,blinking,1000
return

blinking:
	Serial.uchar := 111 ; only 111 command will toggle led so ahk to uC transmission is working fine
return

;f4::reload
esc::exitapp

OnSerial(cnt,Serial){
	tt := cnt
	loop,% cnt{
		val := Serial.uchar
		tt .= chr(val)
	}
	tooltip,% tt
  
}

class _Serial_
{
	__new(_port){
		Port   := "COM" _port
		Baud   := 9600
		Parity := "N"
		Data   := 8
		Stop   := 1
		Settings = %Port%:baud=%Baud% parity=%Parity% data=%Data% stop=%Stop% dtr=on
		this.Settings := Settings
		this.handle := this.Initialize(Settings)
		this.FIFO := new _FIFO_0(1024*16)
		this.tBuffer := tBuffer := ObjBindMethod(this, "Buffer")
		SetTimer,% tBuffer, 10
	}
	
	Initialize(SERIAL_Settings){
		
		
		;###### Extract/Format the COM Port Number ######
		StringSplit, SERIAL_Port_Temp, SERIAL_Settings, `:
		SERIAL_Port_Temp1_Len := StrLen(SERIAL_Port_Temp1)  ;For COM Ports > 9 \\.\ needs to prepended to the COM Port name.
		If (SERIAL_Port_Temp1_Len > 4)                   ;So the valid names are
			SERIAL_Port = \\.\%SERIAL_Port_Temp1%             ; ... COM8  COM9   \\.\COM10  \\.\COM11  \\.\COM12 and so on...
		Else                                          ;
			SERIAL_Port = %SERIAL_Port_Temp1%
		;MsgBox, SERIAL_Port=%SERIAL_Port%
		
		
		;StringTrimLeft, SERIAL_Settings, SERIAL_Settings, SERIAL_Port_Temp1_Len+1 ;Remove the COM number (+1 for the semicolon) for BuildCommDCB.
		;MsgBox, Port=%SERIAL_Port% `nSERIAL_Settings=%SERIAL_Settings%
		;msgbox,% SERIAL_Settings
		;###### Build COM DCB ######
		;Creates the structure that contains the COM Port number, baud rate,...
		VarSetCapacity(DCB, 28)
		BCD_Result := DllCall("BuildCommDCB"
			,"str" , SERIAL_Settings ;lpDef
			,"UInt", &DCB)           ;lpDCB
		If (BCD_Result <> 1){
			error := DllCall("GetLastError")
			MsgBox, There is a problem with Serial Port communication. `nFailed Dll BuildCommDCB, BCD_Result=%BCD_Result% `nLasterror=%error%`nThe Script Will Now Exit.
			;ExitApp
			;return
		}
		;return
		;###### Create COM File ######
		;Creates the COM Port File Handle
		;StringLeft, SERIAL_Port, SERIAL_Settings, 4  ; 7/23/08 This line is replaced by the "Extract/Format the COM Port Number" section above.
		;msgbox,% SERIAL_Port
		SERIAL_FileHandle := DllCall("CreateFile"
			,"Str" , SERIAL_Port  ;File Name
			,"UInt", 0xC0000000   ;Desired Access
			,"UInt", 3            ;Safe Mode
			,"UInt", 0            ;Security Attributes
			,"UInt", 3            ;Creation Disposition TODO: TRUNCATE_EXISTING?
			,"UInt", 0            ;Flags And Attributes
			,"UInt", 0            ;Template File
			,"Cdecl Int")
		If (SERIAL_FileHandle < 1){
			error := DllCall("GetLastError")
			MsgBox, There is a problem with Serial Port communication. `nFailed Dll CreateFile, SERIAL_FileHandle=%SERIAL_FileHandle% `nLasterror=%error%`nThe Script Will Now Exit.
			;ExitApp
			return
		}
		
		;###### Set COM State ######
		;Sets the COM Port number, baud rate,...
		SCS_Result := DllCall("SetCommState"
			,"UInt", SERIAL_FileHandle ;File Handle
			,"UInt", &DCB)          ;Pointer to DCB structure
		If (SCS_Result <> 1){
			error := DllCall("GetLastError")
			MsgBox, There is a problem with Serial Port communication. `nFailed Dll SetCommState, SCS_Result=%SCS_Result% `nLasterror=%error%`nThe Script Will Now Exit.
			this.Serial_Close(SERIAL_FileHandle)
			;ExitApp
			return
		}
		
		;###### Create the SetCommTimeouts Structure ######
		ReadIntervalTimeout        = 0xffffffff
		ReadTotalTimeoutMultiplier = 0x00000000
		ReadTotalTimeoutConstant   = 0x00000000
		WriteTotalTimeoutMultiplier= 0x00000000
		WriteTotalTimeoutConstant  = 0x00000000
		
		VarSetCapacity(Data, 20, 0) ; 5 * sizeof(DWORD)
		NumPut(ReadIntervalTimeout,         Data,  0, "UInt")
		NumPut(ReadTotalTimeoutMultiplier,  Data,  4, "UInt")
		NumPut(ReadTotalTimeoutConstant,    Data,  8, "UInt")
		NumPut(WriteTotalTimeoutMultiplier, Data, 12, "UInt")
		NumPut(WriteTotalTimeoutConstant,   Data, 16, "UInt")
		
		;###### Set the COM Timeouts ######
		SCT_result := DllCall("SetCommTimeouts"
			,"UInt", SERIAL_FileHandle ;File Handle
			,"UInt", &Data)         ;Pointer to the data structure
		If (SCT_result <> 1){
			error := DllCall("GetLastError")
			MsgBox, There is a problem with Serial Port communication. `nFailed Dll SetCommState, SCT_result=%SCT_result% `nLasterror=%error%`nThe Script Will Now Exit.
			this.Serial_Close(SERIAL_FileHandle)
			;ExitApp
			return
		}
		
		Return SERIAL_FileHandle
	}
	
	Serial_Close(SERIAL_FileHandle){
	  ;###### Close the COM File ######
	  CH_result := DllCall("CloseHandle", "UInt", SERIAL_FileHandle)
	  If (CH_result <> 1)
	    MsgBox, Failed Dll CloseHandle CH_result=%CH_result%
	  Return
	}
	
	
	Close(){ ; why not called on destroy
		;###### Close the COM File ######
		;msgbox, close
		tBuffer := this.tBuffer
		SetTimer,% tBuffer, Off
		CH_result := DllCall("CloseHandle", "UInt", this.handle)
		If (CH_result <> 1)
			MsgBox, Failed Dll CloseHandle CH_result=%CH_result%
		Return
	}
	
	Enable(){
		this.Initialize(this.Settings)
		tBuffer := this.tBuffer
		SetTimer,% tBuffer, 0
	}
	Disable(){
		this.Close()
	}
	Clear(){
		this.read(buf,1024)
		this.FIFO := new _FIFO_0(1024*16)
	}
	
	Buffer(){
		bytes := this.Read(buf,1024)
		if bytes
		;tooltip,% bytes
		if (bytes>0){
			this.FIFO.PushA(buf,bytes)
			OnSerial(bytes,this)
		}
			
	}
	
	Read(ByRef buf, len){
		;tooltip,% len
		;###### Read the data from the COM Port ######
		VarSetCapacity(buf, len, 0)
		dll := DllCall("ReadFile"
			,"UInt" , this.handle    ; hFile
			,"Ptr"  , &buf           ; lpBuffer
			,"Int"  , len            ; nNumberOfBytesToRead
			,"UInt*", Bytes_Received ; lpNumberOfBytesReceived
			,"Int"  , 0)             ; lpOverlapped
		;if (Bytes_Received)
		;tooltip,% this.handle "`n" Bytes_Received "`n" len "`n`n" dll
		return Bytes_Received
	}
	
	Write(ByRef buf, len){
		;tooltip,% len 
		;###### Write the data to the COM Port ######
		DllCall("WriteFile"
			,"UInt" , this.handle  ;File Handle
			,"Ptr"  , &buf         ;Pointer to string to send
			,"UInt" , len          ;Data Length
			,"UInt*", Bytes_Sent   ;Returns pointer to num bytes sent
			,"Int"  , "NULL")
			;tooltip,% Bytes_Sent
		Return Bytes_Sent
	}
	
	available(){
		return this.FIFO.s
	}
	
	waitForData(n,timeout=200){
		cnt := 0
		while(this.available()<n){
			cnt+=10
			sleep 10
			if (cnt>timeout) 
				return -1
			;tooltip,% cnt
		}
		return cnt
	}
	__Get(type){
		static sizeof := {char:1,uchar:1,short:2,ushort:2
			,int:4,uint:4,float:4,double:8,int64:8}
		s := sizeof[type]
		if (s>0){
			while(this.FIFO.s<s){ ; TODO: timeout
				sleep 10
				;tooltip,% A_TickCount "`n" type
			}
			VarSetCapacity(buf, s)
			loop,% s
				NumPut(this.FIFO.Pop(), buf,  (A_Index-1), "uchar")
			return NumGet(buf,type)
		}
		; TODO: Serial.string
	}
	
	__Set(type,a){
		static sizeof := {char:1,uchar:1,short:2,ushort:2
			,int:4,uint:4,float:4,double:8,int64:8}
		s := sizeof[type]
		if (s>0){
			if (IsObject(a)){
				len := a.MaxIndex()*s
				VarSetCapacity(buf, len)
				for k,v in a
					NumPut(v, buf,  (k-1)*s, type)
			}
			else{
				len := s
				VarSetCapacity(buf, len)
				NumPut(a, Buf,  0, type)
			}
			this.Write(buf,len)
			return
		}
		; TODO: Serial.string := "text"
	}
}

class _FIFO_0
{
	buf := {}
	size := 0
	p := 1
	k := 1
	s := 0
	o := 0
	__new(_size){
		this.size := _size
	}
	
	incP(){
		this.p := (this.p==this.size) ? 1 : this.p+1
	}
	
	incK(){
		this.k := (this.k==this.size) ? 1 : this.k+1
	}
	incS(){
		this.s++
		if (this.s>this.size)
		{
			;tooltip,% A_TickCount "`n" "OverFlow",0,,10
			;SetTimer, tt10, 2000
			this.o := 1
			this.s := this.size
			this.p := this.k
		}
	}
	decS(){
		this.s--
		if (this.s<0)
			msgbox, ze co kurwa?
	}
	
	
	PushA(ByRef DATA, n){
		
		loop,%n%
			this.Push(numget(DATA,A_Index-1,"uchar"))
	}
	Push(val){
		this.buf[this.k] := val
		this.incK()
		this.incS()
	}
	Pop(){
		val := this.buf[this.p]
		this.incP()
		this.decS()
		this.o := 0
		return val
	}
	flush(){
		val := this.buf[this.p]
		return val
	}
}
Buttonone(){
	MsgBox, "Button"
}
Knobcw(){

}
Knobccw(){

}