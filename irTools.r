# Renters:

# Invest the downpayment in the market
# Invest the monthly difference between rent and mortgage into the market


negToZero <- function(x) if (x > 0) x else 0

monthlyPayments <- function(P0, years, ir, tilgung) {
    Pn <- P0 * (1 - years * tilgung)
    months <- years * 12
    monthlyPReduction <- (P0 - Pn) / (months)
    owed <- seq(P0, Pn, by = -monthlyPReduction)[1:months]
    owed <- sapply(owed, negToZero)
    iPayment <- owed * (exp(ir/12) - 1)
    tPayment <- array(monthlyPReduction, dim = 120)
    data.frame(cbind(tPayment,iPayment))
}


propertyTaxes <- function(initialPrice, rate, appreciation, years) {
    priceAtYear <- initialPrice * exp(appreciation * 0:years-1)
    rate * priceAtYear
}


buyUpFrontCosts <- function(price, realtorRate, notarRate, txTaxRate) {
    upFrontCosts <- {}
    upFrontCosts$rFee <- realtorRate * price
    upFrontCosts$notarFee <- notarRate * price
    upFrontCosts$txTax <- txTaxRate * price
    upFrontCosts$total <- 
        upFrontCosts$txTax +
        upFrontCosts$notarFee + 
        upFrontCosts$rFee
    upFrontCosts
}

buyRecurringCosts <- function(price, years, propTaxRate,
    maintenanceCost, appreciation, inflationRate) {
    
    iYears <- exp(inflationRate * 0:(years-1))
    aYears <- exp(appreciation * 0:(years-1))

    maintenanceCosts <- iYears * maintenanceCost
    propTaxes <- aYears * propTaxRate * price

    data.frame(cbind(maintenanceCosts, propTaxes))
}

buyValueAtEnd <- function(price, years, appreciation, tilgung) {
    equityPercent <- (years * tilgung)
    price * equityPercent * exp(appreciation * years)
}

getBuyReport <- function(
    price,
    years,
    downpayment,
    appreciation,
    tilgung,
    ir,
    realtorRate,
    notarRate,
    txTaxRate,
    propTaxRate,
    maintenanceCost,
    inflationRate) {

    buyReport <- {}

    buyReport$upFrontCosts <- buyUpFrontCosts(price, realtorRate, notarRate, txTaxRate)

    buyReport$principle <- price + buyReport$upFrontCosts$total - downpayment
    buyReport$principle
    buyReport$recurringCosts <- buyRecurringCosts(price, years,
        propTaxRate, maintenanceCost, appreciation, inflationRate)
    buyReport$payments <- monthlyPayments(buyReport$principle, years, ir, tilgung)

    buyReport$totalInterestCost <- sum(buyReport$payments$iPayment)
    buyReport$totalEquityCost <- sum(buyReport$payments$tPayment)
    buyReport$totalRunningCosts <- sum(buyReport$recurringCosts)
    buyReport$totalUpFrontCosts <- buyReport$upFrontCosts$total

    buyReport$totalCost <- sum(
        buyReport$totalInterestCost,
        buyReport$totalEquityCost,
        buyReport$totalRunningCosts,
        buyReport$totalUpFrontCosts)

    buyReport$endValue <- buyValueAtEnd(price, years, appreciation, tilgung)

    buyReport$cashEarned <- buyReport$endValue - buyReport$totalCost

    buyReport$percentEarned <- (buyReport$endValue / buyReport$totalCost) - 1

    buyReport$annualEarning <- log(buyReport$percentEarned + 1) / years
    buyReport
}

getDefaultBuyReport <- function() {getBuyReport(
    price = 500000,
    years = 5,
    downpayment = 25000,
    appreciation = 0.015,
    tilgung = 0.005,
    ir = 0.02,
    realtorRate = 0.0569,
    notarRate = 0.015,
    txTaxRate = 0.06,
    propTaxRate = 0.014,
    maintenanceCost = 5000,
    inflationRate = 0.015
    )}

rentWithHikes <- function(startingRent, years, expectedRateHike) {
    multipliers <- (1+expectedRateHike)^sort(rep(0:(years-1), 12))
    rents <- startingRent * multipliers
    rents
}

monthlyInvestment <- function(years, marketRate) {
    months <- 12 * years
    payouts <- rev(exp(marketRate * (1:months/12)))
    payouts
}

getRentReport <- function(startingRent, years, expectedRateHike, marketRate, payin) {
    rentReport <- {}

    rentReport$costSchedule <- rentWithHikes(startingRent, years, expectedRateHike)
    rentReport$totalRentPaid <- sum(rentReport$costSchedule)

    rentReport$marketSpending <- payin * 12 * years
    rentReport$marketEarnings <- payin * monthlyInvestment(years, marketRate)
    rentReport$totalMktEarnings <- sum(rentReport$marketEarnings)

    rentReport$totalCost <- sum(
        rentReport$marketSpending,
        rentReport$totalRentPaid)

    rentReport$cashEarned <- rentReport$totalMktEarnings - rentReport$totalCost

    rentReport$percentEarned <- (rentReport$totalMktEarnings / rentReport$totalCost - 1)

    rentReport$annualEarning <- log(rentReport$percentEarned + 1) / years
    rentReport
}





