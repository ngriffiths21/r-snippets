library(tidyverse)

#' Find errors in purrr calls using safely

test_stop <- function (x) {   # example function where error occurs
  stopifnot(x == 4)
  x
}

mtcars %>%     # example map call leading to errors
  mutate(out = map(gear, safely(test_stop))) %>%
  select(out)
