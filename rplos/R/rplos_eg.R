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

  # Trim whitespace
results_trim <- sapply(results_, str_trim, side='both', USE.NAMES=F) # trim whitespace

  # Get total citation from all sources for each DOI
crossrefcites <- laply(results_trim[1:15], function(x) 
  almplosallviews(x, 'crossref', F, F, 'json')$article$citations_count, .progress='text')

# keywords in the most cited articles



# growth of plos one



# growth related to other plos journals



# alt-metrics about plos one articles


