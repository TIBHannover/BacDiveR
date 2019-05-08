context("test-sanitise_input")

test_that("Searching with abbr. fails", {
  expect_error(sanitise_term("B. subtilis", "taxon"))
})

test_that("Taxon species is escaped to taxon/species", {
  expect_identical(sanitise_term("Bacillus subtilis", "taxon"), "Bacillus/subtilis")
})

test_that("Normal searchTerm is return without sanitation", {
  expect_identical(sanitise_term("Bacillus", "taxon"), "Bacillus")
})
