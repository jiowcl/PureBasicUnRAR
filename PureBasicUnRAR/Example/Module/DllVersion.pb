;--------------------------------------------------------------------------------------------
;  Copyright (c) Ji-Feng Tsai. All rights reserved.
;  Code released under the MIT license.
;--------------------------------------------------------------------------------------------

EnableExplicit

IncludeFile "../../Core/Enums.pbi"
IncludeFile "../../Core/UnRARWrapper.pbi"

UseModule UnRARWrapper

Global lpszLibUnRARDll.s = "UnRAR.dll"

If DllOpen(lpszLibUnRARDll)
  OpenConsole()
  
  PrintN("DLL Version: " + UnRARArchive::GetDllVersion())
  
  Input()
  CloseConsole()
  
  DllClose()  
EndIf
; IDE Options = PureBasic 5.72 (Windows - x86)
; CursorPosition = 5
; EnableXP
; Executable = ..\..\ModuleDllVersion.exe
; CurrentDirectory = ./../