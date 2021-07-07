# PureBasicUnRAR

UnRAR Wrapper for PureBasic Programming Language.

![GitHub](https://img.shields.io/github/license/jiowcl/PureBasicUnRAR.svg)

## Environment

- Windows 7 above (recommend)  
- PureBasic 5.0 above (recommend)  
- [UnRAR](https://www.rarlab.com/rar_add.htm)  

## How to Build

Building requires PureBasic Compiler and test under Windows 10.  
Module features require PureBasic 5.20 and above.  

## Example

Extract the RAR file

```purebasic
EnableExplicit

IncludeFile "../../Core/Enums.pbi"
IncludeFile "../../Core/UnRARWrapper.pbi"

UseModule UnRARWrapper

Global lpszLibUnRARDll.s = "UnRAR.dll"
Global lpszSampleFilePath.s = "TestFile/example.rar"

If DllOpen(lpszLibUnRARDll)
  OpenConsole()
  
  Define HeaderData.RARHeaderDataEx
  Define ArchiveData.RAROpenArchiveDataEx
  
  Define ArchiveDataCmt.s = Space(16383) + Chr(0)
  
  ArchiveData\ArcNameW = @lpszSampleFilePath
  ArchiveData\OpenMode = #RAR_OM_EXTRACT
  ArchiveData\CmtBuf = @ArchiveDataCmt
  ArchiveData\CmtBufSize = SizeOf(ArchiveDataCmt)
  
  Define hRARArchiveHandle.l = UnRARArchive::OpenArchiveEx(@ArchiveData)
   
  If ArchiveData\OpenResult = 0
    PrintN("Source: " + lpszSampleFilePath)
    
    While UnRARArchive::ReadHeaderEx(hRARArchiveHandle, @HeaderData) = 0
      Define extractFile.s = PeekS(@HeaderData\FileNameW) 
      Define hUnRARProcCode.l = UnRARArchive::ProcessFileW(hRARArchiveHandle, #RAR_TEST, "", "")
      
      PrintN("Test File: " + extractFile)
    Wend
  EndIf
  
  Input()
  CloseConsole()
  
  DllClose()  
EndIf
```

## License

Copyright (c) 2017-2021 Ji-Feng Tsai.  
Code released under the MIT license.  

## TODO

- More examples  

## Donation

If this application help you reduce time to coding, you can give me a cup of coffee :)

[![paypal](https://www.paypalobjects.com/en_US/TW/i/btn/btn_donateCC_LG.gif)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=3RNMD6Q3B495N&source=url)

[Paypal Me](https://paypal.me/jiowcl?locale.x=zh_TW)
