@echo off
rem This file was created by pub v2.13.4.
rem Package: devtools
rem Version: 2.9.4
rem Executable: devtools
rem Script: devtools
if exist "C:\Users\Microsoft\AppData\Local\Pub\Cache\global_packages\devtools\bin\devtools.dart-2.13.4.snapshot" (
  dart "C:\Users\Microsoft\AppData\Local\Pub\Cache\global_packages\devtools\bin\devtools.dart-2.13.4.snapshot" %*
  rem The VM exits with code 253 if the snapshot version is out-of-date.
  rem If it is, we need to delete it and run "pub global" manually.
  if not errorlevel 253 (
    goto error
  )
  pub global run devtools:devtools %*
) else (
  pub global run devtools:devtools %*
)
goto eof
:error
exit /b %errorlevel%
:eof

