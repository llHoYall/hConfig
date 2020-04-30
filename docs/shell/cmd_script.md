# Windows Commands

## Comment

```batch
: This is comment.
rem This is also comment.
```

## Input / Output

```batch
: Print string
echo "This is the output string."

: Print color string
echo [33mColor[0m

: Print with no newline
echo | set /p="This string doesn't contain a new line character."
```

## Conditional Statement

```batch
if [not] ERRORLEVEL <number> <command> [else <expression>]
: ERRORLEVEL <number>
:   > Specifies a true condition only if the previous program run by Cmd.exe returned an exit code equal to or greater than <number>.

if [not] <string1>==<string2> <command> [else <expression>]
: <string>
:   > These values can be literal strings or batch variables.

if [not] exist <filename> <command> [else <expression>]

if [/i] <string1> <compareop> <string2> <command> [else <expression>]
: <CompareOp>
:   > EQU, NEQ, LSS, LEQ, GTR, GEQ
: /i
:   > Forces string comparisons to ignore case.

if cmdextversion <number> <command> [else <expression>]
: cmdextversion <number>
:   > Specifies a true condition only if the internal version number associated with the command extensions feature of Cmd.exe is equal to or greater than the number specified.

if defined <variable> <command> [else <expression>]
```

## Reference

* [Windows Commands](https://docs.microsoft.com/ko-kr/windows-server/administration/windows-commands/windows-commands)
