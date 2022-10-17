dm_tibble <- read.dataset.json(file = system.file("testdata","dm.json", package="R4DSJSON"))
lb_tibble <- read.dataset.json(file = system.file("testdata","lb.json", package="R4DSJSON"))


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
