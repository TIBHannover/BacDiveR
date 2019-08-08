random <- paste(sample(letters, 16), collapse = "")

test_that("Downloading without preper credentials raises an error", {

  # arrange
  r_env_file <- construct_Renviron_path()
  r_env_backup <- paste(r_env_file, "backup", sep = ".")
  file.rename(r_env_file, r_env_backup)

  ## mock .Renviron file
  create_new(r_env_file)
  for (x in c("email", "password")) {
    line <- paste0("BacDive_", x, "=", random, collapse = "")
    write(line, r_env_file, append = TRUE)
  }

  # act & assert
  expect_error(download(construct_url(717)), regexp = "Check your credentials")

  # clean up
  file.copy(r_env_backup, r_env_file, overwrite = TRUE)
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
