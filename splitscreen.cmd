REM ffmpeg.exe -i %1 -i %2 -filter_complex "[0:v]pad=iw*2:ih[int];[int][1:v]overlay=W/2:0[vid];[0:a][1:a]amix=inputs=2:duration=longest[aud]" -map "[vid]" -map "[aud]" -c:v libx264 -crf 23 -c:a aac -b:a 192k output.mp4

set SUFFIX=
set INPUT1="Egyptian Legacy Cello%SUFFIX%.mp4"
set INPUT1_VOLUME=1.0
set INPUT2=VID_20200527_193015%SUFFIX%.mp4
set INPUT2_VOLUME=0.8
set INPUT3=VID_20200527_193015%SUFFIX%.mp4
set INPUT3_VOLUME=0.8
set INPUT4=WIN_20200527_17_40_34_Pro%SUFFIX%.mp4 
set INPUT4_VOLUME=0.2

ffmpeg.exe -ss 00:00:08 -i %INPUT1% -ss 00:00:16 -i %INPUT2% -ss 00:00:16 -i %INPUT3% -ss 00:00:09.3 -i %INPUT4% -filter_complex "nullsrc=size=640x480 [base];[0:v] setpts=PTS-STARTPTS, scale=320x240 [upperleft];[1:v] setpts=PTS-STARTPTS, scale=320x240 [upperright];[2:v] setpts=PTS-STARTPTS, scale=320x240 [lowerleft];[3:v] setpts=PTS-STARTPTS, scale=320x240 [lowerright];[base][upperleft] overlay=shortest=1 [tmp1];[tmp1][upperright] overlay=shortest=1:x=320 [tmp2];[tmp2][lowerleft] overlay=shortest=1:y=240 [tmp3];[tmp3][lowerright] overlay=shortest=1:x=320:y=240;[0:a]volume=%INPUT1_VOLUME%,aformat=s16p[a0];[1:a]volume=%INPUT2_VOLUME%,aformat=s16p[a1];[2:a]volume=%INPUT3_VOLUME%,aformat=s16p[a2];[3:a]volume=%INPUT4_VOLUME%,aformat=s16p[a3];[a0][a1][a2][a3]amix=inputs=4:duration=longest[aud]" -map "[aud]" -c:v libx264 -crf 23 -c:a aac -b:a 192k output.mkv