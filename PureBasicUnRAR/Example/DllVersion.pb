;--------------------------------------------------------------------------------------------
;  Copyright (c) Ji-Feng Tsai. All rights reserved.
;  Code released under the MIT license.
;--------------------------------------------------------------------------------------------

IncludeFile "../Core/UnRAR.pbi"

Global lpszLibUnRARDll.s = "UnRAR.dll"

Global hLibrary = UnRARDllOpen(lpszLibUnRARDll)

If hLibrary
  OpenConsole()
  
  PrintN("DLL Version: " + RARGetDllVersion(hLibrary))
  
  Input()
  CloseConsole()
  
  UnRARDllClose(hLibrary)  
EndIf
; IDE Options = PureBasic 5.72 (Windows - x86)
; CursorPosition = 17
; EnableXP
; Executable = ..\DllVersion.exe
; CurrentDirectory = ./