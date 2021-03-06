context("vectors")

test_that("different vector types work", {
  
  expect_equal(as.character(to_json(c(1L:5L))), "[1,2,3,4,5]")                         # integer
  expect_equal(as.character(to_json(c(1.0,2.1,3.2))), "[1.0,2.1,3.2]")                 # numeric
  expect_equal(as.character(to_json(letters[1:5])), "[\"a\",\"b\",\"c\",\"d\",\"e\"]") # character
  expect_equal(as.character(to_json(c(T,F,T,F))), "[true,false,true,false]")
  expect_equal(as.character(to_json(as.Date("2018-01-01"))), "[17532.0]")
  expect_equal(as.character(to_json(as.Date("2018-01-01"), numeric_dates = F)), "[\"2018-01-01\"]")
  expect_equal(as.character(to_json(as.POSIXct("2018-01-01 01:00:00", tz = "GMT"))), "[1514768400.0]")
  expect_equal(as.character(to_json(as.POSIXct("2018-01-01 01:00:00", tz = "GMT"), numeric_dates = F)), "[\"2018-01-01 01:00:00\"]")
  expect_equal(as.character(to_json(as.POSIXlt("2018-01-01 01:00:00", tz = "GMT"))), "{\"sec\":[0.0],\"min\":[0],\"hour\":[1],\"mday\":[1],\"mon\":[0],\"year\":[118],\"wday\":[1],\"yday\":[0],\"isdst\":[0]}")
  expect_equal(as.character(to_json(as.POSIXct("2018-01-01 01:00:00", tz = "GMT"), numeric_dates = F)), "[\"2018-01-01 01:00:00\"]")
  expect_equal(as.character(to_json(complex(1))),"[\"0+0i\"]")
  ## Numeric dates not implemented for lists
  expect_equal(as.character(to_json( list(x = as.Date("2018-01-01") ), numeric_dates = F)), '{"x":[17532.0]}')
  expect_equal(as.character(to_json( list(x = as.Date("2018-01-01") ), numeric_dates = T)), '{"x":[17532.0]}')
})

test_that("NAs, NULLS and Infs work", {
  expect_equal(as.character(to_json( NA )), "[null]")
  expect_equal(as.character(to_json( NA_character_ )), "[null]")
  expect_equal(as.character(to_json( NA_complex_ )), "[null]")
  expect_equal(as.character(to_json( NA_integer_ )), "[null]")
  expect_equal(as.character(to_json( NA_real_ )), "[null]")
  expect_equal(as.character(to_json( NaN )), "[null]")
  expect_equal(as.character(to_json( Inf )), "[\"Inf\"]")
  expect_equal(as.character(to_json( -Inf )), "[\"-Inf\"]")
  expect_equal(as.character(to_json(NULL)), "{}")
  expect_equal(as.character(to_json(list(a="a",b=NULL))),"{\"a\":[\"a\"],\"b\":{}}")
  expect_equal(as.character(to_json(data.frame())), "[]")
})

test_that("round trips with jsonlite work", {
  x <- c(1L, NA_integer_)
  expect_equal( jsonlite::fromJSON( to_json( x ) ), x)
  x <- c(1.0, NA_real_)
  expect_equal( jsonlite::fromJSON( to_json( x ) ), x)
  x <- c("1", NA_character_)
  expect_equal( jsonlite::fromJSON( to_json( x ) ), x)
  x <- c(T,F, NA)
  expect_equal( jsonlite::fromJSON( to_json( x ) ), x)
  x <- c(1, Inf, -Inf)
  expect_equal( jsonlite::fromJSON( to_json( x ) ), x)
  x <- list()
  expect_equal( jsonlite::fromJSON( to_json( x ) ), x)
})

## TODO( test list of all mixed types, inc Date, POSIXct and POSIXlt)

# lst <- list(x = as.Date("2018-01-01"), y = list(as.POSIXct("2018-01-01 10:00:00")), z = NA)
# as.character(to_json( lst, numeric_dates = T ))

