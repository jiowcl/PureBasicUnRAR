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

Global lpszSampleFilePath.s = "TestFile/mexample.part1.rar"

Global hLibrary.i = UnRARDllOpen(lpszLibUnRARDll)

; UnRAR ChangeVol Proc
Procedure.i UnRARChangeVolProc(*ArcName, Mode.i)
  PrintN("Change Vol: " + PeekS(*ArcName, -1, #PB_UTF8) + ", Mode: " + Mode)
  
  ProcedureReturn #True
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
  
  Define hRARArchiveHandle.l = RAROpenArchiveEx(hLibrary, @ArchiveData)
   
  If ArchiveData\OpenResult = #ERAR_SUCCESS
    RARSetChangeVolProc(hLibrary, hRARArchiveHandle, @UnRARChangeVolProc())
    
    PrintN("Source: " + lpszSampleFilePath)
    
    While RARReadHeaderEx(hLibrary, hRARArchiveHandle, @HeaderData) = #ERAR_SUCCESS
      Define extractFile.s = PeekS(@HeaderData\FileNameW) 
      Define hUnRARProcCode.l = RARProcessFileW(hLibrary, hRARArchiveHandle, #RAR_TEST, "", "")
      
      If hUnRARProcCode <> #ERAR_SUCCESS
        PrintN("Test File Failed: " + extractFile)
        
        Continue
      EndIf
      
      PrintN("Test File: " + extractFile)
    Wend
  EndIf
  
  Input()
  CloseConsole()
  
  UnRARDllClose(hLibrary)  
EndIf
; IDE Options = PureBasic 5.72 (Windows - x86)
; CursorPosition = 22
; Folding = -
; EnableXP
; Executable = ..\TestExtractFileWithDataProcess.exe
; CurrentDirectory = ../