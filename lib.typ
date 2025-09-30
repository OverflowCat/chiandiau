#set page("a5", margin: .9cm, height: auto)
#set text(2em, lang: "zh", font: "jf open 粉圓 2.1")

#show heading: c => {
  pagebreak(weak: true)
  {
    set text(.7em, fill: green.darken(25%))
    c
  }
  show raw: set text(.5em)
  set align(right)
  v(-.5em)
  raw("#" + c.body.text + "(.., .., attrs)", lang: "typ", block: true)
  v(.5em)
}

#let trans = c => {
  set align(right)
  set par(spacing: .8em)
  set text(.45em, lang: "en", fill: black.lighten(35%), font: "Libertinus Serif")
  // v(-1em)
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

#import "wuu.typ": wuu-wugniu

#wuu-wugniu(
  "箇束花一生　逃弗出四季忒狹\n但高塔　總要塌", // （終）
  "8geh-soh7\55 1ho 7ih-san 6dau-veh-tsheh\21 5sy-ci 7theh 8ghaeh 6de 1kau-thaeh 1tson5-iau 7thaeh",
  // geh11 soh55 ho53 ih33 san44
  // dau22 veh55 tsheh21 sy33 ci44 theh55 ghaeh12
)

#trans[
  ...	Is but a cluster of flowers—escaping not the crushing of seasons

  That tower—is bound to collapse
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


// === `cmn-pinyin`

// #import "cmn.typ": cmn-pinyin
// #let cmn = (
//   "歸去來兮田園將蕪胡不歸既自以心為形役奚惆悵而獨悲",
//   "gui1 qu4 lai2 xi1! tian2 yuan2 jiang1 wu2 hu2 bu4 gui1? ji4 zi4 yi3 xin1 wei2 xing2 yi4, xi1 chou2 chang4 er2 du2 bei1?",
// )
// #cmn-pinyin(..cmn)
// #trans[
//   Ah, homeward bound I go!
//   Why not go home,

//   seeing that my field and garden with weeds are overgrown?

//   I have made my soul serf to my body:

//   why have vain regrets and mourn alone?
// ]

// #pagebreak()

=== `cmn-cyuc-congqin`

#import "cmn.typ": cmn-cyuc-sicuan

#[
  #show regex("(.+)/(.+)"): it => {
    cmn-cyuc-sicuan(..it.text.split("/").map(t => t.trim()), width: 1.2em)
  }

  映階碧草自春色，
  /yin4 jiai1 bi2 cao3 zi4 cuen1 xie2

  隔葉黃鸝空好音。
  /ge2 ye2 huang2 li2 kong1 hao3 yin1

  三顧頻煩天下計，
  /san1 gu4 pin2 fan2 tian1 xia4 ji4

  兩朝開濟老臣心。
  /liang3 cao2 kai1 ji1 lao3 cen2 xin1
]

#trans[
  In vain before the steps spring grass grows green and long,

  And amid the leaves golden orioles sing their song.

  Thrice the king visited him for the State's gains and pains;

  He served heart and soul the kingdom during two reigns.
]
