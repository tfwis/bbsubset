#' Transform a barcode set to a binary matrix
#'
#' @param S barcode set
#' @export
#'
matACTG <- function(S) sapply(strsplit(S,""), function(x) code[,x])

#' Extract well-balanced subset minimizing abs(error) with LP
#'
#' @param S barcode set
#' @param k the size of barcode subset to extract
#' @param ... pass to `ROI_solve`. Please see the examples below.
#' @returns \item{subset}{The oprimal barcode subset} \item{model}{The model
#' for calculation to obtain optimal barcodes subset with \code{ROI_solve()}}
#' \item{Others}{Please check \code{?ROI::ROI_solve}}
#' @examples
#' bbsubset(sample_barcodes,k=8)
#'
#' # Set a timeout
#' bbsubset(sample_barcodes,k=5,timeout=10)
#'
#' # Use the other LP solver
#' \dontrun{
#' library(ROI.plugin.gurobi)
#' bbsubset(sample_barcodes,k=8,solver="gurobi")}
#'
#' @importFrom ROI OP
#' @importFrom ROI L_constraint
#' @importFrom ROI ROI_solve
#' @importFrom slam as.simple_triplet_matrix
#' @import ROI.plugin.lpsolve
#' @export
#'
bbsubset <- function(S,k,...) {
  y <- rep(k*1/4,4*nchar(S[1]))
  N <- length(S)
  M <- length(y)
  B <- matACTG(S)
  A <- rbind(
    rep(c(1,0),c(N,M)),
    cbind(B, diag(M)),
    cbind(B,-diag(M))
  )
  #cat("Problem constructed.",fill=TRUE)
  model <- ROI::OP(
    # minimize \sum t_i
    objective = rep(c(0,1),c(N,M)),
    constraints = ROI::L_constraint(
      L = slam::as.simple_triplet_matrix(A),
      dir = rep(c("==",">=","<="),c(1,M,M)),
      rhs = c(k,y,y),
      names = c(paste0("x",seq(N)),paste0("t",seq(M)))
    ),
    types = rep(c("B","C"),c(N,M))
  )
  re <- ROI::ROI_solve(model,...)
  re$model  <- model
  re$subset <- S[as.logical(round(re$solution[seq(N)]))]
  return(re)
}

#' Create a table of nucleotide ratio
#'
#' @param s barcode subset extracted by bbsubset
#' @export
#'
basecomp <- function(s) {matrix(rowSums(matACTG(s)),nrow=4,dimnames=list(colnames(code)))}

#' Sample barcodes
#'
#' A dataset containing 76 DNA barcode.Their length are 6 base pair and
#' they are three humming distances apart from each other.
#' This data set is created by `DNABarcodes`
#'
#' @format A vactor with 76 elements
#'
"sample_barcodes"
