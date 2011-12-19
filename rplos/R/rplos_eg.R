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
results2 <- llply(seq(0,500,250), function(t) GetAllDOIs('*:*', t, sleep=0.1), .progress='text')
results_ <- do.call(c, results2)

  # Trim whitespace
results_trim <- sapply(results_, str_trim, side='both', USE.NAMES=F) # trim whitespace

  # Get CrossRef citations for each DOI
crossrefcites <- laply(results_trim, function(x) 
  almplosallviews(x, 'crossref', F, F, 'json', sleep=0)$article$citations_count, 
  .progress='text')

  # plot distribution
dat <- as.data.frame(crossrefcites)
ggplot(dat, aes(crossrefcites)) +
  theme_bw(base_size=18) +
  geom_histogram()

# growth of plos one
  # plot citations by year
    # get year published for each DOI
years <- laply(results_trim, function(x) almdatepub(x, 'year', sleep=0.1), .progress='text')
  
    # combine citations and years for each DOI
citesyears <- data.frame(crossrefcites, years)
citesyears_ <- ddply(citesyears, .(years), summarise, 
                    meancites = mean(crossrefcites))

  # plot number of articles by year
ggplot(citesyears_, aes(years, meancites)) +
  theme_bw(base_size=18) +
  geom_line()

# keywords in the most cited articles
  # plosword() maybe as an option


# growth related to other plos journals



# alt-metrics about plos one articles

