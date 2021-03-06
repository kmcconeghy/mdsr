#' @title Descriptive Report of MDS File
#'
#' @description Outputs select analyses of an MDS data.frame object
#'
#' @usage mds_rpt_xls(mds_obj, 'mds.xlsx', .quietly=F)
#'
#' @param mds_obj A data.frame class object with MDS items.
#'
#' @param filepath Path to save excel file
#'
#' @param .quietly If FALSE, will print some output to console
#'
#' @return No return
#'
#' @export
#'
#' @examples
#' require(mdsR)
#' mds_dta <- mdsR::mds_cohort
#' mds_rpt_xls(mds_dta, 'mds.xslx')
#'
mds_rpt_xls <- function(mds_obj,
                        filepath = '',
                        .quietly = F) {

  obj_name <- rlang::enquo(mds_obj) %>% rlang::get_expr(.)

  # Must be dataframe
  if (all(class(mds_obj)!='data.frame')) stop('mds_obj not data.frame')
  if (mds_is_canon(mds_obj)==F) stop('mds_obj not canon, see ?mds_canon')

  #Must have certain columns
  std_columns <- c('bene_id_18900', 'dmdate', 'DMRECID')
  stopifnot(std_columns %in% names(mds_obj))

  ## Set-up file
  xl_style <- mds_rpt_sty()

  ## Set-up workbook
  xlsx.wb <- openxlsx::createWorkbook()
  options('openxlsx.borderColour' = '#4F80DB')
  options('openxlsx.borderStyle' = 'thin')
  openxlsx::modifyBaseFont(xlsx.wb, fontSize = 10, fontName ='Arial Narrow')

  openxlsx::addWorksheet(xlsx.wb, sheetName = 'MDS File')


  ## Title Box
  if (.quietly==F) {
    cat('General Report on Minimum Dataset File \n')
    cat('R gloal environ. object: ', rlang::quo_text(obj_name), '\n')
    cat('Date Created: ', Scotty::timestamp(), 'Programmer: ', 'KWM',  '\n')
  }

  ##Title
  openxlsx::writeData(xlsx.wb, 1,
                      'General Report on Minimum Dataset File',
                      startRow=1, startCol=1)
  openxlsx::addStyle(xlsx.wb, 1, style=xl_style$title, rows=1, cols=1)

  ## Subheading
  openxlsx::writeData(xlsx.wb, 1,
                      paste0('R gloal environ. object: ', rlang::quo_text(obj_name)),
                      startRow=2, startCol=1)

  openxlsx::writeData(xlsx.wb, 1, paste0('Date Created: ',
                                         Scotty::timestamp(),
                                         ', Programmer: ',
                                         'KWM'),
                      startRow=3, startCol=1)
  openxlsx::addStyle(xlsx.wb, 1, style=xl_style$subhead, rows=2:3, cols=1)

  ## Contents
  res <- mds_des(mds_obj)

  openxlsx::writeData(xlsx.wb, 1,
                      paste0('Observations: ', formatC(res$nrows, big.mark = ',')),
                      startRow=6, startCol=1)
  openxlsx::writeData(xlsx.wb, 1,
                      paste0('Columns: ', formatC(res$ncols, big.mark = ',')),
                      startRow=7, startCol=1)
  openxlsx::writeData(xlsx.wb, 1,
                      paste0('First assesment: ', res$first_asmt,
                             ', Late assessment: ', res$last_asmt),
                      startRow=8, startCol=1)
  openxlsx::writeData(xlsx.wb, 1,
                      paste0('No. distinct patients: ', formatC(res$n_patients, big.mark = ',')),
                      startRow=9, startCol=1)
  openxlsx::writeData(xlsx.wb, 1,
                      paste0('Assessment per patient: ', res$asmt_perpat),
                      startRow=10, startCol=1)
  openxlsx::writeData(xlsx.wb, 1,
                      paste0('Duplicates by DMRECID: ', res$n_duprecs),
                      startRow=11, startCol=1)

  openxlsx::addStyle(xlsx.wb, 1, style=xl_style$result, rows=6:11, cols=1)

  ## Save final workbook
    if (!missing(filepath)) {
      openxlsx::saveWorkbook(xlsx.wb, file=filepath, overwrite = T)
      } else {
      warning('no filepath specified, no results were outputted')
    }
}
