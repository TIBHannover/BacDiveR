context("test-construct_url.R")

test_that("URL constructions work", {

  expect_equal(
    construct_url(717),
    construct_url("717"),
    "https://bacdive.dsmz.de/api/bacdive/bacdive_id/717/"
  )

  expect_equal(
    construct_url("AF12345", searchType = "sequence"),
    "https://bacdive.dsmz.de/api/bacdive/sequence/AF12345/"
  )

  expect_equal(
    construct_url("DSM 319", searchType = "culturecollectionno"),
    "https://bacdive.dsmz.de/api/bacdive/culturecollectionno/DSM%20319/"
  )
})
