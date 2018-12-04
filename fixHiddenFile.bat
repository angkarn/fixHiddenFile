@echo off
title Fix Hidden File  # tues.cc
echo.
Call :Color 6 "   Fix Hidden File" \n
Call :Color 0 "           # "
Call :Color C "tues.cc"
echo.
:: Pause >Nul

:start
set drive=[]
echo.
Call :Color B "Enter Drive to Fix (letter) "
set /P drive=: 
IF not defined drive goto :notDF
IF %drive%==[] goto :notDF
IF /I %drive%==%windir:~0,1% (goto :sysD) else (goto :checkHas)
goto EOF

:notDF
cls
echo.
Call :Color 6 "Please enter drive letter!" \n
goto :start

:sysD
cls
echo.
Call :Color 6 "Sorry, this system drive!" \n
goto :start

:proc
cls
echo.
cd %drive%:/project/a
cd %drive%:/
attrib *.* -h -s /s /d
if NOT ["%errorlevel%"]==["0"] (
    pause
    exit /b %errorlevel%
)
Call :Color B "Success!"
pause

:checkLast
cls
echo.
Call :Color c "Sure do this drive ?"
Call :Color a " (%drive%:)" \n 
set /P sure=(y/n): 
IF NOT DEFINED sure goto :check
IF %sure%==[] goto :check
IF /I %sure%== y (goto :proc) ELSE IF /I %sure%== n (goto :notS) ELSE (goto :check)

:checkHas
IF EXIST %drive%:\ (GOTO :checkLast) ELSE (GOTO :notHas)

:notHas
cls
echo.
Call :Color 6 "Sorry, Dont have this drive!" \n
goto :start

:notS
cls
goto :start

:Color
SetLocal EnableExtensions EnableDelayedExpansion
Set "Text=%~2"
If Not Defined Text (Set Text=^")
Subst `: "!Temp!" >Nul &`: &Cd \
If Not Exist `.7 (
Echo(|(Pause >Nul &Findstr "^" >`)
Set /P "=." >>` <Nul
For /F "delims=;" %%# In (
'"Prompt $H;&For %%_ In (_) Do Rem"') Do (
Set /P "=%%#%%#%%#" <Nul >`.3
Set /P "=%%#%%#%%#%%#%%#" <Nul >`.5
Set /P "=%%#%%#%%#%%#%%#%%#%%#" <Nul >`.7))
Set /P "LF=" <` &Set "LF=!LF:~0,1!"
For %%# in ("!LF!") Do For %%_ In (
\ / :) Do Set "Text=!Text:%%_=%%~#%%_%%~#!"
For /F delims^=^ eol^= %%# in ("!Text!") Do (
If #==#! SetLocal DisableDelayedExpansion
If \==%%# (Findstr /A:%~1 . \` Nul
Type `.3) Else If /==%%# (Findstr /A:%~1 . /.\` Nul
Type `.5) Else (Echo %%#\..\`>`.dat
Findstr /F:`.dat /A:%~1 .
Type `.7))
If "\n"=="%~3" (Echo()
Goto :Eof