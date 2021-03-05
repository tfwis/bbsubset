
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

#### Load sample barcode data

``` r
#mdsfile <- "~/R/bbsubset/CS96_d4_n24_sort.csv"
#barcodes <- lapply(scan(mdsfile, "char", skip=1),function(x) unlist(strsplit(x,','))[-1])[[1]]
```

##### Create bacode set by `DNABarcodes`

``` r
barcodes <- DNABarcodes::create.dnabarcodes(n=6, dist=3)
```

#### The bbsubset part

##### Extract subset

``` r
library(ROI.plugin.lpsolve)
myset <- bbsubset::bbsubset(barcodes,12)
myset$subset
```

    ##  [1] "CCACAA" "GCGTAA" "TACGCA" "ATGGAG" "ACAAGG" "CTTAGG" "TGCATC" "AAGGTC"
    ##  [9] "GAACTC" "TGTCGT" "CTCTCT" "GGTTCT"

``` r
bbsubset::basecomp(myset$subset)
```

    ##   1bp 2bp 3bp 4bp 5bp 6bp
    ## A   3   3   3   3   3   3
    ## C   3   3   3   3   3   3
    ## T   3   3   3   3   3   3
    ## G   3   3   3   3   3   3

##### Subset extraction performed by `gurobi`

``` r
library(ROI.plugin.gurobi)
myset <- bbsubset::bbsubset(barcodes,12)
bbsubset::basecomp(myset$subset)
```

    ##   1bp 2bp 3bp 4bp 5bp 6bp
    ## A   3   3   3   3   3   3
    ## C   3   3   3   3   3   3
    ## T   3   3   3   3   3   3
    ## G   3   3   3   3   3   3
