test_that("Downloading without proper credentials raises an error", {
  random <- sample(letters, 8)
  expect_error(download(construct_url(717), user = random, password = random))
})
