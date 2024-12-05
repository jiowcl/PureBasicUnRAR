;--------------------------------------------------------------------------------------------
;  Copyright (c) Ji-Feng Tsai. All rights reserved.
;  Code released under the MIT license.
;--------------------------------------------------------------------------------------------

CompilerIf #PB_Compiler_Version < 520
  CompilerWarning "PureBasic 5.2.0 Version Required."
CompilerEndIf  
  
; Declare Module UnRARWrapper

DeclareModule UnRARWrapper
  Global dllInstance.i
  
  Declare.i DllOpen(lpszDllPath.s)
  Declare.i DllClose()
EndDeclareModule

DeclareModule UnRARArchive 
  IncludeFile "Enums.pbi"
  
  Declare.i OpenArchive(*ArchiveData.RAROpenArchiveData)  
  Declare.i OpenArchiveEx(*ArchiveData.RAROpenArchiveDataEx)  
  Declare.i ReadHeader(hArcData.i, *HeaderData.RARHeaderData)
  Declare.i ReadHeaderEx(hArcData.i, *HeaderData.RARHeaderDataEx)
  Declare.i ProcessFile(hArcData.i, Operation.l, DestPath.s, DestName.s)
  Declare.i ProcessFileW(hArcData.i, Operation.l, DestPath.s, DestName.s)
  Declare SetCallback(hArcData.i, *UnRARCallback.UnRARCallbackProc, UserData.l)
  Declare SetChangeVolProc(hArcData.i, *ChangeVolProc.UnRARChangeVolProc)
  Declare SetProcessDataProc(hArcData.i, *ProcessDataProc.UnRARProcessDataProc)
  Declare SetPassword(hArcData.i, Password.s)
  Declare.i CloseArchive(hArcData.i)
  Declare.i GetDllVersion() 
EndDeclareModule

DeclareModule UnRARHelper
  Declare.i HasSFX(FilePath.s)
EndDeclareModule  

; Module UnRARWrapper

Module UnRARWrapper
  IncludeFile "LibDll.pbi"

  ; <summary>
  ; DllOpen
  ; </summary>
  ; <param name="lpszDllPath"></param>
  ; <returns>Returns integer.</returns>
  Procedure.i DllOpen(lpszDllPath.s)
    If IsLibrary(dllInstance)
      ProcedureReturn dllInstance
    EndIf
    
    dllInstance = UnRARDllOpen(lpszDllPath)
    
    ProcedureReturn dllInstance
  EndProcedure
  
  ; <summary>
  ; DllClose
  ; </summary>
  ; <param name="dllInstance"></param>
  ; <returns>Returns integer.</returns>
  Procedure.i DllClose()
    ProcedureReturn UnRARDllClose(dllInstance)
  EndProcedure
EndModule

; Module UnRARArchive
Module UnRARArchive
  UseModule UnRARWrapper
  
  IncludeFile "Runtime.pbi"
  IncludeFile "RARArchive.pbi"
  
  ; <summary>
  ; OpenArchive
  ; </summary>
  ; <param name="*ArchiveData"></param>
  ; <returns>Returns long.</returns>
  Procedure.i OpenArchive(*ArchiveData.RAROpenArchiveData)     
    ProcedureReturn RAROpenArchive(UnRARWrapper::dllInstance, *ArchiveData)
  EndProcedure
  
  ; <summary>
  ; OpenArchiveEx
  ; </summary>
  ; <param name="*ArchiveData"></param>
  ; <returns>Returns long.</returns>
  Procedure.i OpenArchiveEx(*ArchiveData.RAROpenArchiveDataEx)     
    ProcedureReturn RAROpenArchiveEx(UnRARWrapper::dllInstance, *ArchiveData)
  EndProcedure
  
  ; <summary>
  ; ReadHeader
  ; </summary>
  ; <param name="hArcData"></param>
  ; <param name="*HeaderData"></param>
  ; <returns>Returns long.</returns>
  Procedure.i ReadHeader(hArcData.i, *HeaderData.RARHeaderData)      
    ProcedureReturn RARReadHeader(UnRARWrapper::dllInstance, hArcData, *HeaderData)
  EndProcedure
  
  ; <summary>
  ; ReadHeaderEx
  ; </summary>
  ; <param name="hArcData"></param>
  ; <param name="*HeaderData"></param>
  ; <returns>Returns long.</returns>
  Procedure.i ReadHeaderEx(hArcData.i, *HeaderData.RARHeaderDataEx)      
    ProcedureReturn RARReadHeaderEx(UnRARWrapper::dllInstance, hArcData, *HeaderData)
  EndProcedure
  
  ; <summary>
  ; ProcessFile
  ; </summary>
  ; <param name="hArcData"></param>
  ; <param name="Operation"></param>
  ; <param name="DestPath"></param>
  ; <param name="DestName"></param>
  ; <returns>Returns long.</returns>
  Procedure.i ProcessFile(hArcData.i, Operation.l, DestPath.s, DestName.s)      
    ProcedureReturn RARProcessFile(UnRARWrapper::dllInstance, hArcData, Operation, DestPath, DestName)
  EndProcedure
  
  ; <summary>
  ; ProcessFileW
  ; </summary>
  ; <param name="hArcData"></param>
  ; <param name="Operation"></param>
  ; <param name="DestPath"></param>
  ; <param name="DestName"></param>
  ; <returns>Returns long.</returns>
  Procedure.i ProcessFileW(hArcData.i, Operation.l, DestPath.s, DestName.s)      
    ProcedureReturn RARProcessFileW(UnRARWrapper::dllInstance, hArcData, Operation, DestPath, DestName)
  EndProcedure
  
  ; <summary>
  ; SetCallback
  ; </summary>
  ; <param name="hArcData"></param>
  ; <param name="*UnRARCallback"></param>
  ; <param name="UserData"></param>
  ; <returns>Returns void.</returns>
  Procedure SetCallback(hArcData.i, *UnRARCallback.UnRARCallbackProc, UserData.l)      
    ProcedureReturn RARSetCallback(UnRARWrapper::dllInstance, hArcData, *UnRARCallback, UserData)
  EndProcedure
  
  ; <summary>
  ; SetChangeVolProc
  ; </summary>
  ; <param name="hArcData"></param>
  ; <param name="*ChangeVolProc"></param>
  ; <returns>Returns void.</returns>
  Procedure SetChangeVolProc(hArcData.i, *ChangeVolProc.UnRARChangeVolProc)      
    ProcedureReturn RARSetChangeVolProc(UnRARWrapper::dllInstance, hArcData, *ChangeVolProc)
  EndProcedure
  
  ; <summary>
  ; SetProcessDataProc
  ; </summary>
  ; <param name="hArcData"></param>
  ; <param name="*ProcessDataProc"></param>
  ; <returns>Returns void.</returns>
  Procedure SetProcessDataProc(hArcData.i, *ProcessDataProc.UnRARProcessDataProc)      
    ProcedureReturn RARSetProcessDataProc(UnRARWrapper::dllInstance, hArcData, *ProcessDataProc)
  EndProcedure
   
  ; <summary>
  ; SetPassword
  ; </summary>
  ; <param name="hArcData"></param>
  ; <param name="Password"></param>
  ; <returns>Returns void.</returns>
  Procedure SetPassword(hArcData.i, Password.s)      
    ProcedureReturn RARSetPassword(UnRARWrapper::dllInstance, hArcData, Password)
  EndProcedure
  
  ; <summary>
  ; CloseArchive
  ; </summary>
  ; <param name="hArcData"></param>
  ; <returns>Returns long.</returns>
  Procedure.i CloseArchive(hArcData.i)   
    ProcedureReturn RARCloseArchive(UnRARWrapper::dllInstance, hArcData)
  EndProcedure  
  
  ; <summary>
  ; GetDllVersion
  ; </summary>
  ; <returns>Returns integer.</returns>
  Procedure.i GetDllVersion()   
    ProcedureReturn RARGetDllVersion(UnRARWrapper::dllInstance)
  EndProcedure
EndModule  

; Module UnRARHelper
Module UnRARHelper
  IncludeFile "Helper.pbi"
  
  ; <summary>
  ; HasSFX
  ; </summary>
  ; <param name="FilePath"></param>
  ; <returns>Returns boolean.</returns>
  Procedure.i HasSFX(FilePath.s) 
    ProcedureReturn RARHasSFX(FilePath)
  EndProcedure  
EndModule
; IDE Options = PureBasic 6.12 LTS (Windows - x64)
; CursorPosition = 121
; FirstLine = 84
; Folding = ----
; EnableXP