#import "lib.typ": *
#set page(
  width: 1280pt / 2,
  height: 640pt / 2,
  margin: 50pt,
)

#set align(center)

#set text(10em, font: "Sart Sans")

#let w(z, p) = {
  wuu-wugniu(
    z,
    p,
    pron-font: "Sart Sans",
    pron-style: pron => {
      show regex("^\d+"): super
      show regex("\d+$"): sub
      pron
    },
  )
}

#w(
  "排版有",
  "6ba-pe5 6yeu",
)#set text(fill: color.teal.darken(20%));#w(
  "腔調",
  "1chian-diau6",
)
