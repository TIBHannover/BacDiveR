context("test-retrieve_data.R")


B_subtilis_IDs <-
  jsonlite::fromJSON(
    download(
      "https://bacdive.dsmz.de/api/bacdive/taxon/Bacillus/subtilis/subtilis/?format=json"
    )
  )

test_that("taxon search returns paged results list", {
  expect_true(is_results_list(B_subtilis_IDs))
  expect_null(B_subtilis_IDs$previous)
  expect_type(object = B_subtilis_IDs$count, type = "integer")

  expect_type(object = B_subtilis_IDs$`next`, type = "character")
  # can be NULL for taxonomic units < 100 BacDive entries

  expect_type(object = B_subtilis_IDs$results, type = "list")
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
               length(aggregate_result_URLs(P_lini)))
})


test_that("Redirecting 'culturecollectionno' & 'sequence' searches to 'bacdive_id' works (#45)",
          {
            expect_identical(
              retrieve_data(
                searchTerm = "DSM 319",
                searchType = "culturecollectionno"
              ),
              retrieve_data(
                searchTerm = "AJ000733",
                searchType = "sequence"
              ),
              retrieve_data(
                searchTerm = 717,
                searchType = "bacdive_id"
              )
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
  expect_equal(names(Bac_hal_data),
               c("1095", "1847"))
  # https://bacdive.dsmz.de/advsearch?advsearch=search&site=advsearch&searchparams%5B73%5D%5Bcontenttype%5D=text&searchparams%5B73%5D%5Btypecontent%5D=exact&searchparams%5B73%5D%5Bsearchterm%5D=Bacillus+halotolerans&csv_bacdive_ids_advsearch=download
})

test_that("normalising invalid JSON whitespace works", {

  expect_type(object = Bac_hal_data,
              type = "list")
  # https://bacdive.dsmz.de/api/bacdive/bacdive_id/1847/?format=json
  # contains "medium_composition": "Name: ISP 2 / Yeast Malt Agar (5265); 5265\r\nComposition

  expect_type(retrieve_data(76, "bacdive_id"),
              type = "list")
  # https://bacdive.dsmz.de/api/bacdive/bacdive_id/76/?format=json
  # contains enrichment_cult_name": "R2A agar with 200 mg cycloheximide ml\n21"
  # Error: lexical error: invalid character inside string.
  # Called from: parse_string(txt, bigint_as_char)

})

test_that("Trying to download a non-existent dataset yields warnings & empty list", {
  expect_warning(non_existant <-
                   retrieve_data(searchTerm = 999999999, searchType = "bacdive_id"))
  expect_warning(blablub <- retrieve_data(searchTerm = "bla blub"))
})

test_that("Downloading a single-dataset taxon works", {
  expect_type(retrieve_data("Campylobacter pinnipediorum"),
              "list")
  expect_equal(blablub, non_existant, list())
})
