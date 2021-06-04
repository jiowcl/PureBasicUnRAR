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

If DllOpen(lpszLibUnRARDll)
  OpenConsole()
  
  PrintN("DLL Version: " + UnRARArchive::GetDllVersion())
  
  Input()
  CloseConsole()
  
  DllClose()  
EndIf
; IDE Options = PureBasic 5.72 (Windows - x64)
; CursorPosition = 17
; Folding = -
; EnableXP
; Executable = ..\..\ModuleDllVersion.exe
; CurrentDirectory = ../../