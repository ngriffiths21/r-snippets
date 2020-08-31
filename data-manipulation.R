# recode from a lookup table
data = c("a", "b", "b")
lookup = list(a = "new a", b = "new b")
do.call(dplyr::recode, c(list(data), lookup))

# recode from a lookup dataframe
data = c("a", "b", "b")
lookup = data.frame(name = c("a", "b"), val = c("new a", "new b"))
do.call(recode, c(list(data), setNames(lookup$val, lookup$name)))
