;--------------------------------------------------------------------------------------------
;  Copyright (c) Ji-Feng Tsai. All rights reserved.
;  Code released under the MIT license.
;--------------------------------------------------------------------------------------------

IncludeFile "../../Core/Enums.pbi"
IncludeFile "../../Core/UnRARWrapper.pbi"

UseModule UnRARWrapper

Global lpszLibUnRARDll.s = "UnRAR.dll"
Global lpszSampleFilePath.s = "TestFile/example.rar"

If DllOpen(lpszLibUnRARDll)
  OpenConsole()
  
  HeaderData.RARHeaderDataEx
  ArchiveData.RAROpenArchiveDataEx
  
  ArchiveDataCmt.s = Space(16383) + Chr(0)
  
  ArchiveData\ArcNameW = @lpszSampleFilePath
  ArchiveData\OpenMode = #RAR_OM_EXTRACT
  ArchiveData\CmtBuf = @ArchiveDataCmt
  ArchiveData\CmtBufSize = SizeOf(ArchiveDataCmt)
  
  hRARArchiveHandle.l = UnRARArchive::OpenArchiveEx(@ArchiveData)
   
  If ArchiveData\OpenResult = 0
    PrintN("Source: " + lpszSampleFilePath)
    
    While UnRARArchive::ReadHeaderEx(hRARArchiveHandle, @HeaderData) = 0
      extractFile.s = PeekS(@HeaderData\FileNameW) 
      hUnRARProcCode.l = UnRARArchive::ProcessFileW(hRARArchiveHandle, #RAR_TEST, "", "")
      
      PrintN("Test File: " + extractFile)
    Wend
  EndIf
  
  Input()
  CloseConsole()
  
  DllClose()  
EndIf
; IDE Options = PureBasic 5.72 (Windows - x86)
; CursorPosition = 29
; EnableXP
; Executable = ..\..\ModuleTestExtractFile.exe
; CurrentDirectory = ./../