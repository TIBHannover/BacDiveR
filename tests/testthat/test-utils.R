context("test-utils.R")

test_that("preparing .Renviron file works", {
  prepare_Renviron()
  r_env_lines <- readLines(construct_Renviron_path())

  for (type in c("email", "password"))
      expect_true(any(grepl(paste0("^BacDive_", type, "="), r_env_lines)))
})


test_that("large downloads trigger a warning", {
  expect_warning(warn_slow_download(101))
})
