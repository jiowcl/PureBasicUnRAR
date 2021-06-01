;--------------------------------------------------------------------------------------------
;  Copyright (c) Ji-Feng Tsai. All rights reserved.
;  Code released under the MIT license.
;--------------------------------------------------------------------------------------------

; Windows APIs 
#SCS_32BIT_BINARY = 0
#SCS_64BIT_BINARY = 6
#SCS_DOS_BINARY   = 1
#SCS_OS216_BINARY = 5
#SCS_PIF_BINARY   = 3
#SCS_POSIX_BINARY = 4
#SCS_WOW_BINARY   = 2

; Header HOSTOS
#RAR_HEADER_HOSTOS_MSDOS = 0
#RAR_HEADER_HOSTOS_OS2   = 1
#RAR_HEADER_HOSTOS_WIN32 = 2
#RAR_HEADER_HOSTOS_UNIX  = 3

; <summary>
; HasSFX
; </summary>
; <param name="FilePath"></param>
; <returns>Returns boolean.</returns>
Procedure.i HasSFX(FilePath.s)
  Protected.i result = #False
  Protected.l BinaryType
  Protected.i GetBinaryTypeResult
  
CompilerIf #PB_Compiler_OS = #PB_OS_Windows
  GetBinaryTypeResult = GetBinaryType_(FilePath, @BinaryType)
  
  If GetBinaryTypeResult 
    If BinaryType = #SCS_32BIT_BINARY Or BinaryType = #SCS_64BIT_BINARY 
      result = #True
    EndIf  
  EndIf
CompilerEndIf 

  ProcedureReturn result
EndProcedure

; <summary>
; FormatHeaderHostOs
; </summary>
; <param name="HostOS"></param>
; <returns>Returns string.</returns>
Procedure.s FormatHeaderHostOs(HostOS.l)
  Protected.s result
  
  Select HostOS
    Case #RAR_HEADER_HOSTOS_MSDOS
      result = "MS-DOS"
      
    Case #RAR_HEADER_HOSTOS_OS2 
      result = "OS/2"
      
    Case #RAR_HEADER_HOSTOS_WIN32 
      result = "Win32"
      
    Case #RAR_HEADER_HOSTOS_UNIX
      result = "Unix"
  EndSelect
  
  ProcedureReturn result
EndProcedure

; <summary>
; FormatHeaderFileAttr
; </summary>
; <param name="FileAttr"></param>
; <returns>Returns string.</returns>
Procedure.s FormatHeaderFileAttr(FileAttr.l)
  Protected.s result
  
  If FileAttr & #PB_FileSystem_Archive    : result + "A" : Else : result + "-" : EndIf
  If FileAttr & #PB_FileSystem_ReadOnly   : result + "R" : Else : result + "-" : EndIf
  If FileAttr & #PB_FileSystem_Compressed : result + "C" : Else : result + "-" : EndIf
  If FileAttr & #PB_FileSystem_Hidden     : result + "H" : Else : result + "-" : EndIf
  If FileAttr & #PB_FileSystem_System     : result + "S" : Else : result + "-" : EndIf
  If FileAttr & #PB_FileSystem_Normal     : result + "N" : Else : result + "-" : EndIf
  If FileAttr & #FILE_ATTRIBUTE_DIRECTORY : result + "D" : Else : result + "-" : EndIf
  
  ProcedureReturn result
EndProcedure
; IDE Options = PureBasic 5.72 (Windows - x86)
; CursorPosition = 49
; FirstLine = 3
; Folding = -
; EnableXP
