##############################################################
# rplos use-case: "What drives PLoS ONE's high impact factor?"
##############################################################
# Install rplos and other packages
require(devtools); require(ggplot2)
install_github("rplos", "ropensci")
require(rplos)

# citation distribution
  # Get DOIs for all PLoS One articles
searchplos('the', 'id', 1000)

  # Get total citation from all sources for each DOI
almtotcites()


# keywords in the most cited articles



# growth of plos one



# growth related to other plos journals



# alt-metrics about plos one articles


