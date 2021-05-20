;--------------------------------------------------------------------------------------------
;  Copyright (c) Ji-Feng Tsai. All rights reserved.
;  Code released under the MIT license.
;--------------------------------------------------------------------------------------------

EnableExplicit

IncludeFile "../Core/UnRAR.pbi"

Global lpszLibUnRARDll.s = "UnRAR.dll"

Global hLibrary.i = UnRARDllOpen(lpszLibUnRARDll)

If hLibrary
  OpenConsole()
  
  PrintN("DLL Version: " + RARGetDllVersion(hLibrary))
   
  Input()
  CloseConsole()
   
  UnRARDllClose(hLibrary)  
EndIf
; IDE Options = PureBasic 5.72 (Windows - x86)
; CursorPosition = 20
; EnableXP
; Executable = ..\DllVersion.exe
; CurrentDirectory = ./