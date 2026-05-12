#!/bin/bash
export LANG=C

MUSICA="musica.mp3"
OUTPUT="amv_final.mp4"
WORKDIR="./tmp_amv"

mkdir -p $WORKDIR

# Timestamps da MUSICA (quando cortar na edição)
BEATS=(
  0.65 1.11 1.58 2.04 2.51 3.00 3.44 3.92 4.34 4.81
  5.27 5.74 6.20 6.66 7.13 7.57 8.03 8.50 8.96 9.43
  9.87 10.33 10.80 11.26 11.73 12.19 12.65 13.12 13.58 14.05
  14.49 14.95 15.42 15.88 16.35 16.79 17.25 17.72 18.18 18.65
  19.11 19.57 20.04 20.48 20.94 21.41 21.87 22.36 22.80 23.27
  23.73 24.20 24.66 25.12 25.59 26.08 26.49 26.96 27.42 27.89
  28.35 28.82 29.28 29.72 30.19 30.65 31.11 31.58 32.04 32.51
  32.97 33.44 33.88 34.34 34.81 35.27 35.74 36.20 36.66 37.11
  37.57 38.03 38.50 38.96 39.40 39.87 40.33 40.82 41.26 41.73
  42.19 42.66 43.12 43.58 44.03 44.51 44.95 45.40 45.86 46.30
  46.76 47.25 47.72 48.18 48.65 49.11 49.57 50.04 50.50 50.94
  51.41 51.87 52.34 52.80 53.27 53.71 54.08 54.45 54.89 55.36
  55.82 56.26 56.73 57.19 57.66 58.12 58.56 59.03 59.49 59.95
)

# Vídeos
VIDEOS=(
  v01.mp4 v02.mp4 v03.mp4 v04.mp4 v05.mp4
  v06.mp4 v07.mp4 v08.mp4 v09.mp4 v10.mp4
  v11.mp4 v12.mp4 v13.mp4 v14.mp4 v15.mp4
  v16.mp4 v17.mp4 v18.mp4 v19.mp4 v20.mp4
)

# Onde começa o trecho dentro de cada episódio (em segundos)
# Espalhados por momentos variados — evita sempre pegar o início
EP_START=(
  245.0  780.5  123.0  1050.3  430.7
  890.2   67.5  1200.0  560.8   340.1
  1010.5  175.3  720.0   480.6  1100.2
   95.0   640.4  900.7   310.5  1280.0
)
EP_START=(
  850.4  1114.7  1076.1  1032.8  1206.0  196.4  681.3  1228.5  183.4  838.8
  1098.2  813.7  1060.4  906.8  774.0  299.0  1193.2  97.6  488.1  1001.0
  523.1  765.5  1115.4  399.9  171.0  686.1  583.9  837.6  119.3  208.2
  103.4  717.4  415.2  516.9  914.3  891.0  220.5  1117.3  1255.5  933.2
  1037.0  398.2  1097.1  1257.1  281.2  856.9  979.9  157.8  483.8  626.9
  839.9  358.0  198.5  345.8  727.6  982.1  833.8  881.7  439.2  1185.9
  532.9  143.6  351.2  397.4  290.2  598.7  1160.0  1140.5  402.2  271.9
  718.3  779.4  943.1  459.1  802.5  824.1  164.3  322.6  710.5  1197.9
  1063.0  145.1  1133.9  534.0  1226.2  190.2  362.4  802.7  557.3  1157.8
  121.0  1209.9  402.4  449.8  112.8  1247.7  709.1  458.2  1016.7  347.9
  403.3  203.2  741.6  346.6  735.9  1177.0  997.9  1118.1  986.0  951.7
  90.7  268.8  191.7  746.8  218.3  124.9  838.1  469.3  240.2  796.4
  336.8  552.9  411.8  428.6  583.6  1081.6  943.8  1034.3  1108.5  675.7
)
TOTAL=${#BEATS[@]}
NVIDS=${#VIDEOS[@]}

echo "Gerando $TOTAL cortes sincronizados com as batidas..."
> lista.txt

for (( i=0; i<$TOTAL; i++ )); do
  BEAT_START=${BEATS[$i]}

  if [ $i -lt $(( TOTAL - 1 )) ]; then
    NEXT=${BEATS[$((i+1))]}
    DUR=$(awk "BEGIN {printf \"%.2f\", $NEXT - $BEAT_START}")
  else
    DUR="0.50"
  fi

  IDX=$((i % NVIDS))
  VID=${VIDEOS[$IDX]}
  EP_SS=${EP_START[$i]}

  OUTFILE="$WORKDIR/corte_$(printf '%03d' $i).mp4"

  echo "Corte $((i+1))/$TOTAL — $VID @ ep:${EP_SS}s | dur:${DUR}s"

ffmpeg -ss $EP_SS -t $DUR -i "$VID" \
    -vf "scale=1920:1080:force_original_aspect_ratio=decrease,pad=1920:1080:-1:-1:color=black,
         fade=t=in:st=0:d=0.05:color=white,
         fade=t=out:st=$(awk "BEGIN {printf \"%.2f\", $DUR - 0.05}"):d=0.10:color=black" \
    -c:v libx264 -preset ultrafast -crf 18 -an \
    "$OUTFILE" -y -loglevel error

  echo "file '$OUTFILE'" >> lista.txt
done

echo "Juntando cortes..."
ffmpeg -f concat -safe 0 -i lista.txt -c copy $WORKDIR/video_sem_audio.mp4 -y -loglevel error

echo "Adicionando musica..."
ffmpeg -i $WORKDIR/video_sem_audio.mp4 -i "$MUSICA" \
  -map 0:v -map 1:a \
  -shortest -c:v copy -c:a aac \
  "$OUTPUT" -y -loglevel error

echo "Limpando..."
rm -rf $WORKDIR lista.txt

echo "Pronto! $OUTPUT"
