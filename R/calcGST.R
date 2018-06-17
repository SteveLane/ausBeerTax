#' Calculate the GST of a product.
#'
#' This simple function calculates the Goods and Services Tax (GST) component in
#' a given purchase price.
#'
#' @param cost Numeric. Represents the purchase price in dollars.
#' @param gst Numeric. Represents the percentage of GST that was added to the
#'     purchase price. Defaults to 10% (Australia).
#'
#' @return Numeric. Returns the GST dollar amount included in the purchase
#'     price, rounded up to the nearest cent.
#' @export
calcGST <- function(cost, gst = 0.1) {
    div <- (1 + gst) / gst
    amount <- ceiling(cost / div * 100) / 100
    amount
}
