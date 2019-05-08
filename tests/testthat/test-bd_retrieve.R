context("test-bd_retrieve.R")

B_subtilis_IDs <-
  download(
    "https://bacdive.dsmz.de/api/bacdive/taxon/Bacillus/subtilis/?format=json"
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
  expect_equal(
    B_subtilis_IDs$count,
    length(aggregate_result_URLs(B_subtilis_IDs))
  )
  expect_type(object = aggregate_result_URLs(B_subtilis_IDs), type = "character")
})


test_that(
  "Redirecting 'culturecollectionno' & 'sequence' searches to 'bacdive_id' works (#45)", {
    expect_identical(
      bd_retrieve_by_culture(collection_no = "DSM 319"),
      bd_retrieve_by_sequence(accession = "AJ000733"),
      bd_retrieve(id = 717)
    )
  }
)


# test set with 2 strains
rare <- "Acinetobacter courvalinii"
rare_data <- bd_retrieve_taxon(name = rare)

test_that("extracting a single field from a taxon-wide search works", {
  expect_equal(
    c("30", "15-37"),
    unique(unlist(
      purrr::map(
        .x = rare_data,
        .f = ~ .x$culture_growth_condition$culture_temp$temp
      )
    ))
  )
})

test_that("any dataset returned by BacDiveR is named with its ID", {
  expect_equal(
    names(rare_data),
    c("139534", "139535")
  )
  # https://bacdive.dsmz.de/advsearch?advsearch=search&site=advsearch&searchparams%5B73%5D%5Bcontenttype%5D=text&searchparams%5B73%5D%5Btypecontent%5D=exact&searchparams%5B73%5D%5Bsearchterm%5D=Bacillus+halotolerans&csv_bacdive_ids_advsearch=download
})

test_that("Normalising invalid JSON whitespace works,
          for both multi- and single-species taxons", {
  expect_type(
    object = rare_data,
    type = "list"
  )
  # https://bacdive.dsmz.de/api/bacdive/bacdive_id/1847/?format=json
  # contains "medium_composition": "Name: ISP 2 / Yeast Malt Agar (5265); 5265\r\nComposition

  expect_type(bd_retrieve_taxon("Roseomonas aerilata"),
    type = "list"
  )
  # https://bacdive.dsmz.de/api/bacdive/bacdive_id/76/?format=json
  # contains enrichment_cult_name": "R2A agar with 200 mg cycloheximide ml\n21"
  # Error: lexical error: invalid character inside string.
  # Called from: parse_string(txt, bigint_as_char)
})

test_that("Trying to download a non-existent dataset yields warnings & empty list", {
  expect_warning(non_existant <- bd_retrieve(id = 999999999))
  expect_warning(blablub <- bd_retrieve_taxon(name = "bla blub"))
  expect_equal(blablub, non_existant, list())
})

test_that("Fuzzing of searchTerm parameter produces error", {
  expect_error(bd_retrieve_data(Bac_hal, searchType = sample(letters, 1)))
})
