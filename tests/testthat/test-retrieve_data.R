context("test-retrieve_data.R")

test_that("downloading a dataset via BacDive ID works", {
  expect_true(grepl(
    "taxonomy_name",
    download(
      "https://bacdive.dsmz.de/api/bacdive/bacdive_id/717/?format=json"
    )
  ))
})
