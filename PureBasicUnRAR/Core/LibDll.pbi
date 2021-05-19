;--------------------------------------------------------------------------------------------
;  Copyright (c) Ji-Feng Tsai. All rights reserved.
;  Code released under the MIT license.
;--------------------------------------------------------------------------------------------

; Function Declare
Declare.i UnRARDllOpen(lpszDllPath.s)
Declare.i UnRARDllClose(dllInstance.i)

; <summary>
; UnRARDllOpen
; </summary>
; <param name="lpszDllPath"></param>
; <returns>Returns integer.</returns>
Procedure.i UnRARDllOpen(lpszDllPath.s)
  ProcedureReturn OpenLibrary(#PB_Any, lpszDllPath)
EndProcedure

; <summary>
; UnRARDllClose
; </summary>
; <param name="dllInstance"></param>
; <returns>Returns integer.</returns>
Procedure.i UnRARDllClose(dllInstance.i)
  If IsLibrary(dllInstance)
    CloseLibrary(dllInstance)
  EndIf
  
  ProcedureReturn #True
EndProcedure
; IDE Options = PureBasic 5.72 (Windows - x86)
; CursorPosition = 3
; Folding = -
; EnableXP
; IncludeVersionInfo
; VersionField2 = Inwazy Technology
; VersionField3 = PureBasicUnRAR
; VersionField4 = 1.0.0
