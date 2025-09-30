typst compile fig1.typ fig1.png --ppi 660
typst compile lib.typ fig-example-{p}.png --ppi 360
cwebp fig1.png -m 6 -lossless -o fig1.webp
cwebp fig-example-1.png -m 6 -lossless -o fig-example-1.webp
cwebp fig-example-2.png -m 6 -lossless -o fig-example-2.webp
cwebp fig-example-3.png -m 6 -lossless -o fig-example-3.webp
cwebp fig-example-4.png -m 6 -lossless -o fig-example-4.webp
