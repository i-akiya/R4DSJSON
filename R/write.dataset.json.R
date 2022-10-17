#' write.dataset.json
#' Write Dataset-Json file.
#' @param file file path to dataset-json as string
#' @param dataframe Tibble dataframe with variable labels
#' @param studyOID Specify Study OID as String
#' @param metaDataVersionOID Specify Metadata Version OID as string
#' @param dataset.name Specify dataset name as string
#' @param dataset.label Specify dataset label as string
#' @param pretty.format TRUE for generating a Dataset-Json string with pretty format
#'
#' @export
#'
#' @examples
#' \dontrun{
#' write.dataset.json(file="dm.json", dataframe=dm, studyOID="cdisc.com/CDISCPILOT01",
#'                  metaDataVersionOID="MDV.MSGv2.0.SDTMIG.3.3.SDTM.1.7",
#'                  dataset.name="DM", dataset.label="Demographics")
#' }
write.dataset.json <- function(file, dataframe, studyOID, metaDataVersionOID,
                               dataset.name, dataset.label, pretty.format=FALSE){

        dataset_json <- gen.dataset.json(dataframe, studyOID, metaDataVersionOID,
                                         dataset.name, dataset.label, pretty.format)

        write(dataset_json, file=file)
}

