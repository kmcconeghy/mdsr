#' mds_varlist: A standard dictionary
#'
#' Standard MDS data dictionary; includes list of variables and attributes. If
#' not specified otherwise, all tests / format checks will use this file for
#' comparison.
#'
#' @format A data frame with XX rows and 7 variables:
#' \describe{
#'   \item{item}{Variable Name}
#'   \item{label}{Variable Label}
#'   \item{description}{Long form description of variable}
#'   \item{class}{short hand, type of function to call for variable}
#'   \item{category}{MDS item section header (short-hand)}
#'   \item{SetMissToZero}{Items which can be assumed 'no' is missing}
#'   \item{default_ref}{For factor variables, reference value}
#'   \item{default_label}{For factor variables, label of reference value}
#' }
"mds_varlist"
