;--------------------------------------------------------------------------------------------
;  Copyright (c) Ji-Feng Tsai. All rights reserved.
;  Code released under the MIT license.
;--------------------------------------------------------------------------------------------

#ERAR_SUCCESS          =  0
#ERAR_END_ARCHIVE      = 10
#ERAR_NO_MEMORY        = 11
#ERAR_BAD_DATA         = 12
#ERAR_BAD_ARCHIVE      = 13
#ERAR_UNKNOWN_FORMAT   = 14
#ERAR_EOPEN            = 15
#ERAR_ECREATE          = 16
#ERAR_ECLOSE           = 17
#ERAR_EREAD            = 18
#ERAR_EWRITE           = 19
#ERAR_SMALL_BUF        = 20
#ERAR_UNKNOWN          = 21
#ERAR_MISSING_PASSWORD = 22
#ERAR_EREFERENCE       = 23
#ERAR_BAD_PASSWORD     = 24

#RAR_OM_LIST          = 0
#RAR_OM_EXTRACT       = 1
#RAR_OM_LIST_INCSPLIT = 2

#RAR_SKIP    = 0
#RAR_TEST    = 1
#RAR_EXTRACT = 2

#RAR_VOL_ASK    = 0
#RAR_VOL_NOTIFY = 1

#RAR_DLL_VERSION = 8

#RAR_HASH_NONE   = 0
#RAR_HASH_CRC32  = 1
#RAR_HASH_BLAKE2 = 2

#UCM_CHANGEVOLUME  = 0
#UCM_PROCESSDATA   = 1
#UCM_NEEDPASSWORD  = 2
#UCM_CHANGEVOLUMEW = 3
#UCM_NEEDPASSWORDW = 4

; Structure

Structure RARHeaderData
  ArcName.b[260] 
  FileName.b[260]
  Flags.l 
  PackSize.l 
  UnpSize.l 
  HostOS.l 
  FileCRC.l 
  FileTime.l 
  UnpVer.l 
  Method.l 
  FileAttr.l 
  *CmtBuf
  CmtBufSize.l 
  CmtSize.l 
  CmtState.l
EndStructure 

Structure RARHeaderDataEx
  ArcName.b[1024] 
  ArcNameW.w[1024]
  FileName.b[1024]
  FileNameW.w[1024]
  Flags.l 
  PackSize.l 
  PackSizeHigh.l
  UnpSize.l 
  UnpSizeHigh.l
  HostOS.l 
  FileCRC.l 
  FileTime.l 
  UnpVer.l 
  Method.l 
  FileAttr.l 
  *CmtBuf
  CmtBufSize.l 
  CmtSize.l 
  CmtState.l
  DictSize.l
  HashType.l
  Hash.b[32]
  RedirType.l
  *RedirName
  DirTarget.l
  MtimeLow.l
  MtimeHigh.l
  CtimeLow.l
  CtimeHigh.l
  AtimeLow.l
  AtimeHigh.l
  Reserved.l[988]
EndStructure  

Structure RAROpenArchiveData
  *ArcName
  OpenMode.l
  OpenResult.l
  *CmtBuf
  CmtBufSize.l
  CmtSize.l
  CmtState.l
EndStructure

Structure RAROpenArchiveDataEx
  *ArcName
  *ArcNameW
  OpenMode.l
  OpenResult.l
  *CmtBuf
  CmtBufSize.l
  CmtSize.l
  CmtState.l
  Flags.l
  Callback.l
  UserData.i
  OpFlags.l
  *CmtBufW
  Reserved.l[25]
EndStructure

; Prototype Callback Function

Prototype.i UnRARCallbackProc(Msg.i, UserData.l, P1.l, P2.l)
; IDE Options = PureBasic 5.72 (Windows - x86)
; CursorPosition = 108
; FirstLine = 79
; EnableXP
; IncludeVersionInfo
; VersionField2 = Inwazy Technology
; VersionField3 = PureBasicURAR
; VersionField4 = 1.0.0