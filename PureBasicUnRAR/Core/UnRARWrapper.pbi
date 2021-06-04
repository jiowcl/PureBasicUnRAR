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
   
  Declare.l OpenArchiveEx(*ArchiveData.RAROpenArchiveDataEx)  
  Declare.l ReadHeaderEx(hArcData.l, *HeaderData.RARHeaderDataEx)
  Declare.l ProcessFileW(hArcData.l, Operation.l, DestPath.s, DestName.s)
  Declare SetCallback(hArcData.l, *UnRARCallback, UserData.l)
  Declare SetPassword(hArcData.l, Password.s)
  Declare.l CloseArchive(hArcData.l)
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
  ; OpenArchiveEx
  ; </summary>
  ; <param name="*ArchiveData"></param>
  ; <returns>Returns long.</returns>
  Procedure.l OpenArchiveEx(*ArchiveData.RAROpenArchiveDataEx)     
    ProcedureReturn RAROpenArchiveEx(UnRARWrapper::dllInstance, *ArchiveData)
  EndProcedure
  
  ; <summary>
  ; ReadHeaderEx
  ; </summary>
  ; <param name="hArcData"></param>
  ; <param name="*HeaderData"></param>
  ; <returns>Returns long.</returns>
  Procedure.l ReadHeaderEx(hArcData.l, *HeaderData.RARHeaderDataEx)      
    ProcedureReturn RARReadHeaderEx(UnRARWrapper::dllInstance, hArcData, *HeaderData)
  EndProcedure
  
  ; <summary>
  ; ProcessFileW
  ; </summary>
  ; <param name="hArcData"></param>
  ; <param name="Operation"></param>
  ; <param name="DestPath"></param>
  ; <param name="DestName"></param>
  ; <returns>Returns long.</returns>
  Procedure.l ProcessFileW(hArcData.l, Operation.l, DestPath.s, DestName.s)      
    ProcedureReturn RARProcessFileW(UnRARWrapper::dllInstance, hArcData, Operation, DestPath, DestName)
  EndProcedure
  
  ; <summary>
  ; SetCallback
  ; </summary>
  ; <param name="hArcData"></param>
  ; <param name="*UnRARCallback"></param>
  ; <param name="UserData"></param>
  ; <returns>Returns void.</returns>
  Procedure SetCallback(hArcData.l, *UnRARCallback, UserData.l)      
    ProcedureReturn RARSetCallback(UnRARWrapper::dllInstance, hArcData, *UnRARCallback, UserData)
  EndProcedure
  
  ; <summary>
  ; SetPassword
  ; </summary>
  ; <param name="hArcData"></param>
  ; <param name="Password"></param>
  ; <returns>Returns void.</returns>
  Procedure SetPassword(hArcData.l, Password.s)      
    ProcedureReturn RARSetPassword(UnRARWrapper::dllInstance, hArcData, Password)
  EndProcedure
  
  ; <summary>
  ; CloseArchive
  ; </summary>
  ; <param name="hArcData"></param>
  ; <returns>Returns long.</returns>
  Procedure.l CloseArchive(hArcData.l)   
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
; IDE Options = PureBasic 5.72 (Windows - x86)
; CursorPosition = 143
; FirstLine = 102
; Folding = ---
; EnableXP