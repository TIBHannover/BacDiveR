context("test-construct_url.R")

test_that("URL constructions work", {
  int <- sample(seq(100000, 999999), size = 1)

  expect_equal(
    construct_url(int),
    construct_url(as.character(int)),
    paste0(
      "https://bacdive.dsmz.de/api/bacdive/bacdive_id/",
      int,
      "/"
    )
  )


  acc <-
    paste0(paste(sample(LETTERS, size = 2), collapse = ""), int)

  expect_equal(
    construct_url(acc, searchType = "sequence"),
    construct_url(acc, searchType = "taxon"),
    construct_url(acc),
    paste0("https://bacdive.dsmz.de/api/bacdive/sequence/", acc, "/")
  )

  acc <-
    paste0(sample(LETTERS, size = 1), round(int / 10))

  expect_equal(
    construct_url(acc),
    construct_url(acc, searchType = "culturecollectionno"),
    paste0("https://bacdive.dsmz.de/api/bacdive/sequence/", acc, "/")
  )


  ccn <- paste("DSM", round(int / 1000))

  expect_equal(
    construct_url(ccn, searchType = "culturecollectionno"),
    construct_url(ccn),
    construct_url(ccn, searchType = "taxon"),
    construct_url(ccn, searchType = "sequence"),
    paste0(
      "https://bacdive.dsmz.de/api/bacdive/culturecollectionno/DSM%20",
      round(int / 1000),
      "/"
    )
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
