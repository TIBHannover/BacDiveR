context("test-construct_url.R")

test_that("URL constructions work", {

  expect_equal(
    construct_url(717),
    construct_url("717"),
    "https://bacdive.dsmz.de/api/bacdive/bacdive_id/717/"
  )

  expect_equal(
    construct_url("AF12345", searchType = "sequence"),
    construct_url("AF12345", searchType = "taxon"),
    construct_url("AF12345"),
    "https://bacdive.dsmz.de/api/bacdive/sequence/AF12345/"
  )

  expect_equal(
    construct_url("D86002"),
    construct_url("D86002", searchType = "culturecollectionno"),
    "https://bacdive.dsmz.de/api/bacdive/sequence/D86002/"
  )

  expect_equal(
    construct_url("DSM 319", searchType = "culturecollectionno"),
    "https://bacdive.dsmz.de/api/bacdive/culturecollectionno/DSM%20319/"
  )

  expect_equal(
    construct_url("Pseudomonas", searchType = "taxon"),
    "https://bacdive.dsmz.de/api/bacdive/taxon/Pseudomonas/"
  )

  expect_equal(
    construct_url("Bacillus subtilis subtilis", searchType = "taxon"),
    "https://bacdive.dsmz.de/api/bacdive/taxon/Bacillus/subtilis/subtilis/"
  )
})
