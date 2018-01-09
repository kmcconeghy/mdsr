library('devtools')

#Check Rtools
devtools::has_devel()

#Initial Set-up
setwd("~/GitHub/MDS")
setup("C:\\Users\\User\\Documents\\GitHub\\MDS")
# devtools::use_data_raw()
# devtools::use_gpl3_license()
# devtools::use_rcpp()
# devtools::use_test()
# devtools::use_package_doc()
# devtools::use_readme_rmd()
# devtools::use_news_md()

#Development
# devtools::use_dev_version()

#New Vignettes
# devtools::use_vignette("01-Introduction")

## Build
devtools::document()
devtools::check()
devtools::build()
devtools::test()
pkgdown::build_site()