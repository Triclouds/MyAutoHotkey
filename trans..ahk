F2::
Clipboard := ""
Send, ^c
ClipWait, 1
FileName := RegExReplace(Clipboard,"`am)(^.+?)([^\\]+?)\.[^.]+$","$2")
MsgBox % "复制后剪切板内内容：`n" Clipboard "`n截取后的文件名：`n" FileName
Return