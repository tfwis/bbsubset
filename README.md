
# bbsubset

abstract

## Installation

You can install the alpha version of `bbsubset` with:

``` r
devtools::install_github("tfwis/bbsubset")
```

## Example

#### Load packages

Please confirm that these packages are installed before trying this
example.

``` r
library(ROI)
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
