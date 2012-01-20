##############################################################
# rplos use-case: "What drives PLoS ONE's high impact factor?"
##############################################################
# Install rplos and other packages
setwd("/Users/ScottMac/github/rOpenSci/usecases/rplos/R")
# install.packages("devtools")
require(devtools)
install_github("rplos", "ropensci", "develop")
require(rplos)
<<<<<<< HEAD
require(plyr)
=======
require(plyr); require(RCurl); require(RJSONIO)
>>>>>>> edited code

# Citation distribution
GetAllDOIs <- function(search, start, sleep) {   # Get DOIs for all PLoS One articles
  Sys.sleep(sleep)
  searchplos(terms=search, 
            fields='id', 
            toquery=list('cross_published_journal_key:PLoSONE', 'doc_type:full'), 
            start=start, 
            limit=250)[[2]]
}
# results2 <- llply(seq(0,28750,250), # Set to seq(0,7500,250) to get all DOIs
#                   function(t) GetAllDOIs('*:*', t, sleep=0.3), .progress='text')
# results_ <- do.call(c, results2)
# save(results_, file="/Users/ScottMac/github/rOpenSci/usecases/rplos/R/rplos_allDOIs.Rdata")
load("/Users/ScottMac/github/rOpenSci/usecases/rplos/R/rplos_allDOIs.Rdata")

  # Trim whitespace
results_trim <- sapply(results_, str_trim, side='both', USE.NAMES=F) # trim whitespace

  # Get CrossRef citations for each DOI
getcites <- function(x) {
  out <- almplosallviews(x, 'crossref', F, F, 'json', sleep=0.1)$article$citations_count
  if(is.null(out) == TRUE)
    { NA } else
      { out }
}
crossrefcites <- laply(results_trim, getcites, .progress='text')

  # plot distribution
dat <- as.data.frame(crossrefcites)
ggplot(dat, aes(crossrefcites)) +
  theme_bw(base_size=18) +
  geom_histogram()

# growth of plos one
  # plot citations by year
    # get year published for each DOI
years <- laply(results_trim[1:1000], function(x) almdatepub(x, 'year', sleep=0.1), .progress='text')
  

  # combine citations and years for each DOI
# save(crossrefcites, results_, file="/Users/ScottMac/github/rOpenSci/usecases/rplos/R/rplos_allDOIs.Rdata")
citesyears <- data.frame(crossrefcites=crossrefcites[1:1000], years)
citesyears_ <- ddply(citesyears, .(years), summarise, 
                    meancites = mean(crossrefcites, na.rm=T),
                    numarticles = length(crossrefcites))

  # plot number of articles by year
ggplot(citesyears_, aes(years, meancites)) +
  theme_bw(base_size=18) +
  geom_line()

# keywords in the most cited articles
  # plosword() maybe as an option


# growth related to other plos journals
  # Get DOIs for all articles for a particular journal
GetAllDOIs <- function(journal, search, start, sleep) {   
  Sys.sleep(sleep)
  searchplos(terms=search, 
            fields='id', 
            toquery=list(paste('cross_published_journal_key:', journal, sep=''), 
                         'doc_type:full'), 
            start=start, 
            limit=250)[[2]]
}
GetAllDOIs('PLoSNTD', '*:*', 0, 0)


# alt-metrics about plos one articles

