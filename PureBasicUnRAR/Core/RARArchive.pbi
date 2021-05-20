;--------------------------------------------------------------------------------------------
;  Copyright (c) Ji-Feng Tsai. All rights reserved.
;  Code released under the MIT license.
;--------------------------------------------------------------------------------------------

; Prototype Function

Prototype.l RAROpenArchiveExFunc(*ArchiveData.RAROpenArchiveDataEx)
Prototype.l RARReadHeaderExFunc(hArcData.l, *HeaderData.RARHeaderDataEx)
Prototype.l RARProcessFileWFunc(hArcData.l, Operation.l, DestPath.p-unicode, DestName.p-unicode)
Prototype RARSetCallbackFunc(hArcData.l, *UnRARCallback.UnRARCallbackProc, UserData.l)
Prototype RARSetPasswordFunc(hArcData.l, Password.p-utf8)
Prototype.l RARCloseArchiveFunc(hArcData.l)

; UnRAR Function Declare

; <summary>
; RAROpenArchiveEx
; </summary>
; <param name="dllInstance"></param>
; <param name="*ArchiveData"></param>
; <returns>Returns long.</returns>
Procedure.l RAROpenArchiveEx(dllInstance.i, *ArchiveData.RAROpenArchiveDataEx)
  Protected.i lResult
  Protected.RAROpenArchiveExFunc pFuncCall
  
  If IsLibrary(dllInstance)
    pFuncCall = GetFunction(dllInstance, "RAROpenArchiveEx")
    lResult = pFuncCall(*ArchiveData)
  EndIf
    
  ProcedureReturn lResult
EndProcedure

; <summary>
; RARReadHeaderEx
; </summary>
; <param name="dllInstance"></param>
; <param name="hArcData"></param>
; <param name="*HeaderData"></param>
; <returns>Returns long.</returns>
Procedure.l RARReadHeaderEx(dllInstance.i, hArcData.l, *HeaderData.RARHeaderDataEx)
  Protected.i lResult
  Protected.RARReadHeaderExFunc pFuncCall
  
  If IsLibrary(dllInstance)
    pFuncCall = GetFunction(dllInstance, "RARReadHeaderEx")
    lResult = pFuncCall(hArcData, *HeaderData)
  EndIf
    
  ProcedureReturn lResult
EndProcedure

; <summary>
; RARProcessFileW
; </summary>
; <param name="dllInstance"></param>
; <param name="hArcData"></param>
; <param name="Operation"></param>
; <param name="DestPath"></param>
; <param name="DestName"></param>
; <returns>Returns long.</returns>
Procedure.l RARProcessFileW(dllInstance.i, hArcData.l, Operation.l, DestPath.s, DestName.s)
  Protected.i lResult
  Protected.RARProcessFileWFunc pFuncCall
  
  If IsLibrary(dllInstance)
    pFuncCall = GetFunction(dllInstance, "RARProcessFileW")
    lResult = pFuncCall(hArcData, Operation, DestPath, DestName)
  EndIf
    
  ProcedureReturn lResult
EndProcedure

; <summary>
; RARSetCallback
; </summary>
; <param name="dllInstance"></param>
; <param name="hArcData"></param>
; <param name="*UnRARCallback"></param>
; <param name="UserData"></param>
; <returns>Returns long.</returns>
Procedure.l RARSetCallback(dllInstance.i, hArcData.l, *UnRARCallback.UnRARCallbackProc, UserData.l)
  Protected.i lResult
  Protected.RARSetCallbackFunc pFuncCall
  
  If IsLibrary(dllInstance)
    pFuncCall = GetFunction(dllInstance, "RARSetCallback")
    lResult = pFuncCall(hArcData, *UnRARCallback, UserData)
  EndIf
    
  ProcedureReturn lResult
EndProcedure

; <summary>
; RARSetPassword
; </summary>
; <param name="dllInstance"></param>
; <param name="hArcData"></param>
; <param name="Password"></param>
; <returns>Returns void.</returns>
Procedure RARSetPassword(dllInstance.i, hArcData.l, Password.s)
  Protected.l lResult
  Protected.RARSetPasswordFunc pFuncCall
  
  If IsLibrary(dllInstance)
    pFuncCall = GetFunction(dllInstance, "RARSetPassword")
    lResult = pFuncCall(hArcData, Password)
  EndIf
  
  ProcedureReturn lResult
EndProcedure

; <summary>
; RARCloseArchive
; </summary>
; <param name="dllInstance"></param>
; <param name="hArcData"></param>
; <returns>Returns long.</returns>
Procedure.l RARCloseArchive(dllInstance.i, hArcData.l)
  Protected.l lResult
  Protected.RARCloseArchiveFunc pFuncCall
  
  If IsLibrary(dllInstance)
    pFuncCall = GetFunction(dllInstance, "RARCloseArchive")
    lResult = pFuncCall(hArcData)
  EndIf
  
  ProcedureReturn lResult
EndProcedure
; IDE Options = PureBasic 5.72 (Windows - x86)
; CursorPosition = 5
; Folding = --
; EnableXP
; IncludeVersionInfo
; VersionField2 = Inwazy Technology
; VersionField3 = PureBasicUnRAR
; VersionField4 = 1.0.0