context("test-retrieve_data.R")

test_that("downloading a dataset via BacDive ID works", {
  expect_equal(download(
      "https://bacdive.dsmz.de/api/bacdive/culturecollectionno/DSM%20319/?format=json"),
      '[{"url": "https://bacdive.dsmz.de/api/bacdive/bacdive_id/717/"}]')
})


B_subtilis_IDs <-
  rjson::fromJSON(
    download(
      "https://bacdive.dsmz.de/api/bacdive/taxon/Bacillus/subtilis/subtilis/?format=json"
    )
  )

  expect_equal(names(B_subtilis_IDs),
               c("count", "next", "previous", "results"))
  expect_true(is.numeric(aggregate_result_IDs(B_subtilis_IDs$results)))
})
