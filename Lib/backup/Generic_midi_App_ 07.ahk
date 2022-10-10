
Runmidisetup(){
  
  SetWorkingDir %A_ScriptDir%       	                                ; Ensures a consistent starting directory.
  readini() 
  MidiPortRefresh()                  ; used to refresh the input and output port lists - see Midi_In_Out_Lib.ahk file
  ;port_test(12,13)   ; 12 in 13 out (minus one?) port_test(numports,numports2) 
  midiin_go()                            ; opens the midi input port listening routine see Midi_In_Out_Lib.ahk file
  midiout()                               ; opens the midi out port see Midi_In_Out_Lib.ahk file 
  channel = 2        ; default channel =1
  CC_num = 7         ; CC 
  CCIntVal = 0       ; Default zero for  CC  (data byte 2)
  CCIntDelta = 1     ; Amount to change CC (data byte 2)
}
/*


RelayCC: ; ===============THIS FOR RELAYING CC'S OR TRANSLATING MIDI CC'S
   stb := "CC"                                                                                               ; Only used in the midi display - has nothing to do with message output    
   ;MidiOutDisplay(stb, statusbyte, chan , CC_num, data2)                      ; update the midimonitor gui
   midiOutShortMsg(h_midiout, (Channel+175), CC_num, CCIntVal)   ; SEND OUT THE MESSAGE > function located in Midi_In_Out_Lib.ahk;MsgBox, 0, ,sendcc triggered , 1 ; for testing purposes only
 Return
*/
SendCC(){ ; ===============use this for converting keypress into midi message
  midiOutShortMsg(h_midiout, (Channel+175), CC_num, CCIntVal) ; SEND OUT THE MESSAGE > function located in Midi_In_Out_Lib.ahk
  ; =============== set vars for display only ;  get these to be the same vars as midi send messages
  stb := "CC" 
  statusbyte := (Channel+174)
  data1 = %CC_num%			; set value of the data1 to the above cc_num for display on the midi out window (only needed if you want to see output)	
  data2 = %CCIntVal%	    
  ;MidiOutDisplay(stb, statusbyte, channel, data1, data2) ; ; update the midimonitor gui
  ;MsgBox, 0, ,sendcc triggered , 1 ; for testing purposes only
Return
}
/*
RelayNote:   ;(h_midiout,Note) ; send out note messages ; this should probably be a funciton but... eh
  midiOutShortMsg(h_midiout, statusbyte, data1, data2) ; call the midi funcitons with these params.
  stb := "NoteOn"
 ; MidiOutDisplay(stb, statusbyte, chan, data1, data2)
Return
*/
SendNote(){   ;(h_midiout,Note) ; send out note messages ; this should probably be a funciton but... eh
  note = %data1%                                      ; this var is added to allow transpostion of a note
  vel = %data2%
  midiOutShortMsg(h_midiout, statusbyte, note, vel) ; call the midi funcitons with these params.
    stb := "NoteOn"
    statusbyte := 144
    chan 	= %channel%
    data1 = %Note%			; set value of the data1 to the above cc_num for display on the midi out window (only needed if you want to see output)	
    data2 = %Vel%	
    ;MidiOutDisplay(stb, statusbyte, chan, data1, data2)
Return
}

SendPC(){ ; Send a progam change message - data2 is ignored - I think...
    midiOutShortMsg(h_midiout, (Channel+191), pc, data2)
    stb := "PC"
    statusbyte := 192
    chan 	= %channel%
    data1 = %PC%			; set value of the data1 to the above cc_num for display on the midi out window (only needed if you want to see output)	
    data2 = 
    ;MidiOutDisplay(stb, statusbyte, chan, data1, data2)
Return
}
/* 
   Method could be developed for other midi messages like after touch...etc.
 */
;*************************************************
;*              INCLUDE FILES -
;*  these files need to be in the same folder
;*************************************************
;#Include MidiRules.ahk              ; this file contains: Rules for manipulating midi input then sending modified midi output.
;#Include hotkeyTOmidi_1.ahk         ; this file contains: examples of HOTKEY generated midi messages to be output - the easy way!
;#Include hotkeyTOmidi_2.ahk         ; this file contains: examples of HOTKEY generated midi messages to be output - the BEST way!
;#include joystuff.ahk              ; this file contains: joystick stuff.   
;#include xy_mouse.ahk
;#Include mio2.ahk       ; this file replaced the midi in out lib below - for now