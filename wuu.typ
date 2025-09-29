#import "util.typ": cd, to-sandhi-pairs
#set page("a6", margin: 1cm)

/*
注1：清声母去声式的二字调变化存在特例，阴去后接少部分阴去、阳去时，连续变调模式同阴平式的二字调（55＋21）。这是因为中古汉语的浊上归入去声。
*/
#let shanghainese-tone-map = (
  "1": ((53,), (55, 21), (55, 33, 21), (55, 33, 33, 21), (55, 33, 33, 33, 21)),
  "5": ((34,), (33, 44), (33, 55, 21), (33, 55, 33, 21), (33, 55, 33, 33, 21)),
  "6": ((23,), (22, 44), (22, 55, 21), (22, 55, 33, 21), (22, 55, 33, 33, 21)),
  "7": ((55,), (33, 44), (33, 55, 21), (33, 55, 33, 21), (33, 55, 33, 33, 21)),
  "8": ((12,), (11, 23), (11, 22, 23), (11, 22, 22, 23), (22, 55, 33, 33, 21)),
)
#let shanghainese-tone-scheme-max-len = 5

#let wugniu-sandhi-converter = pron => {
  if (pron == none) {
    return ((none, none),)
  }
  let tone-char = pron.first()
  // pron = pron.slice(1)
  let prons = pron
    .split("-")
    .enumerate()
    .map(
      ((i, p)) => if i > 0 { "-" + p } else { p },
    )
  let tone-schemes = shanghainese-tone-map.at(tone-char)
  let tone-scheme-char-count = calc.min(prons.len(), shanghainese-tone-scheme-max-len)
  let tone-scheme = tone-schemes.at(tone-scheme-char-count - 1)
  while prons.len() > tone-scheme.len() {
    // dup -2nd item and insert it before -1st item
    tone-scheme.insert(-2, tone-scheme.at(-1))
  }
  assert(tone-scheme.len() == prons.len(), message: "tone-scheme length must be equal to prons length")
  prons.zip(tone-scheme)
} /* returns (pron, conter) */

#let wuu-wugniu = (zh, pron) => {
  let pairs = to-sandhi-pairs(zh, pron).map(pair /* (zh, pron) */ => {
    let characters = pair.at(0).clusters()
    if pair.at(1) != none {
      let prons = wugniu-sandhi-converter(pair.at(1))
      characters.zip(prons).map(((zi, (p, q))) => (zi, p, q))
    } else {
      pair.at(0)
    }
  })
  for ci in pairs {
    cd(ci)
  }
}
