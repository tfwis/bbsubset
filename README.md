
<!-- README.md is generated from README.Rmd. Please edit that file -->

# bbsubset

<!-- badges: start -->
<!-- badges: end -->

## What’s this for ?

Designing *good* custom DNA barcodes and selecting a *good* subset of
oligo pool in your laboratory involves a problem of combinatorial optimizations.

This R package `bbsubset` is dedicated for the purpose, and select a subset of DNA sequences
that are *well-balanced* in terms of nucleosties composition.

## Installation

`install.packages("devtools")` if you haven't installed it.

Then run,

``` r
devtools::install_github("tfwis/bbsubset")
```

## The workflow

* Step1: Prepere your candidate DNA barcode pool
* Step2: Extract the well-balanced subset from the pool

## Tutorial

## The purpose

Design the 12 DNA barcordes for my custom NGS library that meets the requirements.

* well-balanced nucleotides to avoid sequencing errors
* 1 error correction: at least having 3 different bases each other)

### 1. Create barcode set by `DNABarcodes`

[`DNABarcodes`](https://bioconductor.org/packages/release/bioc/vignettes/DNABarcodes/inst/doc/DNABarcodes.html) is
the great tool for creating error torelant barcode set.

Let us use this as a starting material of DNA barcode pool.

``` r
barcodes <- DNABarcodes::create.dnabarcodes(n=6, dist=3)
#> 1) Creating pool ...  of size 1160
#> 2) Conway closing...  done
```
This procuces the pool of 6 length DNA barcodes
with 3 hamming distance from each other
(i.e., 1 error correction is available).

### 2. Extract the subset

Select well-balanced 12 barcodes from the barcode pool.

``` r
myset <- bbsubset::bbsubset(barcodes,12)
myset$subset
#>  [1] "CCACAA" "GCGTAA" "TACGCA" "ATGGAG" "ACAAGG" "CTTAGG" "TGCATC" "AAGGTC"
#>  [9] "GAACTC" "TGTCGT" "CTCTCT" "GGTTCT"
```

### Validate nucleotide balance

`basecomp` to show nucleotides numbers at each position (1-6).

``` r
bbsubset::basecomp(myset$subset)
#>   [,1] [,2] [,3] [,4] [,5] [,6]
#> A    3    3    3    3    3    3
#> C    3    3    3    3    3    3
#> T    3    3    3    3    3    3
#> G    3    3    3    3    3    3
```

This result is perfect.

## Advanced options

### Setting timeout in lpsolve

You can set a timeout to limit the computation time.

Since the name of the option is depend on the selected solver,
please see the reference manuals. 

The following example set limtits up to 10 seconds in `lpsolve`.

``` r
myset <- bbsubset::bbsubset(barcodes,5,timeout=10) 
```

https://cran.r-project.org/web/packages/lpSolve/index.html

### Changing solver

`bbsubset` is free to select LP solver via [ROI](http://roi.r-forge.r-project.org) infrastructure.

If you need more speed for computation,
you can try the commercial solver like Gurobi.

``` r
library(ROI.plugin.gurobi)
myset <- bbsubset::bbsubset(barcodes,12,solver="gurobi")
bbsubset::basecomp(myset$subset)
#>   [,1] [,2] [,3] [,4] [,5] [,6]
#> A    3    3    3    3    3    3
#> C    3    3    3    3    3    3
#> T    3    3    3    3    3    3
#> G    3    3    3    3    3    3
```

See the Gurobi document for the installation and the API reference.

https://www.gurobi.com/documentation/

Available solvers in ROI are listed in the R-Forge page.

https://roi.r-forge.r-project.org
