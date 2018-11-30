context("test-retrieve_search_results.R")

test_that("Downloading a small 'advanced search' result works", {
  expect_type(
    retrieve_search_results(queryURL = "https://bacdive.dsmz.de/advsearch?site=advsearch&searchparams%5B78%5D%5Bcontenttype%5D=text&searchparams%5B78%5D%5Btypecontent%5D=contains&searchparams%5B78%5D%5Bsearchterm%5D=Miller&advsearch=search"),
    "list"
  )
})

test_that("Trying a stupid advanced search yields an empty list", {
  expect_equal(
    retrieve_search_results(queryURL = "https://bacdive.dsmz.de/advsearch?site=advsearch&searchparams%5B78%5D%5Bcontenttype%5D=text&searchparams%5B78%5D%5Btypecontent%5D=contains&searchparams%5B78%5D%5Bsearchterm%5D=ABCDEFG&advsearch=search"),
    list()
  )
})


queryURL <- "https://bacdive.dsmz.de/advsearch?advsearch=search&site=advsearch&searchparams[20][contenttype]=text&searchparams[20][typecontent]=contains&searchparams[20][searchterm]=Sea+of+Japan&searchparams[17][searchterm]=Europe"

test_that("Inconsistent datasets get corrected", {
  inconsistent_data <- retrieve_search_results(queryURL)
  expect_false(is.null(inconsistent_data))
})

test_that("Fuzzing of queryURL parameter produces error", {
  fuzzy_URL <-
    paste0(sample(strsplit(queryURL, "")[[1]], size = nchar(queryURL)), collapse = "")
  expect_error(retrieve_search_results(fuzzy_URL),
    regexp = "^This isn't an advanced search URL"
  )
})
