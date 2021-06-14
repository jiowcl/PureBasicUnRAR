;--------------------------------------------------------------------------------------------
;  Copyright (c) Ji-Feng Tsai. All rights reserved.
;  Code released under the MIT license.
;--------------------------------------------------------------------------------------------

; Prototype Function
Prototype.i RARGetDllVersionFunc()

; <summary>
; RARGetDllVersion
; </summary>
; <param name="dllInstance"></param>
; <returns>Returns integer.</returns>
Procedure.i RARGetDllVersion(dllInstance.i)
  Protected.i lResult
  Protected.RARGetDllVersionFunc pFuncCall
  
  If IsLibrary(dllInstance)
    pFuncCall = GetFunction(dllInstance, "RARGetDllVersion")
    
    If pFuncCall > 0
      lResult = pFuncCall()
    EndIf  
  EndIf
  
  ProcedureReturn lResult
EndProcedure
; IDE Options = PureBasic 5.72 (Windows - x86)
; CursorPosition = 25
; Folding = -
; EnableXP