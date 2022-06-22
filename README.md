
<!-- README.md is generated from README.Rmd. Please edit that file -->

# landlord

<!-- badges: start -->
<!-- badges: end -->

> Decide whether a rental property investment is profitable

`landlord` helps budding investors in their first steps. Given a
property and a loan, it calculates future cash flows and profitability.
For convenience sake, this can be done via a Shiny dashboard too.

## Installation

You can install the development version of landlord from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("RudyPastel/landlord")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(landlord)
## basic example code
```

What is special about using `README.Rmd` instead of just `README.md`?
You can include R chunks like so:

``` r
summary(cars)
#>      speed           dist       
#>  Min.   : 4.0   Min.   :  2.00  
#>  1st Qu.:12.0   1st Qu.: 26.00  
#>  Median :15.0   Median : 36.00  
#>  Mean   :15.4   Mean   : 42.98  
#>  3rd Qu.:19.0   3rd Qu.: 56.00  
#>  Max.   :25.0   Max.   :120.00
```

You’ll still need to render `README.Rmd` regularly, to keep `README.md`
up-to-date. `devtools::build_readme()` is handy for this. You could also
use GitHub Actions to re-render `README.Rmd` every time you push. An
example workflow can be found here:
<https://github.com/r-lib/actions/tree/v1/examples>.

You can also embed plots, for example:

<img src="man/figures/README-pressure-1.png" width="100%" />

For more about how to use `landlord`, read the introduction vignette.

## Training and showcase

`landlord` helps its developer hone his craft too by providing an
opportunity to learn and hopefully master packages, tools and paradigms.
This is documented in the design vignette.
