#' ggbody
#' 
#' Draw a heat-map of events on a human body silhouette using ggplot2 objects
#' 
#' @param x a data frame with available body locations listed in the Details
#'   section below
#' @param score the data frame column containg the magnitude of the effect that
#'   will be graphed
#' @param location \emph{Inactive} the data frame column defining the body part
#'   locaiton
#' 
#' @importFrom ggplot2 ggplot enquo aes aes_string xlim ylim geom_point scale_size_continuous scale_color_gradient theme theme_void
#' @importFrom ggpubr background_image
#' @importFrom dplyr left_join
#' @importFrom rlang quo_is_missing
#' @importFrom grid unit
#' 
#' @details
#' \itemize{
#'   \item The body locations supported by ggbody are limited to: c("head",
#'   "knee_left", "buttock_left", "hand_right_front", "calf_right")
#' }
#' 
#' @examples 
#' 
#' \dontrun{
#'   
#'   library(ggplot2)
#'   library(ggbody)
#'   
#'   data(body_pain)
#'   
#'   ggbody(body_pain, Pain) +
#'     scale_color_gradient(limits = c(1, 10), low="#FED141", high="#B52555")
#'   
#' }
#' 
#' @export
#' 
ggbody <- function(x, score, location = "location") {

  score = enquo(score)
  # location = enquo(locaiton)
  
  tryCatch({
    
    if (quo_is_missing(score)) stop("Did you forget to include the data frame's score column?", call. = FALSE)

    ggplot(left_join(x, location_map$male_frontback, by = c("location" = "location")),
           aes_string(x = "x", y = "y", color = score, size = score)) +
      xlim(0, 1) +
      ylim(0, 1) +
      background_image(silhouette$male_frontback) +
      geom_point(aes(stroke = 2)) +
      scale_size_continuous(range = c(2, 15), guide = FALSE) +
      theme_void() +
      theme(plot.margin = grid::unit(rep(2, 4), "mm"))
    
  },
  error = function(error_condition) {
    message(error_condition)
    
  })
  
}
