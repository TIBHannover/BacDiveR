context("test-construct_url.R")

test_that("URL constructions work", {

  expect_equal(
    construct_url(717),
    construct_url("717", searchType = "sequence"),
    "https://bacdive.dsmz.de/api/bacdive/bacdive_id/717/?format=json"
    )

  expect_equal(
    construct_url("AJ000733", searchType = "sequence"),
    construct_url("AJ000733", searchType = "taxon"),
    construct_url("AJ000733"),
    "https://bacdive.dsmz.de/api/bacdive/sequence/AF12345/?format=json"
  )

  expect_equal(
    construct_url("D86002"),
    construct_url("D86002", searchType = "culturecollectionno"),
    "https://bacdive.dsmz.de/api/bacdive/sequence/D86002/?format=json"
  )

  expect_equal(
    construct_url("DSM 319", searchType = "culturecollectionno"),
    "https://bacdive.dsmz.de/api/bacdive/culturecollectionno/DSM%20319/?format=json"
    )

  expect_equal(
    construct_url("Pseudomonas", searchType = "taxon"),
    "https://bacdive.dsmz.de/api/bacdive/taxon/Pseudomonas/?format=json"
  )

  expect_equal(
    construct_url("Bacillus subtilis subtilis", searchType = "taxon"),
    "https://bacdive.dsmz.de/api/bacdive/taxon/Bacillus/subtilis/subtilis/?format=json"
  )
})
