context("test-utils.R")

test_that("setting username & password works", {

  test_id <- "a.b@c.de"
  test_pw <- "xyz012"

  save_credential(type = "test_email", test_id, force = TRUE)
  save_credential(type = "test_password", test_pw, force = TRUE)
  expect_equal(get_credentials(test = TRUE),
               c(test_id, test_pw))

  expect_error(save_credential(type = "test_email", test_id))
  expect_error(save_credential(type = "test_password", test_pw))
})
