MidiRules(){
  OutputDebug, % "Midirules"
  if statusbyte between 144 and 159
  { ; detect if note message is "note on"
    MsgBox, "note on"

  }    

  if statusbyte between 128 and 143
  {   ;detect if note message is "note off"

  } 
  if statusbyte between 176 and 191 ; check status byte for cc 176-191 is the range for CC messages
  {
    
    CC_num := data1
    if (CC_num = 102){
      btone(%data2%)
    }
    if (CC_num = 103){
      bttwo(%data2%)
    }
    if (CC_num = 104){
      btthree(%data2%)
    }
    if (CC_num = 105){
      btfour(%data2%)
    }
    if (CC_num = 106){
      btfive(%data2%)
    }
    if (CC_num = 107){
      btsix(%data2%)
    }
    if (CC_num = 108){
      btseven(%data2%)
    }
    if (CC_num = 109){
      bteight(%data2%)
    }
    if (CC_num = 110){
      btnine(%data2%)
    }
    if (CC_num = 111){
      btten(%data2%)
    }
    if (CC_num = 112){
      Onecw(%data2%)
    }
    if (CC_num = 113){
      Twocw(%data2%)
    }
    if (CC_num = 114){
      Oneccw(%data2%)
    }
    if (CC_num = 115){
      Twoccw(%data2%)
    }
    ;return
  }
  if statusbyte between 192 and 208  ; check if message is in range of program change messages for data1 values. ; !!!!!!!!!!!! no edit
  {
  }



Return
}







