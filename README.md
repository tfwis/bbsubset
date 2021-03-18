
# bbsubset

## What's this for ?

bbsubset is a simple tool for R to selecet a subset of DNA barcodes from the fullset where each conponent is distant enough.

## Installation

You can install `bbsubset` with:

``` r
devtools::install_github("tfwis/bbsubset")
```

## Usage

### Input

The fullset of DNA barcode is needed to be entered in vector class, and One element of a vector is one barcode.






## Tutorial

#### Load packages

Please confirm that these packages are installed before trying this
example.

``` r
library(ROI)
library(slam)
```

#### Create barcode set by `DNABarcodes`


The DNA barcode sets created by `DNABarcodes` meets the requirement for input file descreibed above.　　
Usage of `DNABarcodes` is [here](https://bioconductor.org/packages/release/bioc/vignettes/DNABarcodes/inst/doc/DNABarcodes.html)

``` r
barcodes <- DNABarcodes::create.dnabarcodes(n=6, dist=3)
```

#### Select LP solver

`bbsubset` have tolerate to select LP solver via ROI.

``` r
library(ROI.plugin.lpsolve)
```

#### Extract subset



``` r
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
