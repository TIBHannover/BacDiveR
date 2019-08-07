test_that("Downloading without preper credentials raises an error", {
  random <- sample(letters, 8)
  expect_error(download(construct_url(717), user = random, password = random))
})
