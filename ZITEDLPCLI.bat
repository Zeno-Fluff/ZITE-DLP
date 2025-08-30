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
echo  \_______\/\________\/   \__\/    \_____\/     \____/_/ \_____\/ \_\/ ZITE YT-DLP INTERFACE V1.2
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
echo 10 OPUS Audio
echo  ---others---
echo 11. Update YT-DLP
echo 12. Update ZITE-DLP
echo 13.  Help / Info
echo 14.    Debug
echo.
set /p choice=Select (1-14): 


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
if "%choice%"=="11" set format=UpdateYT-DLP
if "%choice%"=="11" start "" "%format%.bat"
if "%choice%"=="11" goto menu


	
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

set /p link=Paste video/audio/playlist link: 

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
    pause
    goto menu
) else (
    echo %link% > links.txt
    echo Link valid.
    echo.
    echo Your files will be in the "downloaded" folder in the YT-DLP folder
    echo.
    start "" "%format%.bat"
)

echo.
set /p restart=Do you want to run another download? (Y/N): 
if /i "%restart%"=="Y" goto menu
exit


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
echo You can also skip the interface:
echo - Paste your link into links.txt
echo - Run the corresponding batch file manually
echo   (e.g., RVDMP4.bat for MP4 video)
echo.
echo Cookies:
echo Make sure to put your cookies.txt in the 
echo YT-DLP folder!
echo ----------------------------\
echo ZITE-DLP made by Zeno Fluff!  \
echo ===================== HELP =====================
echo.
pause
goto menu

:Debug
setlocal enabledelayedexpansion
echo ===================== DEBUG =====================
echo --------------- ZITE DLP --------------------
echo Zite-Dlp Version 1.2
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
pause
goto menu