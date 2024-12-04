;--------------------------------------------------------------------------------------------
;  Copyright (c) Ji-Feng Tsai. All rights reserved.
;  Code released under the MIT license.
;--------------------------------------------------------------------------------------------

EnableExplicit

IncludeFile "../../Core/Enums.pbi"
IncludeFile "../../Core/UnRARWrapper.pbi"

UseModule UnRARWrapper

; UnRAR version (x86/x64)
CompilerIf #PB_Compiler_Processor = #PB_Processor_x64
  Global lpszLibUnRARDll.s = "UnRAR64.dll"
CompilerElse
  Global lpszLibUnRARDll.s = "UnRAR.dll"
CompilerEndIf

Global lpszSampleFilePath.s = "TestFile/example.rar"

; UnRAR Callback Proc
Procedure.i UnRARCallbackProc(msg.i, UserData.l, P1.l, P2.l) 
  Select msg
    Case #UCM_PROCESSDATA
    Case #UCM_CHANGEVOLUMEW
    Case #UCM_NEEDPASSWORDW 
  EndSelect
   
  ProcedureReturn 0
EndProcedure

If DllOpen(lpszLibUnRARDll)
  OpenConsole()
  
  Define HeaderData.RARHeaderDataEx
  Define ArchiveData.RAROpenArchiveDataEx
  
  Define ArchiveDataCmt.s = Space(16383) + Chr(0)
  
  ArchiveData\ArcNameW = @lpszSampleFilePath
  ArchiveData\OpenMode = #RAR_OM_EXTRACT
  ArchiveData\CmtBuf = @ArchiveDataCmt
  ArchiveData\CmtBufSize = SizeOf(ArchiveDataCmt)
  
  Define hRARArchiveHandle.i = UnRARArchive::OpenArchiveEx(@ArchiveData)
   
  If ArchiveData\OpenResult = #ERAR_SUCCESS
    UnRARArchive::SetCallback(hRARArchiveHandle, @UnRARCallbackProc(), 0)
    
    PrintN("Source: " + lpszSampleFilePath)
    
    While UnRARArchive::ReadHeaderEx(hRARArchiveHandle, @HeaderData) = #ERAR_SUCCESS
      Define extractFile.s = PeekS(@HeaderData\FileNameW) 
      Define hUnRARProcCode.i = UnRARArchive::ProcessFileW(hRARArchiveHandle, #RAR_TEST, "", "")
      
      If hUnRARProcCode <> #ERAR_SUCCESS
        PrintN("Test File Failed: " + extractFile)
        
        Continue
      EndIf
      
      PrintN("Test File: " + extractFile)
    Wend
    
    PrintN("Completed")
  EndIf
  
  Input()
  CloseConsole()
  
  DllClose()  
EndIf
; IDE Options = PureBasic 6.12 LTS (Windows - x64)
; CursorPosition = 65
; FirstLine = 21
; Folding = -
; EnableXP
; Executable = ..\..\ModuleTestExtractFileWithCallback.exe
; CurrentDirectory = ../../