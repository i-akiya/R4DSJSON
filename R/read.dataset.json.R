#' read.dataset.json
#' @importFrom tinylabels variable_label
#' @importFrom tibble as_tibble
#' @importFrom dplyr %>%
#' @export
#' @param file file path to dataset-json as string
#' @return tibble dataframe
#' @examples
#' \dontrun{
#' dm <- read.dataset.json(file = "dm.json")
#' }
read.dataset.json <- function(file){

        if (file.exists(file) == FALSE){
                stop(paste0("error: \"", file, "\" is not found."))
        }

        deserialized_data <- jsonlite::fromJSON(file)
        items <- deserialized_data$clinicalData$itemGroupData[[1]]$items
        item_data <- deserialized_data$clinicalData$itemGroupData[[1]]$itemData

        # Variable names
        column_names <- items["name"] %>%
                unlist() %>%
                unname()

        colnames(item_data) <- column_names

        # Variable labels
        column_labels <- items["label"] %>%
                base::unlist() %>%
                base::unname()


        # Detect integer type columns
        integer_column <- items %>%
                dplyr::filter(type == "integer") %>%
                dplyr::select(name) %>%
                base::unlist() %>%
                stats::setNames(NULL)

        # Detect float type columns
        float_column <- items %>%
                dplyr::filter(type == "float") %>%
                dplyr::select(name) %>%
                base::unlist() %>%
                stats::setNames(NULL)

        item_data_tbl <- item_data %>%
                tibble::as_tibble()

        item_data_tbl <- item_data_tbl %>%
                purrr::map(unlist)

        # Data type conversion from string to integer
        if (length(integer_column) > 0){
                for(i in integer_column){
                        eval(parse(text=paste0("item_data_tbl$", i, " <- ",
                                               "as.integer(item_data_tbl$", i, ")")))
                }
        }

        # Data type conversion from string to integer
        if (length(float_column) > 0){
                for(i in float_column){
                        eval(parse(text=paste0("item_data_tbl$", i, " <- ",
                                               "as.double(item_data_tbl$", i, ")")))
                }
        }

        # Set variable label
        for (i in 1:length(column_names)) {
                eval(parse(text=paste0("tinylabels::variable_label(item_data_tbl$",
                                       column_names[i], ")",
                                       " <- ", "\"", column_labels[i], "\"")))
        }

        item_data_robj <- item_data_tbl %>% tibble::as_tibble()

        return(item_data_robj)
}
