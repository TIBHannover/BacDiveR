context("test-retrieve_data.R")

test_that("downloading a dataset via BacDive ID works", {
  expect_equal(
    download(
      "https://bacdive.dsmz.de/api/bacdive/culturecollectionno/DSM%20319/?format=json"
    ),
    '[{"url": "https://bacdive.dsmz.de/api/bacdive/bacdive_id/717/"}]'
  )
})


B_subtilis_IDs <-
  jsonlite::fromJSON(
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
  # can be NULL for taxonomic units < 100 BacDive entries

  expect_true(is.list(B_subtilis_IDs$results))
})

test_that("aggregating a set of BacDive ID works", {
  expect_equal(B_subtilis_IDs$count,
               length(aggregate_result_IDs(B_subtilis_IDs)))
  expect_true(is.numeric(aggregate_result_IDs(B_subtilis_IDs)))
})

test_that("aggregating a set of BacDive URLs works", {
  expect_equal(B_subtilis_IDs$count,
               length(aggregate_result_URLs(B_subtilis_IDs)))
  expect_true(is.character(aggregate_result_URLs(B_subtilis_IDs)))
})


test_that("using the taxon search for a single dataset works", {
  P_lini <-
    jsonlite::fromJSON(
      download(
        "https://bacdive.dsmz.de/api/bacdive/taxon/Pseudomonas/lini/?format=json"
      )
    )

  expect_equal(P_lini$count,
               length(aggregate_result_IDs(P_lini)),
               length(aggregate_result_URLs(P_lini)))
})


test_that("extracting a single field from a taxon-wide search works", {
  expect_equal(30,
               unique(unlist(
                 purrr::map(
                   .x = retrieve_data("Aminobacter aminovorans", force_taxon_download = TRUE),
                   .f = ~ as.numeric(.x$culture_growth_condition$culture_temp$temp)
                 )
               )))
})

test_that("normalising invalid JSON newlines works", {
  is.list(retrieve_data(searchTerm = "Bacillus cytotoxicus",
                        force_taxon_download = TRUE))
  # https://bacdive.dsmz.de/api/bacdive/bacdive_id/1323/?format=json
  # contains "sample_type": "Vegetable puree,severe food poisoning\noutbreak in France"

  is.list(retrieve_data(searchTerm = "Bacillus halotolerans",
                        force_taxon_download = TRUE))
  # https://bacdive.dsmz.de/api/bacdive/bacdive_id/1847/?format=json
  # contains "medium_composition": "Name: ISP 2 / Yeast Malt Agar (5265); 5265\r\nComposition
})
