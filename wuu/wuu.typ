#import "/util.typ": cd, to-sandhi-pairs
#import "./wuu-data.typ": get-wuu-conter

#let shanghainese-tone-map = (
  "1": ((53,), (55, 21), (55, 33, 21), (55, 33, 33, 21), (55, 33, 33, 33, 21)),
  "5": ((34,), (33, 44), (33, 55, 21), (33, 55, 33, 21), (33, 55, 33, 33, 21)),
  "6": ((23,), (22, 44), (22, 55, 21), (22, 55, 33, 21), (22, 55, 33, 33, 21)),
  "7": ((55,), (33, 44), (33, 55, 21), (33, 55, 33, 21), (33, 55, 33, 33, 21)),
  "8": ((12,), (11, 23), (11, 22, 23), (11, 22, 22, 23), (22, 55, 33, 33, 21)),
)

#let fallback-tone-map = ((0,), (0, 0), (0, 0, 0), (0, 0, 0, 0), (0, 0, 0, 0, 0))

/// Convert Wugniu pronunciation with tone sandhi to `(pron, conter)` pairs.
#let wugniu-sandhi-converter(
  pron,
  tone-map: shanghainese-tone-map,
  /// one of the following values:
  /// 
  /// / `sh`: Shanghai			上海市區方言誌
  /// / `jd`: Jiading			嘉定方言研究
  /// / `sj`: Songjiang			松江方言研究
  /// / `cm`: Chongming			崇明方言研究
  /// / `cs`: Chuansha			上海地區方言調查研究 + 川沙方言同音字表 + 川沙縣誌
  /// / `sz`: Suzhou			蘇州方言語音研究
  /// / `ks`: Kunshan			吳氏：崑山方言研究 + 當代吳語研究
  /// / `yx`: Yixing			宜興方言同音字彙 + 宜興縣誌
  /// / `cz`: Changzhou			當代吳語研究
  /// / `jj`: Jingjiang			靖江縣誌
  /// / `jx`: Jiaxing			當代吳語研究
  /// / `tx`: Tongxiang			桐鄉方言誌
  /// / `hn`: Haining	海寧方言誌
  /// / `hy`: Haiyan			海鹽方言誌
  /// / `dq`: Deqing			德清縣誌 + 德清話聲韻調之研究
  /// / `hz`: Hangzhou			杭州方言音檔 + 杭州方言の聲調
  /// / `xs`: Xiaoshan			蕭山方言同音字彙 + 蕭山方言研究 + 蕭山市志
  /// / `sx`: Shaoxing			紹興方言研究
  /// / `cx`: Cixi				慈溪市誌 + 浙江慈溪方言聲調實驗研究
  /// / `nb`: Ningbo			當代吳語研究
  /// / `zs`: Zhoushan			舟山方言兩字組的連讀變調 + 舟山方言研究 + 舟山方言
  loc: none,
) = {
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

  let tone-scheme = if (loc == none and tone-map != none) {
    let tone-schemes = tone-map.at(tone-char, default: fallback-tone-map)
    let tone-scheme-char-count = calc.min(prons.len(), tone-schemes.len())
    tone-schemes.at(tone-scheme-char-count - 1)
  } else {
    if loc == none {
      loc = "sh"
    }
    let tone-key = str(prons.len()) + tone-char
    let full-tone-key = (
      tone-key
        + prons
          .enumerate()
          .map(((i, p)) => if i == 0 {
            ""
          } else {
            let res = p.match(regex("(\d)($|\\\)"))
            if res != none {
              res = res.captures.first()
            }
          })
          .join("")
    )
    let res = get-wuu-conter(loc, full-tone-key)
    if res == none {
      res = get-wuu-conter(loc, tone-key)
    }
    assert(res != none, message: "Cannot find conter " + tone-key + " or " + full-tone-key + " in loc " + loc)
    res
  }
  assert(tone-scheme != none, message: "Scheme not found for " + pron)


  while prons.len() > tone-scheme.len() {
    // dup -2nd item and insert it before -1st item
    tone-scheme.insert(-2, tone-scheme.at(-1))
  }
  assert(tone-scheme.len() == prons.len(), message: "tone-scheme length must be equal to prons length")

  prons
    .zip(tone-scheme)
    .map(((p, c)) => {
      let splitted = p.split("\\")
      if (splitted.len() > 1) {
        // manually marked, e.g. 8ge\11
        let conter = splitted.pop()
        return (splitted.join("\\"), conter)
      }
      (p, c)
    })
} /* returns (pron, conter) */

/// The wrapper for wugniu
/// -> content
#let wuu-wugniu(
  /// -> str
  zh,
  /// -> str
  pron,
  tone-map: shanghainese-tone-map,
  /// -> none | str
  loc: none,
  ..attrs,
) = {
  let pairs = to-sandhi-pairs(zh, pron).map(pair /* (zh, pron) */ => {
    let characters = pair.at(0).clusters()
    if pair.at(1) != none {
      let prons = wugniu-sandhi-converter(
        pair.at(1),
        tone-map: tone-map,
        loc: loc,
      )
      characters.zip(prons).map(((zi, (p, q))) => (zi, p, q))
    } else {
      pair.at(0)
    }
  })
  for ci in pairs {
    cd(ci, ..attrs)
  }
}
