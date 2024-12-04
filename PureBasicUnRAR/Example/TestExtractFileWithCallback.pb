;--------------------------------------------------------------------------------------------
;  Copyright (c) Ji-Feng Tsai. All rights reserved.
;  Code released under the MIT license.
;--------------------------------------------------------------------------------------------

EnableExplicit

IncludeFile "../Core/UnRAR.pbi"

; UnRAR version (x86/x64)
CompilerIf #PB_Compiler_Processor = #PB_Processor_x64
  Global lpszLibUnRARDll.s = "UnRAR64.dll"
CompilerElse
  Global lpszLibUnRARDll.s = "UnRAR.dll"
CompilerEndIf

Global lpszSampleFilePath.s = "TestFile/example.rar"

Global hLibrary.i = UnRARDllOpen(lpszLibUnRARDll)

; UnRAR Callback Proc
Procedure.i UnRARCallbackProc(Msg.i, UserData.l, P1.l, P2.l) 
  Select Msg
    Case #UCM_PROCESSDATA
    Case #UCM_CHANGEVOLUMEW
    Case #UCM_NEEDPASSWORDW 
  EndSelect
  
  ProcedureReturn 0
EndProcedure

If hLibrary
  OpenConsole()
  
  Define HeaderData.RARHeaderDataEx
  Define ArchiveData.RAROpenArchiveDataEx
  
  Define ArchiveDataCmt.s = Space(16383) + Chr(0)
  
  ArchiveData\ArcNameW = @lpszSampleFilePath
  ArchiveData\OpenMode = #RAR_OM_EXTRACT
  ArchiveData\CmtBuf = @ArchiveDataCmt
  ArchiveData\CmtBufSize = SizeOf(ArchiveDataCmt)
  
  Define hRARArchiveHandle.i = RAROpenArchiveEx(hLibrary, @ArchiveData)
   
  If ArchiveData\OpenResult = #ERAR_SUCCESS
    RARSetCallback(hLibrary, hRARArchiveHandle, @UnRARCallbackProc(), 0)
    
    PrintN("Source: " + lpszSampleFilePath)
    
    While RARReadHeaderEx(hLibrary, hRARArchiveHandle, @HeaderData) = #ERAR_SUCCESS
      Define extractFile.s = PeekS(@HeaderData\FileNameW) 
      Define hUnRARProcCode.i = RARProcessFileW(hLibrary, hRARArchiveHandle, #RAR_TEST, "", "")
      
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
  
  UnRARDllClose(hLibrary)  
EndIf
; IDE Options = PureBasic 6.12 LTS (Windows - x64)
; CursorPosition = 64
; FirstLine = 18
; Folding = -
; EnableXP
; Executable = ..\TestExtractFileWithCallback.exe
; CurrentDirectory = ../