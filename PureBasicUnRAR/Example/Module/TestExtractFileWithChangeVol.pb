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

Global lpszSampleFilePath.s = "TestFile/mexample.part1.rar"

; UnRAR ChangeVol Proc
Procedure.i UnRARChangeVolProc(*ArcName, Mode.i)
  PrintN("Change Vol: " + PeekS(*ArcName, -1, #PB_UTF8) + ", Mode: " + Mode)
  
  ProcedureReturn #True
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
    UnRARArchive::SetChangeVolProc(hRARArchiveHandle, @UnRARChangeVolProc())
    
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
; CursorPosition = 61
; FirstLine = 17
; Folding = -
; EnableXP
; Executable = ..\..\ModuleTestExtractFileWithDataProcess.exe
; CurrentDirectory = ../../