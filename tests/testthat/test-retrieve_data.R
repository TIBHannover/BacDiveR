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
  expect_type(object = B_subtilis_IDs$count, type = "integer")

  expect_type(object = B_subtilis_IDs$`next`, type = "character")
  # can be NULL for taxonomic units < 100 BacDive entries

  expect_type(object = B_subtilis_IDs$results, type = "list")
})

test_that("aggregating a set of BacDive ID works", {
  expect_equal(B_subtilis_IDs$count,
               length(aggregate_result_IDs(B_subtilis_IDs)))
  expect_type(object = aggregate_result_IDs(B_subtilis_IDs), type = "double")
  # mode "numeric" consists of types "integer" and "double"
})

test_that("aggregating a set of BacDive URLs works", {
  expect_equal(B_subtilis_IDs$count,
               length(aggregate_result_URLs(B_subtilis_IDs)))
  expect_type(object = aggregate_result_URLs(B_subtilis_IDs), type = "character")
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


test_that("downloading a single dataset via culturecollectionno works (#45)",
          {
            expect_equal(
              object = retrieve_data(
                searchTerm = "DSM 319",
                searchType = "culturecollectionno"
              )$`717`$taxonomy_name$strains_tax_PNU$ID_reference,
              retrieve_data(
                searchTerm = "AJ000733",
                searchType = "sequence"
              )$`717`$taxonomy_name$strains_tax_PNU$ID_reference,
              retrieve_data(
                searchTerm = 717,
                searchType = "bacdive_id"
              )$`717`$taxonomy_name$strains_tax_PNU$ID_reference,
              20215
            )
          })


test_that("extracting a single field from a taxon-wide search works", {
  expect_equal(30,
               unique(unlist(
                 purrr::map(
                   .x = retrieve_data("Aminobacter aminovorans"),
                   .f = ~ as.numeric(.x$culture_growth_condition$culture_temp$temp)
                 )
               )))
})


# test set with 2 strains
Bac_hal <- "Bacillus halotolerans"
Bac_hal_data <- retrieve_data(searchTerm = Bac_hal)

test_that("any dataset returned by BacDiveR is named with its ID", {
  expect_equal(retrieve_IDs(searchTerm = Bac_hal),
               as.numeric(names(Bac_hal_data)))
})

test_that("normalising invalid JSON newlines works", {

  expect_type(
    object = Bac_hal_data,
    type = "list"
  )
  # https://bacdive.dsmz.de/api/bacdive/bacdive_id/1847/?format=json
  # contains "medium_composition": "Name: ISP 2 / Yeast Malt Agar (5265); 5265\r\nComposition
  expect_type(
    object = retrieve_data(searchTerm = "Bacillus cytotoxicus"),
    type = "list"
  )
  # https://bacdive.dsmz.de/api/bacdive/bacdive_id/1323/?format=json
  # contains "sample_type": "Vegetable puree,severe food poisoning\noutbreak in France"
})
