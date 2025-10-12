#import "@preview/tidy:0.4.3"
#let docs = tidy.parse-module(read("lib.typ"))
#tidy.show-module(docs, style: tidy.styles.default)

#let docs2 = tidy.parse-module(read("wuu/wuu.typ"), name: "wuu")
#tidy.show-module(docs2, style: tidy.styles.default)

#let docs3 = tidy.parse-module(read("nan.typ"), name: "nan")
#tidy.show-module(docs3, style: tidy.styles.default)

