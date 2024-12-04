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

Global lpszSampleFilePath.s = "TestFile/examplewithpw.rar"
Global lpszPassword.s = "abcd1234"

Global hLibrary.i = UnRARDllOpen(lpszLibUnRARDll)

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
    PrintN("Source: " + lpszSampleFilePath)
    PrintN("Password: " + lpszPassword)
        
    RARSetPassword(hLibrary, hRARArchiveHandle, lpszPassword)
    
    ;PrintN("File: " + RARReadHeaderEx(hLibrary, hRARArchiveHandle, @HeaderData))
                 
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
; CursorPosition = 42
; FirstLine = 8
; Folding = -
; EnableXP
; Executable = ..\TestExtractFileWithPw.exe
; CurrentDirectory = ../