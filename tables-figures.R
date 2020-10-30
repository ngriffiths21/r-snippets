# Takes a numeric vector x and returns a string vector with format "1,234.5 (6.7%)",
# where the percentage is of the sum of the vector. Useful for Table 1.
#
add_pct <- function(x) {
  stringr::str_c(scales::number(x, big.mark = ",", accuracy = 1), " (",
                 scales::percent(x / sum(x), accuracy = 0.1), ")")
}

# Takes a variable name and a data frame, and tabulates categories using add_pct
cat_n_pct <- function (name, data) {
  dplyr::mutate(dplyr::count(data, !!rlang::sym(name)), n_pct = add_pct(n)) %>% 
    dplyr::select(-n)
}

# Takes a data frame of summary results and makes table 1
#
# Input should have one column per summary. The value of each column should be
# either a character vector to report a summary statistic, or a one-item list of
# a data frame containing the results of `cat_n_pct`.
#
# This matches the output of summarize:
#
# df %>% 
#   summarize(var1 = list(cat_n_pct(var1))) %>% 
#   arrange_tab1()
arrange_tab1 <- function (df) {
  map_dfr(1:ncol(df), to_long, df) %>% 
    rename(var = name, ` ` = val)
}

to_long <- function (i, df) {
  col <- df[[i]][[1]]
  if (is.data.frame(col)) {
    rows <- tibble(name = paste0("    ", col[[1]]), val = col[[2]])
    bind_rows(tibble(name = names(df)[i], val = NA), rows)
  } else {
    tibble(name = names(df)[i], val = col)
  }
}


# Converts a numeric vector x to a string vector giving mean +/- sd
meanfun <- function (x) {
  str_c(round(mean(x), 1), " \u00b1 ", round(sd(x), 1))
}

# Converts a numeric vector x to a string vector giving median [IQR]
medfun <- function (x) {
  str_c(round(median(x), 1), " [",
        round(quantile(x, 0.25), 1), ", ",
        round(quantile(x, 0.75), 1), "]")
}


# When added to a ggplot, avoids y-axis breaks 2.5, 5, 7.5. Useful for histograms with y-axis ranges ~1-10.
#
# see https://stackoverflow.com/questions/15622001/how-to-display-only-integer-values-on-an-axis-using-ggplot2/61918026#61918026
#
# Note that the default for Q is c(1,5,2,2.5,4,3)
scale_y_continuous(breaks = scales::breaks_extended(Q = c(1, 5, 2, 4, 3)))
