##############################################################
# rplos use-case: "What drives PLoS ONE's high impact factor?"
##############################################################
# Install rplos and other packages
require(devtools)
install_github("rplos", "ropensci")
require(rplos)

# Citation distribution
GetAllDOIs <- function(search, start, sleep) {   # Get DOIs for all PLoS One articles
  Sys.sleep(sleep)
  searchplos(terms=search, 
            fields='id', 
            toquery=list('cross_published_journal_key:PLoSONE', 'doc_type:full'), 
            start=start, 
            limit=250)[[2]]
}
results2 <- llply(seq(0,500,250), function(t) GetAllDOIs('*:*', t, sleep=0.2), .progress='text')
results_ <- do.call(c, results2)

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
plosword()


# growth of plos one
  # plot number of articles by year


# growth related to other plos journals



# alt-metrics about plos one articles

