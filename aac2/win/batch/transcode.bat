SET LAMEEXE="../../lame.exe"
SET NEROAACEXE="../../neroaacenc.exe"
cd input
for %%f in (*.mp3) do (%LAMEEXE% --decode "%%f" & %NEROAACEXE% -2pass -hev2 -ignorelength -br 160000 -if "%%~nf.wav" -of "%%~nf.mp4" & del "%%~nf.wav") & MOVE "%%~nf.mp4" "../output/%%~nf.mp4";
