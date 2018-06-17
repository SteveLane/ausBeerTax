#' Runs the Australian Beer Tax application
#'
#' This function runs the shiny application to demonstrate the tax on your
#' beer.
#'
#' @export
runAusBeerTax <- function() {
    appDir <- system.file("shiny-examples", "ausBeerTax",
                          package = "ausBeerTax")
    if (appDir == "") {
        stop("Could not find example directory. Try re-installing `ausBeerTax`.", call. = FALSE)
    }
    shiny::runApp(appDir, display.mode = "normal")
}
