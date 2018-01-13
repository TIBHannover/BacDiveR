context("test-utils.R")

test_that("preparing .Renviron file works", {
  prepare_Renviron()
  r_env_lines <- readLines(get_Renviron_path())

  for (type in c("email", "password"))
      expect_true(any(grepl(paste0("^BacDive_", type, "="), r_env_lines)))
})
