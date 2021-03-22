
<!-- README.md is generated from README.Rmd. Please edit that file -->

# bbsubset

<!-- badges: start -->
<!-- badges: end -->

## What’s this for ?

When you have or create a DNA barcode, the size is often larger than you
want. `bbsubset` is a simple tool for R to select a subset of DNA
barcodes from the fullset in terms of avoiding the sequence error.

## Installation

### Install the devtools package

To install `bbsubset`, start by installing the `devtools` package. The
best way to do this is from CRAN with:

``` r
install.packages("devtools")
```

### Install bbsubset

Install bbsubset from GitHub with devtools

``` r
devtools::install_github("tfwis/bbsubset")
```

## Input file

The fullset of DNA barcode is needed to be entered in vector class, and
One element of a vector is one barcode.

``` r
head(bbsubset::sample_barcodes)
#> [1] "GGAGAA" "CAGGAA" "ACCGAA" "CCACAA" "AGGCAA" "GACCAA"
```

## Wrokflow

**Step1: Preperation of the input file**  
**Step2: Selecet LP solver**  
**Step3: Extract subset by `bbsubset`**

## Tutorial

#### Load packages

Please confirm that these packages are installed before trying this
example.

``` r
library(ROI)
library(slam)
```

#### Create barcode set by `DNABarcodes`

The DNA barcode sets created by `DNABarcodes` meets the requirement for
input file descreibed above.  
Usage of `DNABarcodes` is
[here](https://bioconductor.org/packages/release/bioc/vignettes/DNABarcodes/inst/doc/DNABarcodes.html)

``` r
barcodes <- DNABarcodes::create.dnabarcodes(n=6, dist=3)
#> 1) Creating pool ...  of size 1160
#> 2) Conway closing...  done
```

### Select LP solver

`bbsubset` have tolerate to select LP solver via ROI.  
By default, solver is set to `lpsolve`. So if you want to run `bbsubset`
by default, library `ROI.plugin.lpsolve`.

``` r
library(ROI.plugin.lpsolve)
```

### Extract subset

``` r
myset <- bbsubset::bbsubset(barcodes,12)
myset$subset
#>  [1] "CCACAA" "GCGTAA" "TACGCA" "ATGGAG" "ACAAGG" "CTTAGG" "TGCATC" "AAGGTC"
#>  [9] "GAACTC" "TGTCGT" "CTCTCT" "GGTTCT"
```

### Validate nucleotide balance

`bbsubset::basecomp()` enables to validate the nucleotide balance of the
subset.  
Each column shows the number of nucleotides in each position.

``` r
bbsubset::basecomp(myset$subset)
#>   [,1] [,2] [,3] [,4] [,5] [,6]
#> A    3    3    3    3    3    3
#> C    3    3    3    3    3    3
#> T    3    3    3    3    3    3
#> G    3    3    3    3    3    3
```

## Option

### Set timeout

You can set a timeout. How to set the timeout depends on the solver,
please check the API of each solver. In the following code, `lpsolve` is
used.

``` r
myset <- bbsubset::bbsubset(barcodes,5,timeout=10) 
```

### Subset extraction with other LP solver

Show the case of using other solver. (e.g. gurobi)

``` r
library(ROI.plugin.gurobi)
myset <- bbsubset::bbsubset(barcodes,12,Solver="gurobi")
bbsubset::basecomp(myset$subset)
#>   1bp 2bp 3bp 4bp 5bp 6bp
#> A   3   3   3   3   3   3
#> C   3   3   3   3   3   3
#> T   3   3   3   3   3   3
#> G   3   3   3   3   3   3
```
