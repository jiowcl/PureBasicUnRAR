;--------------------------------------------------------------------------------------------
;  Copyright (c) Ji-Feng Tsai. All rights reserved.
;  Code released under the MIT license.
;--------------------------------------------------------------------------------------------

EnableExplicit

IncludeFile "../Core/UnRAR.pbi"

;Global lpszLibUnRARDll.s = "UnRAR.dll"

; UnRAR version (x86/x64)
CompilerIf #PB_Compiler_Processor = #PB_Processor_x64
  Global lpszLibUnRARDll.s = "UnRAR64.dll"
CompilerElse
  Global lpszLibUnRARDll.s = "UnRAR.dll"
CompilerEndIf

Global hLibrary.i = UnRARDllOpen(lpszLibUnRARDll)

If hLibrary
  OpenConsole()
  
  PrintN("DLL Version: " + RARGetDllVersion(hLibrary))
   
  Input()
  CloseConsole()
   
  UnRARDllClose(hLibrary)  
EndIf
; IDE Options = PureBasic 6.00 LTS (Windows - x64)
; Folding = -
; Optimizer
; EnableXP
; Executable = ..\DllVersion.exe
; CurrentDirectory = ../