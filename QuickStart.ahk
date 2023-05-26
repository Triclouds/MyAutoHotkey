#NoEnv
#SingleInstance force

#IfWinActive ahk_exe Code.exe

	#x::Send ^{F9}

#IfWinActive

/*
	======================文字替换========================
		]d	显示当前日期----2023年5月19日
		]t	显示当前时间----3:55:59
*/ 

; QQ邮箱
:*:q@::
	SendInput, sanyun99@qq.com
Return

:*:w@::
	SendInput, sanyun99@163.com
Return

; 此热字串通过后面的命令把 "]d" 替换成当前日期.
:*:]d::
	FormatTime, CurrentDateTime,, yyyy年M月d日
	SendInput %CurrentDateTime%
return

; 此热字串通过后面的命令把 "]t" 替换成当前时间
:*:]t::
	FormatTime, CurrentDateTime,, H:mm:ss
	SendInput %CurrentDateTime%
return

; 在Notepad3和VSCode中将输入的中文分号自动转为英文分号

:*:`;::
	#IfWinActive ahk_class Notepad3
		sendinput,{U+003b}
	#IfWinActive
	; #IfWinActive ahk_exe Code.exe
	; 	sendinput,{U+003b}
	; #IfWinActive
return

; ===================Capslock键操作======================
; Capslock键主要用于打开指定软件
; Capslock+W  打开微信
; Capslock+L  打开洛雪音乐
; Capslock+E  打开EDGE浏览器

;wechat
CapsLock & w::
IfWinActive ahk_exe WeChat.exe
	WinMinimize
else IfWinExist ahk_exe WeChat.exe
	WinActivate
else
	Run D:\Tricloud\Program\WeChat\WeChat.exe
return

;LxMusic
CapsLock & l::
IfWinActive ahk_exe lx-music-desktop.exe
	WinMinimize
else IfWinExist ahk_exe lx-music-desktop.exe
	WinActivate
else
	Run D:\Tricloud\Program\LxMusic\lx-music-desktop.exe
return

;edge
CapsLock & e::
IfWinActive ahk_exe msedge.exe
	WinMinimize
else IfWinExist ahk_exe msedge.exe
	WinActivate
else
	Run msedge.exe
return

; ===================Tab键操作======================
; Tab+数字主要用于选中文字使用搜索引擎搜索
; Tab+1  百度搜索
; Tab+2  谷歌搜索

;百度搜索
~Tab & 1::
	Clipboard=
	Send, ^c
	ClipWait,2
	Run https://www.baidu.com/s?wd=%Clipboard%
return

;谷歌搜索
~Tab & 2::
	Clipboard=
	Send, ^c
	ClipWait,2
	Run https://www.google.com/search?q=%Clipboard%
return

; =====================Tab键操作===========================
; Tab+字母主要用于打开常用网站
; Tab+B  打开哔哩哔哩
; Tab+H  打开虎牙直播
; Tab+G  打开Github
; Tab+M  打开memos

~Tab & b::
	Run https://www.bilibili.com/
return

~Tab & h::
	Run https://www.huya.com/g/xingxiu#cate-1-116
return

~Tab & g::
	Run https://github.com/
return

~Tab & m::
	Run http://192.168.123.100:5230/
return

; ====================Esc键操作===========================
; Esc键主要用于打开常用文件夹
; Esc+D  打开下载文件夹
; Esc+G  打开工具库
; Esc+S  打开软件安装文件夹

~Esc & d::
	Run D:\Tricloud\Downloads\
return

~Esc & g::
	Run D:\工具库\
return

~Esc & s::
	Run D:\Tricloud\Program
return

; ===================Windows键操作======================
; windows键主要用于一些系统操作
; Windows+W  关闭当前窗口
; Windows+N  打开记事本
; Windows+B  选中文字搜索百度

; 关闭当前窗口
#w::
WinClose, A
return

;notepad
#n::Run Notepad
return

; 

; 推送到Bark
#b::
	Clipboard=
	Send, ^c
	ClipWait,2
	
	url := "https://api.day.app/saN2yQ8gxcRMUPUjHN2FUX/我的电脑/" . Clipboard
	WinHttpReq := ComObjCreate("WinHttp.WinHttpRequest.5.1")
	WinHttpReq.Open("GET", url)
	WinHttpReq.Send()
	responseText := WinHttpReq.ResponseText
	
	if instr(responseText, "success")
		ToolTip, 发送成功
	else
		MsgBox, %responseText%
return

; ==================系统操作=======================
; 系统操作主要用到右Alt和右Ctrl

;切换窗口
RAlt & RControl::AltTab
RAlt & >::ShiftAltTab
	
;切换上一首歌曲
RControl & Left::send {media_prev}
;切换下一首歌曲
RControl & Right::send {media_next}
;暂停播放歌曲
RControl & space::send {media_play_pause}
;升高音量
RControl & up::send {volume_up}
;降低音量
RControl & down::send {volume_down}

; =====================VLC应用操作========================

; vlc播放器长按右方向键倍速播放
#IfWinActive ahk_exe vlc.exe
Right::		; 长按0.3秒方向右键进行倍速播放，松开时恢复
	KeyWait, Right, T0.3
	if ErrorLevel {
		Send, ]]]]]]]]]]]]]]]	; 调整此数值修改速度
		ToolTip, >>>
		KeyWait, Right	; 松开按键恢复正常速度
		Send, =
		ToolTip
	} else Send {Right}
	return
	
; ===================EDGE浏览器操作======================

#IfWinActive, ahk_exe msedge.exe ; 如果活动窗口是Chrome浏览器

; 交换Tab键与Esc键功能
Tab::Esc

; 当右Alt键被按下时切换到上一个标签页
RAlt::
	Send ^+{Tab}
return

; 当右Ctrl键被按下时切换到下一个标签页
RControl::
	Send ^{Tab}
return

; 双击空格时关闭当前标签页
Space:: ; 当空格键被按下时
    if (A_PriorHotkey = A_ThisHotkey and A_TimeSincePriorHotkey < 300) ; 
    {
        Send ^w ; 关闭标签页
    }
    else
    {
        Send {Space} ; 发送空格键，还原默认行为
    }
return

; 双击左键时关闭当前标签页
~XButton1::
    if (A_PriorHotkey = A_ThisHotkey and A_TimeSincePriorHotkey < 300) ; 
    {
        Send ^w ; 关闭标签页
    }
    else
    {
        Send {~XButton1} ; 发送空格键，还原默认行为
    }
return

; ====================浏览器内B站操作======================

; 打开动态
!d::
	WinGetTitle, sTitle, A
	If (InStr(sTitle, "哔哩哔哩")) {
		Send, {Ctrl down}{Home}{Ctrl up}
		Click 1540, 80
		MouseMove, 1300, 500
	}
Return

; 打开收藏
!s::
	WinGetTitle, sTitle, A
	If (InStr(sTitle, "哔哩哔哩")) {
		Send, {Ctrl down}{Home}{Ctrl up}
		Click 1600, 80
		MouseMove, 1300, 500
	}
Return

#IfWinActive ; 恢复快捷键的作用范围

; ===================360文件浏览器操作======================

#IfWinActive ahk_exe 360FileBrowser64.exe

;获取文件名
^c::
	ClipSaved := ClipboardAll
	Clipboard := ""
	SendInput ^c
	ClipWait 0.5
	FilePath := Clipboard
	FilePath := StrReplace(FilePath, "\", "\\")
	FileName := RegExReplace(FilePath, ".*\\", "")
	Clipboard := FileName
	
	ToolTip, %FileName%
    sleep 1000
    ToolTip
    SendInput ^c
return



; 按下Ctrl+Shift+C后复制文件路径
^+c:: 
    ClipSaved := ClipboardAll
    Clipboard := ""
    SendInput ^c
    ClipWait 0.5
    ; 文件全路径
    FilePath := Clipboard
    Clipboard := ClipSaved
	Clipboard := FilePath
	
	#Persistent
	ToolTip, %FilePath%
	SetTimer, RemoveToolTip, -1000
	
	; 替换为\\的全路径
	; FilePath := StrReplace(FilePath, "\", "\\")
	; 带后缀文件名
	; FileName := RegExReplace(FilePath, ".*\\", "")
	; 不带后缀文件名
	; FileName := RegExReplace(FileName, "\.[^.]*$", "")
return

RemoveToolTip:
ToolTip
return

!m::
	ClipSaved := ClipboardAll
    Clipboard := ""
	; 将选中的文件复制到剪切板中
    SendInput ^c
    ; 等待剪切板中的内容加载完毕
    ClipWait 0.5
    FilePath := Clipboard
    Clipboard := FilePath
    ToolTip, %FilePath%
    sleep 1000
    ToolTip
    SendInput ^c


	; FilePath := "C:\\Users\\username\\Documents\\file.txt"
	; RegExMatch(FilePath, "O)[^\\\/]+(?=\.[^.]*$)", FilaName)
	; MsgBox, 文件名是：%FileName%
	; result := RegExReplace(FilePath, ".*\\", "")
	; result := RegExReplace(FileName, "\.[^.]*$", "")
	; MsgBox % result
Return

#z::
	ClipSaved := ClipboardAll
    Clipboard := ""
    SendInput ^c
    ClipWait 0.5
    FilePath := Clipboard
	; 获取解压到的文件夹路径
	FileFolderPath := RegExReplace(FilePath, "\.[^.]*$", "")
	; 执行解压命令
	Run cmd.exe /c 7z x %FilePath% -o%FileFolderPath% && start %FileFolderPath%,,hide
Return

#IfWinActive ; 恢复快捷键的作用范围

;#z:: ; Win+Z键
;  SendInput ^c ; 复制选定的文本到剪贴板
;  ClipWait ; 等待剪贴板中的文本
;  text := Clipboard ; 获取剪贴板中的文本
;  text := RegExReplace(text, ".*(\n|\r).*") ; 删除所有换行符
;  text := RegExReplace(text, "[A-Za-z0-9]") ; 删除所有字母和数字
;  Clipboard := text ; 将处理后的文本存储到剪贴板中
;  SendInput ^v ; 粘贴处理后的文本
;return

;桌面打开网站
#IfWinActive ahk_class WorkerW

~g & g::Run "www.google.com"

b::
	if (A_PriorHotkey = A_ThisHotkey and A_TimeSincePriorHotkey < 300)
    {
        Run https://www.bilibili.com/
    }
    else
    {
        Send {b} ; 发送空格键，还原默认行为
    }
return

h & y::
	Run https://www.huya.com/g/xingxiu#cate-1-116
return

g & h::
	Run https://github.com/
return

#IfWinActive

; =========================鼠标操作================================

; 映射鼠标侧键为复制
XButton1::Send ^c

; 映射鼠标侧键为粘贴
XButton2::Send ^v

; 在任务栏上滚动鼠标来调节音量.
#If MouseIsOver("ahk_class Shell_TrayWnd")
	WheelUp::Send {Volume_Up}
	WheelDown::Send {Volume_Down}
	MButton::Send {Volume_Mute}

MouseIsOver(WinTitle) {
MouseGetPos,,, Win
return WinExist(WinTitle . " ahk_id " . Win)
}

; 显示任务栏
^m::
	WinShow ahk_class Shell_TrayWnd
return

; 隐藏任务栏
^k::
	WinHide ahk_class Shell_TrayWnd
return

!q::
	ControlGetFocus, out, A  ; A means the active window
		tooltip, Control is %out%
	return