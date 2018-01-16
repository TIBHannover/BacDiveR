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

test_that("taxon search returns paged results list", {
  expect_equal(names(B_subtilis_IDs),
               c("count", "next", "previous", "results"))
  expect_null(B_subtilis_IDs$previous)
  expect_true(is.numeric(B_subtilis_IDs$count))
  expect_true(is.character(B_subtilis_IDs$`next`))
  expect_true(is.list(B_subtilis_IDs$results))
})

})
