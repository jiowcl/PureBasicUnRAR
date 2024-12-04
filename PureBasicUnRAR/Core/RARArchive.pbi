;--------------------------------------------------------------------------------------------
;  Copyright (c) Ji-Feng Tsai. All rights reserved.
;  Code released under the MIT license.
;--------------------------------------------------------------------------------------------

; Prototype Function

Prototype.i RAROpenArchiveFunc(*ArchiveData.RAROpenArchiveData)
Prototype.i RAROpenArchiveExFunc(*ArchiveData.RAROpenArchiveDataEx)
Prototype.i RARReadHeaderFunc(hArcData.i, *HeaderData.RARHeaderData)
Prototype.i RARReadHeaderExFunc(hArcData.i, *HeaderData.RARHeaderDataEx)
Prototype.i RARProcessFileFunc(hArcData.i, Operation.l, DestPath.p-ascii, DestName.p-ascii)
Prototype.i RARProcessFileWFunc(hArcData.i, Operation.l, DestPath.p-unicode, DestName.p-unicode)
Prototype RARSetCallbackFunc(hArcData.i, *UnRARCallback.UnRARCallbackProc, UserData.l)
Prototype RARSetChangeVolProcFunc(hArcData.i, *ChangeVolProc.UnRARChangeVolProc)
Prototype RARSetProcessDataProcFunc(hArcData.i, *ProcessDataProc.UnRARProcessDataProc)
Prototype RARSetPasswordFunc(hArcData.i, Password.p-ascii)
Prototype.i RARCloseArchiveFunc(hArcData.i)

; UnRAR Function Declare

; <summary>
; RAROpenArchive
; </summary>
; <param name="dllInstance"></param>
; <param name="*ArchiveData"></param>
; <returns>Returns long.</returns>
Procedure.i RAROpenArchive(dllInstance.i, *ArchiveData.RAROpenArchiveData)
  Protected.i lResult
  Protected.RAROpenArchiveFunc pFuncCall
  
  If IsLibrary(dllInstance)
    pFuncCall = GetFunction(dllInstance, "RAROpenArchive")
    
    If pFuncCall > 0
      lResult = pFuncCall(*ArchiveData)
    EndIf  
  EndIf
    
  ProcedureReturn lResult
EndProcedure

; <summary>
; RAROpenArchiveEx
; </summary>
; <param name="dllInstance"></param>
; <param name="*ArchiveData"></param>
; <returns>Returns long.</returns>
Procedure.i RAROpenArchiveEx(dllInstance.i, *ArchiveData.RAROpenArchiveDataEx)
  Protected.i lResult
  Protected.RAROpenArchiveExFunc pFuncCall
  
  If IsLibrary(dllInstance)
    pFuncCall = GetFunction(dllInstance, "RAROpenArchiveEx")
    
    If pFuncCall > 0
      lResult = pFuncCall(*ArchiveData)
    EndIf  
  EndIf
    
  ProcedureReturn lResult
EndProcedure

; <summary>
; RARReadHeader
; </summary>
; <param name="dllInstance"></param>
; <param name="hArcData"></param>
; <param name="*HeaderData"></param>
; <returns>Returns long.</returns>
Procedure.i RARReadHeader(dllInstance.i, hArcData.i, *HeaderData.RARHeaderData)
  Protected.i lResult
  Protected.RARReadHeaderFunc pFuncCall
  
  If IsLibrary(dllInstance)
    pFuncCall = GetFunction(dllInstance, "RARReadHeader")
    
    If pFuncCall > 0
      lResult = pFuncCall(hArcData, *HeaderData)
    EndIf  
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
Procedure.i RARReadHeaderEx(dllInstance.i, hArcData.i, *HeaderData.RARHeaderDataEx)
  Protected.i lResult
  Protected.RARReadHeaderExFunc pFuncCall
  
  If IsLibrary(dllInstance)
    pFuncCall = GetFunction(dllInstance, "RARReadHeaderEx")
    
    If pFuncCall > 0
      lResult = pFuncCall(hArcData, *HeaderData)
    EndIf  
  EndIf
    
  ProcedureReturn lResult
EndProcedure

; <summary>
; RARProcessFile
; </summary>
; <param name="dllInstance"></param>
; <param name="hArcData"></param>
; <param name="Operation"></param>
; <param name="DestPath"></param>
; <param name="DestName"></param>
; <returns>Returns long.</returns>
Procedure.i RARProcessFile(dllInstance.i, hArcData.i, Operation.l, DestPath.s, DestName.s)
  Protected.i lResult
  Protected.RARProcessFileFunc pFuncCall
  
  If IsLibrary(dllInstance)
    pFuncCall = GetFunction(dllInstance, "RARProcessFile")
    
    If pFuncCall > 0
      lResult = pFuncCall(hArcData, Operation, DestPath, DestName)
    EndIf  
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
Procedure.i RARProcessFileW(dllInstance.i, hArcData.i, Operation.l, DestPath.s, DestName.s)
  Protected.i lResult
  Protected.RARProcessFileWFunc pFuncCall
  
  If IsLibrary(dllInstance)
    pFuncCall = GetFunction(dllInstance, "RARProcessFileW")
    
    If pFuncCall > 0
      lResult = pFuncCall(hArcData, Operation, DestPath, DestName)
    EndIf  
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
; <returns>Returns void.</returns>
Procedure RARSetCallback(dllInstance.i, hArcData.i, *UnRARCallback.UnRARCallbackProc, UserData.l)
  Protected.RARSetCallbackFunc pFuncCall
  
  If IsLibrary(dllInstance)
    pFuncCall = GetFunction(dllInstance, "RARSetCallback")
    
    If pFuncCall > 0
      pFuncCall(hArcData, *UnRARCallback, UserData)
    EndIf  
  EndIf
EndProcedure

; <summary>
; RARSetChangeVolProc
; </summary>
; <param name="dllInstance"></param>
; <param name="hArcData"></param>
; <param name="*ChangeVolProc"></param>
; <returns>Returns void.</returns>
Procedure RARSetChangeVolProc(dllInstance.i, hArcData.i, *ChangeVolProc.UnRARChangeVolProc)
  Protected.RARSetChangeVolProcFunc pFuncCall
  
  If IsLibrary(dllInstance)
    pFuncCall = GetFunction(dllInstance, "RARSetChangeVolProc")
    
    If pFuncCall > 0
      pFuncCall(hArcData, *ChangeVolProc)
    EndIf  
  EndIf
EndProcedure

; <summary>
; RARSetProcessDataProc
; </summary>
; <param name="dllInstance"></param>
; <param name="hArcData"></param>
; <param name="*ProcessDataProc"></param>
; <returns>Returns void.</returns>
Procedure RARSetProcessDataProc(dllInstance.i, hArcData.i, *ProcessDataProc.UnRARProcessDataProc)
  Protected.RARSetProcessDataProcFunc pFuncCall
  
  If IsLibrary(dllInstance)
    pFuncCall = GetFunction(dllInstance, "RARSetProcessDataProc")
    
    If pFuncCall > 0
      pFuncCall(hArcData, *ProcessDataProc)
    EndIf  
  EndIf
EndProcedure

; <summary>
; RARSetPassword
; </summary>
; <param name="dllInstance"></param>
; <param name="hArcData"></param>
; <param name="Password"></param>
; <returns>Returns void.</returns>
Procedure RARSetPassword(dllInstance.i, hArcData.i, Password.s)
  Protected.RARSetPasswordFunc pFuncCall
  
  If IsLibrary(dllInstance)
    pFuncCall = GetFunction(dllInstance, "RARSetPassword")
    
    If pFuncCall > 0
      pFuncCall(hArcData, Password)
    EndIf  
  EndIf
EndProcedure

; <summary>
; RARCloseArchive
; </summary>
; <param name="dllInstance"></param>
; <param name="hArcData"></param>
; <returns>Returns long.</returns>
Procedure.i RARCloseArchive(dllInstance.i, hArcData.i)
  Protected.i lResult
  Protected.RARCloseArchiveFunc pFuncCall
  
  If IsLibrary(dllInstance)
    pFuncCall = GetFunction(dllInstance, "RARCloseArchive")
    
    If pFuncCall > 0
      lResult = pFuncCall(hArcData)
    EndIf  
  EndIf
  
  ProcedureReturn lResult
EndProcedure
; IDE Options = PureBasic 6.12 LTS (Windows - x64)
; CursorPosition = 11
; Folding = --
; EnableXP
; IncludeVersionInfo
; VersionField2 = Inwazy Technology
; VersionField3 = PureBasicUnRAR
; VersionField4 = 1.0.0