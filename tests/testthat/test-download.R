random <- paste(sample(letters, 16), collapse = "")

test_that("Downloading without proper credentials raises an error", {
  expect_error(download(paste0("https://", random, ":", random, "@", "bacdive.dsmz.de/api/bacdive/bacdive_id/717/?format=json", collapse = TRUE)))
})

test_that("Downloader refuses unexpected URLs", {
  error_regex <- "refus\\w{,3} to connect"

  expect_error(
    download(paste0("http://evil.", random, "-api.net/?format=json")),
    error_regex
  )

  expect_error(
    download(paste0("https://bacdiveZdsmz.de/api/bacdive/?format=json")),
    error_regex
  )
})
