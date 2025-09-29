#set page("a5", margin: 1cm)
#set text(2em, lang: "zh", font: (
  "jf open 粉圓 2.1",
  "YuMincho",
))
#show heading: set text(.7em)
#let trans = c => {
  show par: set block(spacing: .6em)
  set align(right)
  set text(.5em, lang: "en")
  c
}

=== `yue-jyutping`

#import "yue.typ": yue-jyutping

#let yue-jyutping-example = (
  "明月幾時有？把酒問青天。不知天上宮闕，今夕是何年。",
  "ming4 jyut6 gei2 si4 jau5 baa2 zau2 man6 cing1 tin1 bat1 zi1 tin1 soeng6 gung1 kyut3, gam1 zik6 si6 ho4 nin4",
)

#yue-jyutping(..yue-jyutping-example)

#trans[
  When will the full moon appear?

  Wine cup in hand, I ask the sky.

  I do not know what time of year

  'T would be tonight in the palace on high.
]

=== `nan-tailo`

#import "nan.typ": nan-tailo

#let nan-tailo-examples = (
  (
    "一生一改　人間審判\n全身全霊　祝福　你活落來",
    "It-sinn tsi̍t-kái, jîn-kan sím-phuànn. Ze̋n-shín-zén-re tsiok-hok, lí ua̍h--loh lai",
    // "poj": "It-sng chi̍t-kái, jîn-kan sím-phòaⁿ. oa̍h"
  ),
  (
    "𧿬踏兮過去　全攏想起\n等你最後共我牽牢　好無",
    "Thún-ta̍h ê kuè-khì, tsuân lóng siūnn-khí. Tán lí tsuè-āu kā guá khan-tiâu, hó--bô",
  ),
)


#nan-tailo(..nan-tailo-examples.at(0))

#nan-tailo(..nan-tailo-examples.at(1))

#trans[
  This once-in-a-lifetime judgment on earth,

  With every fiber of my being, I pray you survive.

  The defiled past—it all comes flooding back to me now.

  Will you hold my hand tight, at the very end?
]

=== `wuu-wugniu`

#let wuu = (
  "新冠防護勿放鬆，上海市民有腔調",
  "1shin-guoe 6vaon-wu 8veq-faon-son 6zaon-he 6zy-min 6yeu 1chian-diau",
)

#import "wuu.typ": wuu-wugniu
#wuu-wugniu(..wuu)

#trans[
  Let’s stay vigilant of our COVID measures.

  Let us Shanghainese citizens stay super.
]
