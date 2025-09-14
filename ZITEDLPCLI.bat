@echo off
chcp 65001 >null
setlocal enabledelayedexpansion

::Haii :3

:menu
cls
echo  ______    ______   ________   ______       ______   __       ______    
echo /_____/\ /_______/\/________/\/_____/\     /_____/\ /_/\     /_____/\   
echo \:::__\/ \__.::._\/\__.::.__\/\::::_\/_    \:::_ \ \\:\ \    \:::_ \ \  
echo    /: /     \::\ \    \::\ \   \:\/___/\    \:\ \ \ \\:\ \    \:(_) \ \ 
echo   /::/___   _\::\ \__  \::\ \   \::___\/_    \:\ \ \ \\:\ \____\: ___\/ 
echo  /_:/____/\/__\::\__/\  \::\ \   \:\____/\    \:\/. , ,\:\/___/\\ \ \   Made by Zeno Fluff
echo  \_______\/\________\/   \__\/    \_____\/     \____/_/ \_____\/ \_\/ ZITE YT-DLP INTERFACE V1.4
echo.
echo ==========================================================\
echo   %date%   welcome to ZITE-DLP please select below
echo ==========================================================/
echo   YT-DLP format configurator    /
echo ===============================/
echo.
echo 1. MP4 Video
echo 2. MKV Video
echo 3. MOV Video
echo 4. WEBM Video
echo 5. MP3 Audio
echo 6. FLAC Audio
echo 7. WAV Audio
echo 8. OGG Audio
echo 9. M4A Audio
echo 10. OPUS Audio
echo  ---others---
echo 11. Update YT-DLP
echo 12. Update ZITE-DLP
echo 13.  Help / Info
echo 14.    Debug
echo.
set /p choice=Select (1-14): 
if /i "%choice%"=="exit" del /f /q cookies.txt 
if /i "%choice%"=="exit" echo. > links.txt
if /i "%choice%"=="exit" exit

if "%choice%"=="1" set format=RVDMP4
if "%choice%"=="2" set format=RVDMKV
if "%choice%"=="3" set format=RVDMOV
if "%choice%"=="4" set format=RVDWEBM
if "%choice%"=="5" set format=RADMP3
if "%choice%"=="6" set format=RADFLAC
if "%choice%"=="7" set format=RADWAV
if "%choice%"=="8" set format=RADOGG
if "%choice%"=="9" set format=RADM4A
if "%choice%"=="10" set format=RADOPUS
if "%choice%"=="11" start "" "UpdateYT-DLP.bat"
if "%choice%"=="11" goto menu
::if /i "%choice%"=="test" goto TEST

	
if "%choice%"=="13" goto help
if "%choice%"=="14" goto debug

if "%choice%"=="12" (
 pushd "%~dp0.."
start "" "ZITEDLP-UPDATER.bat"
popd
exit
)

if not defined format (
    echo Invalid choice. Try again.
    pause
    goto menu
)

)


set /p link=Paste Paste video/audio/playlist link:
if /i "%choice%"=="exit" echo. > cookies.txt 
if /i "%choice%"=="exit"  del /f /q links.txt
if /i "%choice%"=="exit" exit


set "basePath=%~dp0"
set "ffmpegPath=%basePath%ffmpeg"

echo Checking link...
yt-dlp.exe --simulate --ffmpeg-location "%ffmpegPath%" --cookies "cookies.txt" "%link%" > log.txt 2>&1


if errorlevel 1 (
    echo.
    echo Invalid or unsupported link. Please try again.
    pause
    goto menu
)


findstr /C:"WARNING: [youtube] The provided YouTube account cookies are no longer valid. They have likely been rotated in the browser as a security measure. For tips on how to effectively export YouTube cookies, refer to  https://github.com/yt-dlp/yt-dlp/wiki/Extractors#exporting-youtube-cookies" log.txt >nul
if %errorlevel%==0 (
    echo.
    echo your Cookies were rotated by youtube. Deleting cookies.txt...
    del /f /q cookies.txt
    echo Please try again.
    goto ENDRSTART
) else (
    echo %link% > links.txt
    echo Link valid.
    echo.
    echo Your files will be in the "downloaded" folder in the YT-DLP folder
    echo.
    goto %format%
)

echo.


:Help
echo ===================== HELP =====================
echo This is ZITE DLP — a lightweight CLI for yt-dlp
echo.
echo How to use:
echo - Choose a format from the menu
echo - Paste your link when prompted
echo - Your file will be saved in the 'downloaded' folder
echo.
echo Format codes:
echo RVD = Run Video Download
echo RAD = Run Audio Download
echo.
echo Downloads:
echo ZITE-DLP can only download one playlist, one video,
echo or one audio download, at a time you can put mutiple
echo videos in a playlist to download mutiple files.
echo.
echo Cookies:
echo ZITE-DLP will automatically delete your cookies
echo upon exit and will grab them upon download.
echo ----------------------------\
echo ZITE-DLP made by Zeno Fluff!  \
echo ===================== HELP =====================
echo.

goto ENDRSTART

:Debug
setlocal enabledelayedexpansion
echo ===================== DEBUG =====================
echo --------------- ZITE DLP --------------------
echo Zite-Dlp Version 1.4
echo support for 10 formats
echo OS Support windows 10 and 11
echo --------------- ZITE DLP --------------------
echo.
echo --------------- System ----------------------
echo GPU:
wmic path win32_VideoController get name
echo CPU:
wmic cpu get name, maxclockspeed, numberofcores, numberoflogicalprocessors
echo RAM:
wmic memorychip get capacity
echo system info:
systeminfo | findstr /B /C:"OS Name" /C:"OS Version" /C:"System Type" /C:"Processor"
echo --------------- System ----------------------
echo.
echo --------------- YT DLP ----------------------
echo Testing yt-dlp...
echo yt-dlp version-
yt-dlp --version
if exist yt-dlp.exe (
    echo yt-dlp.exe found
) else (
    echo yt-dlp.exe missing!
)
echo --------------- YT DLP ----------------------
echo.
echo --------------- Links  ----------------------
if exist links.txt (
    echo links.txt exists
    echo Contents:
    type links.txt
) else (
    echo links.txt not found
)
echo --------------- Links ----------------------
echo.
echo --------------- FFmpeg ---------------------

set "ffmpegPath=%~dp0ffmpeg"


if exist "%ffmpegPath%\ffmpeg.exe" (
    echo ffmpeg.exe found
    "%ffmpegPath%\ffmpeg.exe" -version
) else (
    echo ffmpeg.exe missing!
)

echo.

if exist "%ffmpegPath%\ffprobe.exe" (
    echo ffprobe.exe found
    "%ffmpegPath%\ffprobe.exe" -version
) else (
    echo ffprobe.exe missing!
)

echo --------------- FFmpeg ---------------------
echo.
echo --------------- Cookies --------------------
setlocal enabledelayedexpansion
if exist cookies.txt (
    echo cookies.txt found
    set cookieCount=0
    for /f "usebackq tokens=*" %%A in ("cookies.txt") do (
        if not "%%A"=="" set /a cookieCount+=1
    )
    echo Total cookies: !cookieCount!
) else (
    echo cookies.txt not found
)
endlocal
echo --------------- Cookies --------------------




echo ===================== DEBUG =====================

goto ENDRSTART


::formats

:RVDMP4
@echo off
setlocal enabledelayedexpansion


set "basePath=%~dp0"


set "ffmpegPath=%basePath%ffmpeg"
set "cookiesFile=%basePath%cookies.txt"
set "downloadDir=%basePath%downloaded"
set "linkFile=%basePath%links.txt"
set "ytDlpExe=%basePath%yt-dlp.exe"

cd /d "%downloadDir%"


for /f "usebackq delims=" %%A in ("%linkFile%") do (
    "%ytDlpExe%" -f bestvideo+bestaudio --no-part --no-continue --recode-video mp4 --ffmpeg-location "%ffmpegPath%" --cookies "%cookiesFile%" %%A
)

timeout /t 10 >nul
goto ENDRSTART

:RVDMKV
@echo off
setlocal enabledelayedexpansion


set "basePath=%~dp0"


set "ffmpegPath=%basePath%ffmpeg"
set "cookiesFile=%basePath%cookies.txt"
set "downloadDir=%basePath%downloaded"
set "linkFile=%basePath%links.txt"
set "ytDlpExe=%basePath%yt-dlp.exe"

cd /d "%downloadDir%"


for /f "usebackq delims=" %%A in ("%linkFile%") do (
    "%ytDlpExe%" -f bestvideo+bestaudio --no-part --no-continue --recode-video mkv --ffmpeg-location "%ffmpegPath%" --cookies "%cookiesFile%" %%A
)

timeout /t 10 >nul
goto ENDRSTART

:RVDMOV
@echo off
setlocal enabledelayedexpansion


set "basePath=%~dp0"


set "ffmpegPath=%basePath%ffmpeg"
set "cookiesFile=%basePath%cookies.txt"
set "downloadDir=%basePath%downloaded"
set "linkFile=%basePath%links.txt"
set "ytDlpExe=%basePath%yt-dlp.exe"

cd /d "%downloadDir%"


for /f "usebackq delims=" %%A in ("%linkFile%") do (
    "%ytDlpExe%" -f bestvideo+bestaudio --no-part --no-continue --recode-video mov --ffmpeg-location "%ffmpegPath%" --cookies "%cookiesFile%" %%A
)

timeout /t 10 >nul
goto ENDRSTART

:RVDWEBM
@echo off
setlocal enabledelayedexpansion


set "basePath=%~dp0"


set "ffmpegPath=%basePath%ffmpeg"
set "cookiesFile=%basePath%cookies.txt"
set "downloadDir=%basePath%downloaded"
set "linkFile=%basePath%links.txt"
set "ytDlpExe=%basePath%yt-dlp.exe"

cd /d "%downloadDir%"


for /f "usebackq delims=" %%A in ("%linkFile%") do (
    "%ytDlpExe%" -f bestvideo+bestaudio --no-part --no-continue --recode-video webm --ffmpeg-location "%ffmpegPath%" --cookies "%cookiesFile%" %%A
)

timeout /t 10 >nul
goto ENDRSTART

:RADMP3
@echo off
setlocal enabledelayedexpansion

set "basePath=%~dp0"


set "ffmpegPath=%basePath%ffmpeg"
set "cookiesFile=%basePath%cookies.txt"
set "downloadDir=%basePath%downloaded"
set "linkFile=%basePath%links.txt"
set "ytDlpExe=%basePath%yt-dlp.exe"

cd /d "%downloadDir%"


for /f "usebackq delims=" %%A in ("%linkFile%") do (
    "%ytDlpExe%" -x --no-part --no-continue --audio-format mp3 --ffmpeg-location "%ffmpegPath%" --cookies "%cookiesFile%" %%A
)

timeout /t 10 >nul
goto ENDRSTART

:RADFLAC
@echo off
setlocal enabledelayedexpansion


set "basePath=%~dp0"


set "ffmpegPath=%basePath%ffmpeg"
set "cookiesFile=%basePath%cookies.txt"
set "downloadDir=%basePath%downloaded"
set "linkFile=%basePath%links.txt"
set "ytDlpExe=%basePath%yt-dlp.exe"

cd /d "%downloadDir%"

for /f "usebackq delims=" %%A in ("%linkFile%") do (
    "%ytDlpExe%" -x --no-part --no-continue --audio-format flac --ffmpeg-location "%ffmpegPath%" --cookies "%cookiesFile%" %%A
)

timeout /t 10 >nul
goto ENDRSTART

:RADWAV
@echo off
setlocal enabledelayedexpansion


set "basePath=%~dp0"


set "ffmpegPath=%basePath%ffmpeg"
set "cookiesFile=%basePath%cookies.txt"
set "downloadDir=%basePath%downloaded"
set "linkFile=%basePath%links.txt"
set "ytDlpExe=%basePath%yt-dlp.exe"

cd /d "%downloadDir%"


for /f "usebackq delims=" %%A in ("%linkFile%") do (
    "%ytDlpExe%" -x --no-part --no-continue --audio-format wav --ffmpeg-location "%ffmpegPath%" --cookies "%cookiesFile%" %%A
)

timeout /t 10 >nul
goto ENDRSTART

:RADOGG
@echo off
setlocal enabledelayedexpansion


set "basePath=%~dp0"


set "ffmpegPath=%basePath%ffmpeg"
set "cookiesFile=%basePath%cookies.txt"
set "downloadDir=%basePath%downloaded"
set "linkFile=%basePath%links.txt"
set "ytDlpExe=%basePath%yt-dlp.exe"

cd /d "%downloadDir%"


for /f "usebackq delims=" %%A in ("%linkFile%") do (
    "%ytDlpExe%" -x --no-part --no-continue --audio-format wav --ffmpeg-location "%ffmpegPath%" --cookies "%cookiesFile%" %%A
)


for %%F in (*.wav) do (
    "%ffmpegPath%\ffmpeg.exe" -i "%%F" "%%~nF.ogg"
    del "%%F"
)

timeout /t 10 >nul
goto ENDRSTART

:RADM4A
@echo off
setlocal enabledelayedexpansion

set "basePath=%~dp0"


set "ffmpegPath=%basePath%ffmpeg"
set "cookiesFile=%basePath%cookies.txt"
set "downloadDir=%basePath%downloaded"
set "linkFile=%basePath%links.txt"
set "ytDlpExe=%basePath%yt-dlp.exe"

cd /d "%downloadDir%"


for /f "usebackq delims=" %%A in ("%linkFile%") do (
    "%ytDlpExe%" -x --no-part --no-continue --audio-format m4a --ffmpeg-location "%ffmpegPath%" --cookies "%cookiesFile%" %%A
)

timeout /t 10 >nul
goto ENDRSTART

:RADOPUS
@echo off
setlocal enabledelayedexpansion

set "basePath=%~dp0"


set "ffmpegPath=%basePath%ffmpeg"
set "cookiesFile=%basePath%cookies.txt"
set "downloadDir=%basePath%downloaded"
set "linkFile=%basePath%links.txt"
set "ytDlpExe=%basePath%yt-dlp.exe"

cd /d "%downloadDir%"


for /f "usebackq delims=" %%A in ("%linkFile%") do (
    "%ytDlpExe%" -x --no-part --no-continue --audio-format opus --ffmpeg-location "%ffmpegPath%" --cookies "%cookiesFile%" %%A
)

timeout /t 10 >nul
goto ENDRSTART


:ENDRSTART
set "basePath=%~dp0"
set /p restart=Do you want to restart? (Y/N): 
timeout /t 2 >nul
if /i "%restart%"=="Y" start "" "%basepath%ZITEDLPCLI.bat" 
if /i "%restart%"=="Y" exit
else
echo. > "%basepath%cookies.txt"
exit

