original_dm_json <- jsonlite::fromJSON(readLines(system.file("testdata","dm.json", package="R4DSJSON")))
dm_tibble <- R4DSJSON::read.dataset.json(file = system.file("testdata","dm.json", package="R4DSJSON"))

generated_dm_json <- jsonlite::fromJSON(R4DSJSON::gen.dataset.json(dm_tibble, studyOID = "cdisc.com/CDISCPILOT01",
                                         metaDataVersionOID = "MDV.MSGv2.0.SDTMIG.3.3.SDTM.1.7",
                                         dataset.name = "DM", dataset.label = "Demographics"))

test_that("Check a value of studyOID", {
        original_ <- original_dm_json$clinicalData$studyOID
        generated_ <- generated_dm_json$clinicalData$studyOID
        expect_equal(original_, generated_)
        })


test_that("Check a size of itemData", {
        original_ <- dim(original_dm_json$clinicalData$itemGroupData[1]$itemData)
        generated_ <- dim(generated_dm_json$clinicalData$itemGroupData[1]$itemData)
        expect_equal(original_, generated_)
})
