# tests/testthat/test-vernacular_name.R

test_that("vernacular_name dataset structure is correct", {
  # Cargar el dataset
  data("vernacular_name")

  # Verificar que es un tibble/data.frame
  expect_s3_class(vernacular_name, "tbl_df")

  # Verificar que contiene las 4 columnas correctas
  expected_columns <- c("core_id", "language", "vernacular_name", "is_preferred_name")
  expect_named(vernacular_name, expected_columns)

  # Verificar los tipos de las columnas
  expect_type(vernacular_name$core_id, "integer")
  expect_type(vernacular_name$language, "character")
  expect_type(vernacular_name$vernacular_name, "character")
  expect_type(vernacular_name$is_preferred_name, "logical")

  # Verificar que no haya valores NA en columnas esenciales (core_id y vernacular_name)
  expect_false(any(is.na(vernacular_name$core_id)))
  expect_false(any(is.na(vernacular_name$vernacular_name)))

  # Verificar que is_preferred_name solo contiene valores TRUE o FALSE
  expect_true(all(vernacular_name$is_preferred_name %in% c(TRUE, FALSE)))
})

