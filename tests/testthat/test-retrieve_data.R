context("test-retrieve_data.R")

test_that("downloading a dataset via BacDive ID works", {
  expect_equal(download(
      "https://bacdive.dsmz.de/api/bacdive/culturecollectionno/DSM%20319/?format=json"),
      '[{"url": "https://bacdive.dsmz.de/api/bacdive/bacdive_id/717/"}]')
})

test_that("downloading a set of BacDive ID works", {

expect_equal(download("https://bacdive.dsmz.de/api/bacdive/taxon/Bacillus/subtilis/subtilis/?format=json") %>% rjson::fromJSON() %>% names(),
             c("count", "next", "previous", "results"))
})
