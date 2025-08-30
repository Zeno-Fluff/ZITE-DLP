@echo off
setlocal

echo Updating ZITE DLP...


set "BaseFolder=%~dp0"
set "TargetFolder=%BaseFolder%yt-dlp"
set "ZipPath=%TEMP%\yt-dlp.zip"


echo Removing old yt-dlp folder...
rmdir /s /q "%TargetFolder%"


echo Downloading latest version...
curl -L https://github.com/Zeno-Fluff/ZITE-DLP/releases/latest/download/yt-dlp.zip -o "%ZipPath%"


echo Extracting new yt-dlp folder...
powershell -Command "Expand-Archive '%ZipPath%' '%BaseFolder%'"


del "%ZipPath%"


echo Launching ZITE DLP CLI...
start "" "%BaseFolder%yt-dlp\ZITEDLPCLI.bat"

echo Update complete.
exit