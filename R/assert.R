#' assert a value can be cast to Date
#'
#' @param x the value to test
#'
#' @keywords internal
assert_date <- function(x) {
  if (!inherits(x, c("Date", "POSIXt"))) {
    res <- tryCatch({
      strftime(x)
    }, error = I)

    if (inherits(res, "error")) {
      stop(x, " can't be cast to a Date object!")
    }
  }
  TRUE
}

#' assert a value can be considered as a year
#'
#' @param x the value to test
#'
#' @keywords internal
assert_year <- function(x) {
  res <- tryCatch({
    suppressWarnings(as.numeric(x))
  }, error = I)

  if (inherits(res, "error") | any(is.na(res))) {
    stop(x, " is not a year!")
  }

  if (any(res < 2008) | any(res > 2018)) {
    stop("All elements of '", toString(x), "' should be between 2008 and 2018!")
  }

  TRUE
}

#' assert a value is a valid school holiday name
#'
#' @param x the value to test
#'
#' @keywords internal
assert_name <- function(x) {
  if (!x %in% c(.holidays_names, .short_holidays_names)) {
    stop("Valid holiday names are: ", toString(.holidays_names), " or ", toString(.short_holidays_names))
  }

  if (tolower(x) %in% .short_holidays_names) {
    idx <- which(.short_holidays_names == tolower(x))
    x   <- .holidays_names[idx]
  }
  x
}
