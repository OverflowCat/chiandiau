#import "util.typ": cd, to-scheme

#let cmn-pinyin-scheme = (
  none,
  55,
  35,
  214,
  53,
)

#let cmn-pinyin(zh, pron) = {
  let prons = pron.split(" ")
  let pairs = zh.clusters().zip(prons)
  cd(
    pairs,
    scheme: to-scheme(cmn-pinyin-scheme),
  )
}
