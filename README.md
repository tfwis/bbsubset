
# bbsubset

abstract

## Installation

You can install the alpha version of `bbsubset` with:

``` r
devtools::install_github("tfwis/bbsubset")
```

    ## Error in get(genname, envir = envir) : 
    ##    オブジェクト 'testthat_print' がありません

    ## Skipping install of 'bbsubset' from a github remote, the SHA1 (308776d7) has not changed since last install.
    ##   Use `force = TRUE` to force installation

## Example

#### Load packages

Please confirm that these packages are installed before trying this
example.

``` r
library(ROI)
```

    ## ROI: R Optimization Infrastructure

    ## Registered solver plugins: nlminb, lpsolve.

    ## Default solver: auto.

``` r
library(slam)
```

#### Load barcode data

``` r
mdsfile <- "~/R/bbsubset/CS96_d4_n24_sort.csv"
fullset <- lapply(scan(mdsfile,"char",skip=1),function(x) unlist(strsplit(x,','))[-1])[[1]]
```

#### The bbsubset part

``` r
set <- bbsubset::bbsubset(fullset,12)
set$subset
```

    ##  [1] "ACAGGA" "AGACTC" "AGCTCA" "CACTAG" "CAGATC" "CTCAGA" "GAGTGA" "GTGAAG"
    ##  [9] "GTTGCA" "TCACAG" "TCTGTC" "TGTCGA"
