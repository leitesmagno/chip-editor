#!/usr/bin/env bash
# Uso: ./marca_dagua.sh video_entrada.mp4 [video_saida.mp4]
# Adiciona a marca d'água "@eumagnoleite" com 14% de opacidade,
# andando pela tela e batendo nas bordas (estilo protetor de tela).
set -euo pipefail
IN="$1"
OUT="${2:-${IN%.*}_marca.mp4}"
FONT=/usr/share/fonts/truetype/dejavu/DejaVuSans-Bold.ttf
TEXTO='@eumagnoleite'
# Velocidades em pixels por segundo (diferentes para não repetir o trajeto)
VX=${VX:-70}; VY=${VY:-50}
TAM=${TAM:-52}  # tamanho: altura do vídeo dividida por TAM (maior = marca menor)
ffmpeg -y -i "$IN" -vf "drawtext=fontfile=${FONT}:text='${TEXTO}':fontcolor=white@0.14:fontsize=h/${TAM}:\
x='abs(mod(t*${VX}\,2*(w-tw))-(w-tw))':y='abs(mod(t*${VY}\,2*(h-th))-(h-th))'" \
  -c:v libx264 -preset medium -crf 18 -pix_fmt yuv420p -c:a copy -movflags +faststart "$OUT"
echo "Pronto: $OUT"
