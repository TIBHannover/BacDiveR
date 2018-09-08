context("test-sanitise_input")

test_that("Searching for 'genus/species' works", {
  expect_equal(sanitise_input("Bacillus subtilis", "taxon"),
               "Bacillus/subtilis")
})

test_that("Searching with abbr. fails", {
  expect_error(sanitise_input("B. subtilis", "taxon"))
})
