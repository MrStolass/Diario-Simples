#!/bin/bash

MUSICA="musica.mp3"
OUTPUT="amv_final.mp4"

echo "✂️ Cortando episódios..."
ffmpeg -ss 00:02:30 -to 00:02:36 -i ep01.mp4 -c copy c01.mp4 -y
ffmpeg -ss 00:05:10 -to 00:05:16 -i ep02.mp4 -c copy c02.mp4 -y
ffmpeg -ss 00:12:00 -to 00:12:06 -i ep03.mp4 -c copy c03.mp4 -y
ffmpeg -ss 00:08:45 -to 00:08:51 -i ep04.mp4 -c copy c04.mp4 -y
ffmpeg -ss 00:03:20 -to 00:03:26 -i ep05.mp4 -c copy c05.mp4 -y
ffmpeg -ss 00:18:30 -to 00:18:36 -i ep06.mp4 -c copy c06.mp4 -y
ffmpeg -ss 00:07:00 -to 00:07:06 -i ep07.mp4 -c copy c07.mp4 -y
ffmpeg -ss 00:14:15 -to 00:14:21 -i ep08.mp4 -c copy c08.mp4 -y
ffmpeg -ss 00:09:50 -to 00:09:56 -i ep09.mp4 -c copy c10.mp4 -y
ffmpeg -ss 00:21:10 -to 00:21:16 -i ep10.mp4 -c copy c10.mp4 -y

echo "🔗 Juntando..."
echo "file 'c01.mp4'
file 'c02.mp4'
file 'c03.mp4'
file 'c04.mp4'
file 'c05.mp4'
file 'c06.mp4'
file 'c07.mp4'
file 'c08.mp4'
file 'c09.mp4'
file 'c10.mp4'" > lista.txt
ffmpeg -f concat -safe 0 -i lista.txt -c copy temp.mp4 -y

echo "🎵 Adicionando música..."
ffmpeg -i temp.mp4 -i $MUSICA \
  -map 0:v -map 1:a \
  -shortest -c:v copy $OUTPUT -y

echo "🧹 Limpando..."
rm c01.mp4 c02.mp4 c03.mp4 c04.mp4 c05.mp4 c06.mp4 c07.mp4 c08.mp4 c09.mp4 c10.mp4 lista.txt temp.mp4

echo "✅ AMV pronto: $OUTPUT"

