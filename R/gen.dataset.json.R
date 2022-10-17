#' gen.dataset.json
#'
#' @param dataframe Tibble dataframe with variable labels
#' @param studyOID Specify Study OID as String
#' @param metaDataVersionOID Specify Metadata Version OID as string
#' @param dataset.name Specify dataset name as string
#' @param dataset.label Specify dataset label as string
#' @param pretty.format TRUE for generating a Dataset-Json string with pretty format
#'
#' @return a Dataset-Json string
#' @export
#'
#' @examples
#' \dontrun{
#' gen.dataset.json(dm, studyOID="cdisc.com/CDISCPILOT01",
#'                  metaDataVersionOID="MDV.MSGv2.0.SDTMIG.3.3.SDTM.1.7",
#'                  dataset.name="DM", dataset.label="Demographics")
#' }
gen.dataset.json <- function(dataframe, studyOID, metaDataVersionOID,
                               dataset.name, dataset.label, pretty.format=FALSE){

        itemData_ <- as.matrix(dataframe)
        temp_ <- list(records = nrow(dataframe),
                      name = dataset.name,
                      label = dataset.label,
                      items = gen.items(dataframe = dataframe, dataset.name = dataset.name),
                      itemData = itemData_)
        itemGroupData_ <- list(temp = temp_)

        names(itemGroupData_) <- paste0("IG.", toupper(dataset.name))

        clinicalData_ <- list(studyOID = studyOID,
                              metaDataVersionOID = metaDataVersionOID,
                              itemGroupData = itemGroupData_
        )
        dataset.list <- list(clinicalData = clinicalData_)

        return(jsonlite::toJSON(dataset.list, auto_unbox = TRUE, pretty = pretty.format))
}

