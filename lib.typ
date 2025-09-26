#set page("a5", margin: 1cm)
#set text(2em, lang: "zh", font: (
  "jf open 粉圓 2.1",
  "YuMincho",
))

#let to-scheme = scheme => {
  assert(type(scheme) == array, message: "scheme must be an array")
  return pron => {
    let digit = pron.match(regex("\d+"))
    if digit != none {
      let index = int(digit.text)
      scheme.at(index)
    } else {
      scheme.first()
    }
  }
}

#let tone(pron, conter, width: 1em, pron-size: .4em, pron-font: "jf open 粉圓 2.1", frac: .18em, debug: true) = {
  assert(width > 0em, message: "width must be greater than 0em")
  set line(length: width, stroke: rgb("ccc"))

  if debug {
    box(line())
    h(-width)
    box(move(line(), dy: -frac))
    h(-width)
    box(move(line(), dy: -frac * 2))
    h(-width)
    box(move(line(), dy: -frac * 3))
    h(-width)
    box(move(line(), dy: -frac * 4))
    h(-width)
  }

  let conter = str(conter)
  let dy = (int(conter.first()) - 1.5) * -frac
  let c = text(pron, pron-size, font: pron-font)
  if debug {
    c = underline(c)
  }
  if conter.len() == 2 and conter.at(0) == conter.at(1) {
    conter = conter.at(0)
  }
  if conter.len() == 1 {
    box(move(c, dy: dy))
  } else if conter.len() == 2 {
    let diff = int(conter.at(1)) - int(conter.at(0))
    context {
      let this-width = measure(c).width
      let w = ((this-width + width) / 2).to-absolute()
      let h = (diff * .2em).to-absolute()
      let deg = calc.atan(h / w)
      box(move(rotate(-deg, c, origin: left + bottom, reflow: false), dy: dy))
    }
  }
}

// #let view = (s, t) => tone(s, t, width: 1.3em, pron-size: .5em, pron-font: "HarmonyOS Sans")

// #view("fan1", 55)
// #view("fan2", 35)
// #view("fan3", 33)
// #view("fan4", 11)
// #view("fan5", 13)
// #view("fan6", 22)

#let cd(
  pairs,
  scheme: none,
  dir: direction.btt,
  pron-font: "jf open 粉圓 2.1",
  pron-size: .4em,
  debug: true,
) = context {
  set box(
    fill: if debug { rgb(150, 150, 50, 20) } else { rgb(0, 0, 0, 0) },
    stroke: if debug { rgb(250, 50, 0) + .6pt } else { none },
  )
  // set text(borde: if debug { rgb(50, 50, 250) + .5pt } else { none })
  let widest = measure("水").width
  for pair in pairs {
    if (type(pair) != array) {
      continue
    }
    let pron = pair.at(1)
    if pron != none {
      let width = (
        measure(
          text(pron, font: pron-font, size: pron-size),
        ).width
          * .92
      )
      if width > widest {
        widest = width
      }
    }
  }

  for pair in pairs {
    if (type(pair) != array) {
      pair
      continue
    }
    let (zi, pron, ..) = pair
    if pron == none {
      zi
      continue
    }
    assert(
      pair.len() == 3 or type(scheme) == function,
      message: "Either provide the tone conter in the pair, or provide a scheme function to convert the pron to the tone conter",
    )
    let conter = if pair.len() > 2 {
      pair.at(2)
    } else {
      scheme(pron)
    }
    let s = stack(dir: dir, spacing: .3em)[
      #set align(center)
      #box(zi, width: widest)
    ][
      #set align(center)
      #box(width: widest, tone(
        pron,
        conter,
        width: widest,
        pron-size: pron-size,
        pron-font: pron-font,
        debug: debug,
      ))
    ]
    box(width: widest, pad(
      top: .5em,
      s,
    ))
  }
}

#let to-pairs(zh, pron) = {
  let pairs = ()
  let prons = pron.split(regex("(\s|-)+"))
  let j = 0
  let prons-len = prons.len()

  for zi in zh {
    let pron = if zi.contains(regex("\p{Han}")) and j < prons-len {
      let res = prons.at(j)
      j += 1
      res
    } else {
      none
    }
    pairs.push((
      zi,
      pron,
    ))
  }

  pairs
}

#let to-sandhi-pairs(zh, pron, zi-counter: pron => pron.matches(regex("-+")).len() + 1) = {
  let prons = pron.split(regex("\s+")) // words
  let res = ()

  for pron in prons {
    let length = zi-counter(pron)
    let result = zh.match(regex("^(\P{Han}+)?(\p{Han}{" + str(length) + "})"))
    let (prefix, ci) = result.captures
    if (prefix != none and prefix != "") {
      res.push((prefix, none))
    }
    res.push((ci, pron))
    zh = zh.slice(result.end)
  }
  if zh != "" {
    res.push((zh, none))
  }
  res
}

#let nan-tone-extractor = pron => {
  // if pron.ends-with("-") {
  //   pron = pron.slice(0, -1)
  //   last-char = false
  // }
  if pron.contains("\u{030D}") {
    return 5
  } else if pron.match(regex("[hH](\b|-|$)")) != none {
    return 4
  }

  import "nan.typ": tone-map

  for char in pron /* .clusters() */ {
    if char in tone-map {
      return tone-map.at(char)
    }
  }
  return 1
}

#let nan-tone-map = (
  none, // 0 不定
  (44, 33), // 1 阴平
  (53, 44), // 2 阴上
  (11, 53), // 3 阴去
  (32, 4), // 4 阴入
  (24, 11), // 5 阳平
  (33, 11), // 6 阳上
  (33, 11), // 7 阴入
  (4, 32), // 8 阳入
)

#let nan-tone-sandhi = tone => {}

#assert(nan-tone-extractor("pe̍h-") == 5)
#let nan-sandhi-converter = pron => {
  if (pron == none) {
    return ((none, none),)
  }
  // \p{L} is not working for POJ
  let prons = ()
  let i = 0
  for (j, char) in pron.clusters().enumerate() {
    if char == "-" and j > i + 1 {
      prons.push(pron.clusters().slice(i, j + 1).join(""))
      i = j + 1
    }
  }
  // prons.push(pron.slice(i))
  prons.push(pron.clusters().slice(i).join(""))
  prons
    .enumerate()
    .map(((i, p)) => {
      let tone = nan-tone-extractor(p)
      let sandhi = i < prons.len() - 1
      let conter = nan-tone-map.at(tone).at(if sandhi { 1 } else { 0 })
      (p, conter)
    })
}

// #let r = "|'aaaa-bbb-ccc--ddd--eee.".matches(regex("(^\P{L}+)?-?\p{L}+-?(\P{L}+$)?"))

#let yue-jyutping-example = (
  "明月幾時有？把酒問青天。不知天上宮闕，今夕是何年。",
  "ming4 jyut6 gei2 si4 jau5 baa2 zau2 man6 cing1 tin1 bat1 zi1 tin1 soeng6 gung1 kyut3, gam1 zik6 si6 ho4 nin4",
)


// #set text(lang: "nan", script: "Latn")

#let yue-jyutping = (zh, pron) => {
  let pairs = to-pairs(zh, pron)
  cd(
    pairs,
    scheme: to-scheme((none, 55, 35, 33, 21, 23, 22)),
  )
}

#yue-jyutping(..yue-jyutping-example)

#let nan-tailo = (zh, pron) => {
  let pairs = to-pairs(zh, pron)
  cd(
    pairs,
    scheme: to-scheme((none, 55, 35, 33, 21, 23, 22)),
  )
}


#let wuu = ()

#let nan-tailo-examples = (
  (
    "一生一改　人間審判\n全身全霊　祝福　你活落來",
    "It-sinn tsi̍t-kái, jîn-kan sím-phuànn. ^Zen-shin-zen-re tsiok-hok, lí ua̍h--loh lai",
    // "poj": "It-sng chi̍t-kái, jîn-kan sím-phòaⁿ. oa̍h"
  ),
  (
    "𧿬踏兮過去　全攏想起\n等你最後共我牽牢　好無",
    "Thún-ta̍h ê kuè-khì, tsuân lóng siūnn-khí. Tán lí tsuè-āu kā guá khan-tiâu, hó--bô",
  ),
)

#let nan-tailo = (zh, pron) => {
  let pairs = to-sandhi-pairs(zh, pron).map(pair => {
    let characters = pair.at(0).clusters()
    if pair.at(1) != none {
      let prons = nan-sandhi-converter(pair.at(1))
      characters.zip(prons).map(((zi, (p, q))) => (zi, p, q))
    } else {
      pair.at(0)
    }
  })
  for ci in pairs {
    cd(ci)
  }
}

#nan-tailo(..nan-tailo-examples.at(0))

#nan-tailo(..nan-tailo-examples.at(1))
