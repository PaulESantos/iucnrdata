# tests/testthat/test-common_names_2024_v2.R

test_that("common_names_2024_v2 dataset structure is correct", {
  # Cargar el dataset
  data("common_names_2024_v2")

  # Verificar que es un tibble/data.frame
  expect_s3_class(common_names_2024_v2, "tbl_df")

  # Verificar que contiene las 5 columnas correctas
  expected_columns <- c("internal_taxon_id", "scientific_name", "name", "language", "main")
  expect_named(common_names_2024_v2, expected_columns)

  # Verificar los tipos de las columnas
  expect_type(common_names_2024_v2$internal_taxon_id, "integer")
  expect_type(common_names_2024_v2$scientific_name, "character")
  expect_type(common_names_2024_v2$name, "character")
  expect_type(common_names_2024_v2$language, "character")
  expect_type(common_names_2024_v2$main, "logical")

  # Verificar que no haya valores NA en columnas esenciales (internal_taxon_id y name)
  expect_false(any(is.na(common_names_2024_v2$internal_taxon_id)))
  expect_false(any(is.na(common_names_2024_v2$name)))

  # Verificar que main solo contiene valores TRUE o FALSE
  expect_true(all(common_names_2024_v2$main %in% c(TRUE, FALSE)))
})
