context("test-sanitise_input")

test_that("Searching with abbr. fails", {
  expect_error(sanitise_term("B. subtilis"))
})
