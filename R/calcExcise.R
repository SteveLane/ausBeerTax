#' Calculates the amount of alcohol excise
#'
#' This function calculates the amount of excise that is payable in a given
#' volume of beer. Rates for 2018 are given
#' \href{https://www.ato.gov.au/Business/Excise-and-excise-equivalent-goods/Alcohol-excise/Excise-rates-for-alcohol/}{here}.
#' Note that according to the regulations, excise duty on beer is payable on the
#' alcohol content above 1.15% by volume.
#'
#' @param abv Numeric. Provide the percentage alcohol by volume of the beer.
#' @param volume_per_bottle Numeric. Provide the volume of beer in a bottle in
#'     mls.
#' @param bottles_per_slab Numeric. Provide the number of bottles of beer in a
#'     slab. Defaults to 24.
#'
#' @return Numeric. The amount (rounded up to the nearest cent) paid in excise
#'     duties.
#' 
#' @export
calcExcise <- function(abv, volume_per_bottle, bottles_per_slab = 24) {
    abv_adjusted <- abv - 0.0115
    if (abv <= 0.0115) {
        ## No excise payable.
        return(0)
    }
    if (abv > 0.015 & abv <= 0.03) {
        rate_per_litre <- 42.5
    } else {
        rate_per_litre <- 49.5
    }
    ## Alcohol volume in litres
    total_volume <- volume_per_bottle * bottles_per_slab * abv_adjusted / 1000
    excise <- ceiling(total_volume * rate_per_litre * 100) / 100
    excise
}
