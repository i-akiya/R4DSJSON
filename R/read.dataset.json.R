#' read.dataset.json
#' @export
#' @param dataset_json dataset-json string
#' @param object_type Select "tibble" or "dataframe" as return object.
#' @return tibble or dataframe
#' @examples
#' library(dplyr)
#' json_file <- RCurl::getURL("https://raw.githubusercontent.com/cdisc-org/DataExchange-DatasetJson/master/examples/sdtm/dm.json")
#' dm_tibble <- R4DSJSON::read.dataset.json(dataset_json = json_file, object_type = "tibble")
#' dm_dataframe <- R4DSJSON::read.dataset.json(dataset_json = json_file, object_type = "dataframe")
read.dataset.json <- function(dataset_json,
                              object_type = c("tibble", "dataframe")){
        if (object_type %in% c("tibble", "dataframe") == FALSE) {
                stop(paste0("\"",
                            object_type,
                            "\" is assigned to object_type argument,",
                            " but object_type argument can accept only \"tibble\" or \"dataframe\".")
                     )
        }

        deserialized_data <- jsonlite::fromJSON(dataset_json)
        items <- deserialized_data$clinicalData$itemGroupData[[1]]$items
        item_data <- deserialized_data$clinicalData$itemGroupData[[1]]$itemData

        column_names <- items["name"] %>%
                unlist() %>%
                unname()

        colnames(item_data) <- column_names

        # Detect integer type columns
        integer_column <- items %>%
                dplyr::filter(type == "integer") %>%
                dplyr::select(name) %>%
                unlist() %>%
                setNames(NULL)

        # Detect float type columns
        float_column <- items %>%
                dplyr::filter(type == "float") %>%
                dplyr::select(name) %>%
                unlist() %>%
                setNames(NULL)

        item_data_tbl <- item_data %>%
                tibble::as_tibble()

        # names(item_data_tbl) <- column_names

        item_data_tbl <- item_data_tbl %>%
                purrrlyr::dmap(unlist)

        # Data type conversion from string to integer
        if (length(integer_column) > 0){
                item_data_tbl <- item_data_tbl %>%
                        purrrlyr::dmap_at(integer_column, as.integer)
        }

        # Data type conversion from string to integer
        if (length(float_column) > 0){
                item_data_tbl <- item_data_tbl %>%
                        purrrlyr::dmap_at(float_column, as.double)
        }

        if (object_type == "dataframe"){
                item_data_robj <- item_data_tbl %>% as.data.frame()
        } else {
                item_data_robj <- item_data_tbl
        }
        return(item_data_robj)
}
