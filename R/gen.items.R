#' gen.items
#' Make items json that is a part of Dataset-Json
#' @param dataframe Tibble dataframe with variable labels
#' @param dataset.name Specify dataset name as string
#'
#' @return items data as dataframe
gen.items <- function(dataframe, dataset.name){
        # name
        var.name <- names(dataframe)

        # oid
        var.oid <- c("")

        # label
        var.label <- tinylabels::variable_label(dataframe) %>% unlist()
        names(var.label) <- NULL

        # type
        var.type <- sapply(tinylabels::unlabel(dataframe), class) %>% unlist()
        names(var.type) <- NULL

        # length
        var.length <- get.var.length(dataframe)

        items.df <- data.frame(OID=var.oid,
                               name=var.name,
                               label=var.label,
                               type=var.type,
                               length=var.length) %>%
                dplyr::mutate(OID = ifelse(name=="ITEMGROUPDATASEQ",
                                           "ITEMGROUPDATASEQ",
                                           paste0("IT.", dataset.name, ".", name))) %>%
                dplyr::mutate(type = ifelse(type=="character",
                                           "string",
                                           type))
                # dplyr::mutate(length = length(dplyr::select(dataframe, name)))

        rownames(items.df) <- NULL

        return(items.df)
}
