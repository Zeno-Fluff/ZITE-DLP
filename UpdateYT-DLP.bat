@echo off
setlocal

REM Get the folder where this script is located
set "basePath=%~dp0"
set "ytDlpPath=%basePath%yt-dlp.exe"

echo Updating yt-dlp.exe...

REM Download latest yt-dlp.exe from official source
curl -L https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp.exe -o "%ytDlpPath%"

echo Update complete.
exit