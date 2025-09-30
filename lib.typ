#set page("a5", margin: .7cm)
#set text(2em, lang: "zh", font: (
  "jf open 粉圓 2.1",
))

#show heading: set text(.7em)
#let trans = c => {
  show par: set block(spacing: .6em)
  set align(right)
  set text(.5em, lang: "en", fill: black.lighten(40%))
  v(-1em)
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

=== `wuu-wugniu`

#let wuu = (
  "新冠防護勿放鬆，上海市民有腔調",
  "1shin-kuoe 6vaon-wu 6veq8-faon-son 6zaon-he 6zy-min 6yeu 1chian-diau",
)

#import "wuu.typ": wuu-wugniu
#wuu-wugniu(..wuu)

#trans[
  Let’s stay vigilant of COVID prevention.

  Uphold model behavior as Shanghainese citizens.
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


=== `cmn-pinyin`

#import "cmn.typ": cmn-pinyin
#let cmn = (
  "歸去來兮田園將蕪胡不歸既自以心為形役奚惆悵而獨悲",
  "gui1 qu4 lai2 xi1! tian2 yuan2 jiang1 wu2 hu2 bu4 gui1? ji4 zi4 yi3 xin1 wei2 xing2 yi4, xi1 chou2 chang4 er2 du2 bei1?",
)
#cmn-pinyin(..cmn)
#trans[
  Ah, homeward bound I go!
  Why not go home,

  seeing that my field and garden with weeds are overgrown?

  I have made my soul serf to my body:

  why have vain regrets and mourn alone?
]
