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

If hLibrary
  OpenConsole()
   
  Define HeaderData.RARHeaderData
  Define ArchiveData.RAROpenArchiveDataEx
  
  Define ArchiveDataCmt.s = Space(16383) + Chr(0)
  
  ArchiveData\ArcNameW = @lpszSampleFilePath
  ArchiveData\OpenMode = #RAR_OM_EXTRACT
  ArchiveData\CmtBuf = @ArchiveDataCmt
  ArchiveData\CmtBufSize = SizeOf(ArchiveDataCmt)
  
  Define hRARArchiveHandle.i = RAROpenArchiveEx(hLibrary, @ArchiveData)
  
  PrintN("hRARArchiveHandle: " + ArchiveData\OpenResult)
   
  If ArchiveData\OpenResult = #ERAR_SUCCESS
    PrintN("Source: " + lpszSampleFilePath)
    
    While RARReadHeader(hLibrary, hRARArchiveHandle, @HeaderData) = #ERAR_SUCCESS
      PrintN("File: " + PeekS(@HeaderData\FileName, -1, #PB_Ascii))
      
      Define extractFile.s = PeekS(@HeaderData\FileName, -1, #PB_Ascii) 
      Define hUnRARProcCode.i = RARProcessFile(hLibrary, hRARArchiveHandle, #RAR_TEST, "", "")
      
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
; CursorPosition = 41
; FirstLine = 13
; Folding = -
; EnableXP
; Executable = ..\TestExtractFile.exe
; CurrentDirectory = ../