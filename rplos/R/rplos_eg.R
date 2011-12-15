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
#     searchplos(terms=x, 
#               fields='id', 
#               toquery='doc_type:full', 
#               start=y, 
#               limit=250)[[2]]
    searchplos(terms=x, 
              fields='id', 
              toquery=list('cross_published_journal_key:PLoSONE', 'doc_type:full'), 
              start=y, 
              limit=250)[[2]]}
  llply(seq(0,1250,250), function(t) 
    searchplosfx(search, t), .progress='text')
}
results <- GetAllDOIs('*:*') # get all DOIs
results_ <- as.vector(sapply(results, function(x) x[[1]], simplify=T)) # to vector

  # Trim whitespace
results_trim <- sapply(results_, str_trim, side='both', USE.NAMES=F) # trim whitespace

  # Get total citation from all sources for each DOI
crossrefcites <- laply(results_trim, function(x) 
  almplosallviews(x, 'crossref', F, F, 'json')$article$citations_count, .progress='text')

  # plot distribution
dat <- as.data.frame(crossrefcites)
ggplot(dat, aes(crossrefcites)) +
  theme_bw(base_size=18) +
  geom_histogram() +

# keywords in the most cited articles



# growth of plos one
  # plot number of articles by year


# growth related to other plos journals



# alt-metrics about plos one articles


