#' get.var.length
#'
#' @param dataset Tibble dataframe
#'
#' @return integer Variable length
get.var.length <- function(dataset){
        var.names <- names(dataset)
        var.length <- c()
        for(i in var.names){
                temp.vector <- dataset[, i] %>%
                        unlist()
                names(temp.vector) <- NULL

                if(class(temp.vector) != "character"){
                        var.length <- append(var.length, NA)
                } else {
                        max.length <- temp.vector %>%
                                nchar() %>%
                                max()
                        max.length <- ifelse(max.length > 0, max.length, 1)

                        var.length <- append(var.length, max.length)
                }
        }

        return(var.length)
}
