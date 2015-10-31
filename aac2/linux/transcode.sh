for f in input/*.mp3 ; do lame --decode "$f"; done
for f in input/*.wav ; do neroAacEnc -2pass -hev2 -ignorelength -br 160000 -if "$f" -of "${f%.wav}.mp4"; done
for f in input/*.wav ; do rm "$f"; done
for f in input/*.mp4 ; do mv "$f" "./output"; done

