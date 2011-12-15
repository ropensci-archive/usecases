##############################################################
# rplos use-case: "What drives PLoS ONE's high impact factor?"
##############################################################
# Install rplos and other packages
require(devtools)
install_github("rplos", "ropensci")
require(rplos)

# Citation distribution
GetAllDOIs <- function(search) {   # Get DOIs for all PLoS One articles
  searchplosfx <- function(x, y){
    searchplos(terms=x, 
              fields='id', 
              toquery='doc_type:full', 
              start=y, 
              limit=250)[[2]]}
  llply(seq(0,30000,250), function(t) 
    searchplosfx(search, t), .progress='text')
}
results <- GetAllDOIs('*:*') # get all DOIs
results_ <- as.vector(sapply(results, function(x) x[[1]], simplify=T)) # to vector

  # Get article DOIs only (i.e., remove image DOIs)
DO THIS BEFORE NEXT STEP

  # Get total citation from all sources for each DOI
almtotcites(str_trim(as.character(results[[1]][1,1]), "both"))
almtotcites(str_trim(results_[1], "both"))
citesout <- laply(results_[1:15], function(x) almtotcites(str_trim(x,'both')), .progress='text')


# keywords in the most cited articles



# growth of plos one



# growth related to other plos journals



# alt-metrics about plos one articles


