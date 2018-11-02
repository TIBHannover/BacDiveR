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

test_that("Inconsistent datasets get corrected", {
  inconsistent_data <- retrieve_search_results(
    "https://bacdive.dsmz.de/advsearch?advsearch=search&site=advsearch&searchparams[20][contenttype]=text&searchparams[20][typecontent]=contains&searchparams[20][searchterm]=Sea+of+Japan&searchparams[17][searchterm]=Europe"
  )

  expect_false(is.null(inconsistent_data))
})
