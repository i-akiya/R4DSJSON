#' read.dataset.json.tibble
#'
#' @param dataset_json filepath to dataset-json file as string
#'
#' @return tibble
#'
#' @export
#'
#' @examples
#' library(dplyr)
#' json_file <- RCurl::getURL("https://raw.githubusercontent.com/cdisc-org/DataExchange-DatasetJson/master/examples/sdtm/dm.json")
#' dm_tibble <- R4DSJSON::read.dataset.json.tibble(json_file)
read.dataset.json.tibble <- function( dataset_json ){
        deserialized_data <- jsonlite::fromJSON(dataset_json)
        items <- deserialized_data$clinicalData$itemGroupData[[1]]$items
        column_names <- items["name"] %>%
                unlist()
        integer_column <- deserialized_data$clinicalData$itemGroupData$IG.DM$items %>%
                dplyr::filter(type == "integer") %>%
                dplyr::select(name) %>%
                unlist() %>%
                setNames(NULL)

        item_data <- deserialized_data$clinicalData$itemGroupData[[1]]$itemData %>%
                data.frame()
        names(item_data) <- column_names

        item_data <- item_data %>%
                purrrlyr::dmap(unlist)

        if (length(integer_column) > 0){
                item_data <- item_data %>%
                        purrrlyr::dmap_at(integer_column, as.integer)
        }

        return(item_data)
}


#' read.dataset.json.dataframe
#'
#' @param dataset_json filepath to dataset-json file as string
#'
#' @return dataframe
#'
#' @export
#'
#' @examples
#' library(dplyr)
#' json_file <- RCurl::getURL("https://raw.githubusercontent.com/cdisc-org/DataExchange-DatasetJson/master/examples/sdtm/dm.json")
#' dm_dataframe <- R4DSJSON::read.dataset.json.dataframe(json_file)
read.dataset.json.dataframe <- function( dataset_json ){
        df <- read.dataset.json.tibble(dataset_json) %>%
                as.data.frame()

        return(df)
}
