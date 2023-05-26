; md5函数的代码库
; 作者：Steve Wozniak
; 来源：https://www.autohotkey.com/boards/viewtopic.php?t=26146

MD5(ByRef data, length=0)
{
    ; Store all 64 sine values as a constant array:
    Static sineTable := "d76aa478, e8c7b756, 242070db, c1bdceee, f57c0faf, 4787c62a, a8304613, fd469501, 698098d8, 8b44f7af, ffff5bb1, 895cd7be, 6b901122, fd987193, a679438e, 49b40821, f61e2562, c040b340, 265e5a51, e9b6c7aa, d62f105d, 02441453, d8a1e681, e7d3fbc8, 21e1cde6, c33707d6, f4d50d87, 455a14ed, a9e3e905, fcefa3f8, 676f02d9, 8d2a4c8a, fffa3942, 8771f681, 6d9d6122, fde5380c, a4beea44, 4bdecfa9, f6bb4b60, bebfbc70, 289b7ec6, eaa127fa, d4ef3085, 04881d05, d9d4d039, e6db99e5, 1fa27cf8, c4ac5665, f4292244, 432aff97, ab9423a7, fc93a039, 655b59c3, 8f0ccc92, ffeff47d, 85845dd1, 6fa87e4f, fe2ce6e0, a3014314, 4e0811a1, f7537e82, bd3af235, 2ad7d2bb, eb86d391"
    Static T := {}  ; Array of constants
    If T.MaxIndex() = ""  ; Build the array of constants only once.
        For i, v In StrSplit(sineTable, ", ")
            T.Insert(0, "0x" SubStr(v, -8), 1)  ; In little-endian order.
    ; Pad the message to a multiple of 64 bytes in length:
    padChar := Chr(128)
    length += StrLen(data)
    blockCount := Ceil(length / 64), lastBlockLength := length - (blockCount - 1) * 64
    data .= padChar StringReplace("n" (blockCount * 64 - 8 - lastBlockLength), "n", "`n", 0) ; Message + Padding + Length
    ; Initialize hash variables:
    a := 0x674523
