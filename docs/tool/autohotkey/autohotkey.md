# Auto Hotkey

## Getting Started

### Homepage

> https://www.autohotkey.com

### Installation

> $ choco install -y autohotkey

### Usage

1. Create `.ahk` script file.
2. Run script file.

### Reference

> https://www.autohotkey.com/docs/AutoHotkey.htm

## Syntax

```ahk
<keys>::
<Commands>
```

### Hotkeys

Key | Description
----|------------
!   | Alt
+   | Shift
^   | Ctrl
#   | Win
&   | Combine
<   | Pair key 중 왼쪽. (Ex. Shift, Alt, Ctrl)
>   | Pair key 중 오른쪽. (Ex. Shift, Alt, Ctrl)
*   | Wildcard
~   | Native function will not be blocked
$   | Send command에만 사용한다.
UP  | Release시 적용

기본적으로는 `&`를 사용하여 2개의 key만 조합할 수 있다. 3가지 이상의 키를 조합하려면, `#if`와 `GetKeyState()`을 사용해야 한다.

### Get Keycode

원하는 key의 SC###, VK##으로 표시되는 special key나 virtual key의 값을 확인하는 방법은 다음과 같다.

Tray icon에 있는 `AHK`를 열고, `CTRL-K`키를 누르면 확인할 수 있는 창이 나오고, `F5`키를 누르면 그전까지 눌렀던 key history가 나타난다.

### Remapping

```ahk
OriginKey::DestinationKey
```
