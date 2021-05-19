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
  Protected.RARGetDllVersionFunc pFuncCall
  
  If IsLibrary(dllInstance)
    pFuncCall = GetFunction(dllInstance, "RARGetDllVersion")
    ProcedureReturn pFuncCall()
  EndIf
  
  ProcedureReturn 0
EndProcedure
; IDE Options = PureBasic 5.72 (Windows - x86)
; CursorPosition = 3
; Folding = -
; EnableXP
