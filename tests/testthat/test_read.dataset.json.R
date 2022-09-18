library(testthat)

dm_json_file <- RCurl::getURL("https://raw.githubusercontent.com/cdisc-org/DataExchange-DatasetJson/master/examples/sdtm/dm.json")
dm_tibble <- R4DSJSON::read.dataset.json(dataset_json = dm_json_file, object_type = "tibble")
lb_json_file <- RCurl::getURL("https://raw.githubusercontent.com/cdisc-org/DataExchange-DatasetJson/master/examples/sdtm/lb.json")
lb_tibble <- R4DSJSON::read.dataset.json(dataset_json = lb_json_file, object_type = "tibble")


test_that("Check number of records", {
        expect_equal(nrow(dm_tibble), 18)
        })

test_that("Check number of columns", {
        expect_equal(ncol(dm_tibble), 27)
})

test_that("Check data type of integer colum", {
        expect_equal(typeof(dm_tibble$AGE), "integer")
})

test_that("Check data type of integer colum", {
        expect_equal(typeof(dm_tibble$AGE), "integer")
        })

test_that("Check data type of float colum", {
        expect_equal(typeof(lb_tibble$LBSTRESN), "double")
})
