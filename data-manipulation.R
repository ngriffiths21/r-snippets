# recode from a lookup table
lookup = list(a = "new a", b = "new b")
do.call(dplyr::recode, c(list(data), lookup))
