context("test-retrieve_search_results.R")

test_that("downloading a dataset from an 'advanced search' URL works", {

  # Searching for just some random name that results in very few strains
  Millers_strains <- purrr::map_chr(
    .x = retrieve_search_results(queryURL = "https://bacdive.dsmz.de/advsearch?site=advsearch&searchparams%5B78%5D%5Bcontenttype%5D=text&searchparams%5B78%5D%5Btypecontent%5D=contains&searchparams%5B78%5D%5Bsearchterm%5D=Miller&advsearch=search"),
    .f = ~ .x$taxonomy_name$strains_tax_PNU$species
  )

  # If this fails, update the test with the newly published strain(s)
  expect_equal(Millers_strains[[1]], "Borrelia mayonii")
  expect_equal(Millers_strains[[2]], "Bacillus wiedmannii")
})
