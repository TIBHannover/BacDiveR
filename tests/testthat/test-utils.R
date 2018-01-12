context("test-utils.R")

test_that("setting username & password works", {

  test_id <- "a.b@c.de"
  test_pw <- "xyz012"

  save_credential(type = "test_email", test_id, overwrite_existing = TRUE)
  save_credential(type = "test_password", test_pw, overwrite_existing = TRUE)
  expect_equal(get_credentials(test = TRUE),
               c(test_id, test_pw))

  expect_error(save_credential(type = "test_email", test_id))
  expect_error(save_credential(type = "test_password", test_pw))
})
