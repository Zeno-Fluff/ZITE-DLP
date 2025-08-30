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
exit