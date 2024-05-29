@echo off
if not exist winpe_image\media\sources\boot.wim goto no_boot.wim_error
dism /cleanup-wim
rmdir build /s /q
mkdir build
xcopy /herky winpe_image\* build\
xcopy /E /Y "Boot\*" "%cd%\build\media"
del "%cd%\build\mount\readme.txt"
dism /Mount-Image /ImageFile:"%cd%\build\media\sources\boot.wim" /index:1 /MountDir:"%cd%\build\mount"
xcopy /E /Y "Scripts\*" "%cd%\build\mount\"
xcopy "%cd%\build\mount\Windows\Boot\EFI\bootmgr.efi" "%cd%\build\media\bootmgr.efi" /Y
xcopy "%cd%\build\mount\Windows\Boot\EFI\bootmgfw.efi" "%cd%\build\media\EFI\Boot\bootx64.efi" /Y
dism /Unmount-Image /MountDir:"%cd%\build\mount" /commit
set BOOTDATA=2#p0,e,b"build\fwfiles\etfsboot.com"#pEF,e,b"build\fwfiles\efisys.bin"
ms_oscdimg -bootdata:%BOOTDATA% -u1 -udfver102 "build\media" "build\AXSYS.iso"
xcopy "%cd%\build\AXSYS.iso" "AX-SYS.iso" /Y /-I
rmdir "%cd%\build" /s /q
goto finish

:no_boot.wim_error
echo ERROR: boot.wim missing! (Download from latest release)
goto finish

:finish
pause
echo on