#set page("a5")
#set text(2em, lang: "zh", font: (
  "SF Compact Rounded",
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

#let tone(pron, conter, width: 1em, pron-size: .4em, pron-font: "SF Compact Rounded", frac: .18em, debug: false) = {
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
  pron-font: "HarmonyOS Sans",
  pron-size: .4em,
  debug: false,
) = context {
  set box(
    fill: if debug { rgb(150, 150, 50, 20) } else { rgb(0, 0, 0, 0) },
    stroke: if debug { rgb(250, 50, 0) + .6pt } else { none },
  )
  // set text(borde: if debug { rgb(50, 50, 250) + .5pt } else { none })
  let widest = 0em
  for pair in pairs {
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
    let (zi, pron) = pair
    if pron == none {
      zi
      continue
    }
    assert(
      pair.len() == 3 or type(scheme) == function,
      message: "Either provide the tone conter in the pair, or provide a scheme function to convert the pron to the tone conter",
    )
    let conter = pair.at(2, default: scheme(pron))
    let s = stack(dir: dir, spacing: .2em)[
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
