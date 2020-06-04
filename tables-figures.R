#' Takes a numeric vector x and returns a string vector with format "1,234.5 (6.7%)",
#' where the percentage is of the sum of the vector. Useful for Table 1.
#'
add_pct <- function(x) {
  stringr::str_c(scales::number(x, big.mark = ","), " (",
        scales::percent(x / sum(x), accuracy = 0.1), ")")
}

#' Converts a numeric vector x to a string vector giving mean +/- sd
meanfun <- function (x) {
  str_c(round(mean(x), 1), " \u00b1 ", round(sd(x), 1))
}

#' Converts a numeric vector x to a string vector giving median [IQR]
medfun <- function (x) {
  str_c(round(median(x), 1), " [",
        round(quantile(x, 0.25), 1), ", ",
        round(quantile(x, 0.75), 1), "]")
}


#' When added to a ggplot, avoids y-axis breaks 2.5, 5, 7.5. Useful for histograms with y-axis ranges ~1-10.
#'
#' see https://stackoverflow.com/questions/15622001/how-to-display-only-integer-values-on-an-axis-using-ggplot2/61918026#61918026
#'
#' Note that the default for Q is c(1,5,2,2.5,4,3)
scale_y_continuous(breaks = scales::breaks_extended(Q = c(1, 5, 2, 4, 3)))
