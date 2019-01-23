context("test-API-deprecation")

test_that("accessing old API results in deprecation warning", {
  expect_warning(
    retrieve_data(searchTerm = "717", searchType = "bacdive_id"),
    regexp = "deprecated"
  )
  expect_warning(
    retrieve_search_results(queryURL = "https://bacdive.dsmz.de/advsearch?site=advsearch&searchparams%5B78%5D%5Bcontenttype%5D=text&searchparams%5B78%5D%5Btypecontent%5D=contains&searchparams%5B78%5D%5Bsearchterm%5D=Miller&advsearch=search"),
    regexp = "deprecated"
  )
})
