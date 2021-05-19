;--------------------------------------------------------------------------------------------
;  Copyright (c) Ji-Feng Tsai. All rights reserved.
;  Code released under the MIT license.
;--------------------------------------------------------------------------------------------

IncludeFile "../Core/UnRAR.pbi"

Global lpszLibUnRARDll.s = "UnRAR.dll"
Global lpszSampleFilePath.s = "TestFile/example.rar"

Global hLibrary = UnRARDllOpen(lpszLibUnRARDll)

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
  
  HeaderData.RARHeaderDataEx
  ArchiveData.RAROpenArchiveDataEx
  
  ArchiveDataCmt.s = Space(16383) + Chr(0)
  
  ArchiveData\ArcNameW = @lpszSampleFilePath
  ArchiveData\OpenMode = #RAR_OM_EXTRACT
  ArchiveData\CmtBuf = @ArchiveDataCmt
  ArchiveData\CmtBufSize = SizeOf(ArchiveDataCmt)
  
  hRARArchiveHandle.l = RAROpenArchiveEx(hLibrary, @ArchiveData)
   
  If ArchiveData\OpenResult = 0
    RARSetCallback(hLibrary, hRARArchiveHandle, @UnRARCallbackProc(), 0)
    
    PrintN("Source: " + lpszSampleFilePath)
    
    While RARReadHeaderEx(hLibrary, hRARArchiveHandle, @HeaderData) = 0
      extractFile.s = PeekS(@HeaderData\FileNameW) 
      hUnRARProcCode.l = RARProcessFileW(hLibrary, hRARArchiveHandle, #RAR_TEST, "", "")
      
      PrintN("Test File: " + extractFile)
    Wend
    
  EndIf
  
  Input()
  CloseConsole()
  
  UnRARDllClose(hLibrary)  
EndIf
; IDE Options = PureBasic 5.72 (Windows - x86)
; CursorPosition = 41
; FirstLine = 6
; Folding = -
; EnableXP
; Executable = ..\TestExtractFileWithCallback.exe
; CurrentDirectory = ./
