#!/bin/bash

function make_pdf_lighter {
gs -dNOPAUSE -dQUIET -dBATCH -sDEVICE=jpeg -sOutputFile=page-%03d.jpg -r300x300 -f "$1" && \
for x in page*; do
  ffmpeg -i "$x" -vf curves=preset=lighter b1.jpg && \
  ffmpeg -i b1.jpg -vf curves=preset=lighter b2.jpg && \
  ffmpeg -i b2.jpg -vf curves=preset=lighter b3.jpg && \
  mv b3.jpg _"$x" && \
  rm -f b1.jpg b2.jpg;
done &&
convert _page* result_"$1" &&
rm -f _page* page*
}

for x in *pdf; do make_pdf_lighter "$x"; done

