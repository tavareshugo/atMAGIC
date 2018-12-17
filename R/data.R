#' kover2009 MAGIC genotypes
#'
#' A `cross2` object containing genotype data for the Arabidopsis MAGIC lines as
#' described in [Kover et al. (2009)](https://doi.org/10.1371/journal.pgen.1000551).
#'
#' @md
#'
#' @details The data used to create this object were downloaded from Richard Mott's
#' server, currently hosted at: http://mtweb.cs.ucl.ac.uk/mus/www/magic/.
#'
#' According to the website's description:
#' > "Note that the original 2009 paper used only 527 MAGIC lines and was based on the TAIR8 genome.
#' The data and resources for MAGIC now available on this page have been expanded to 703 genotyped
#' lines and the SNPs remapped to TAIR9/TAIR10."
#'
#' This fact might explain some discrepancies in the SNP coordinates between the data
#' processed here and [the data processed by Karl Broman](https://github.com/rqtl/qtl2data/tree/master/ArabMAGIC),
#' who used the supplementary file from [Gnan et al. (2014)](https://doi.org/10.1534/genetics.114.170746).
#'
#' @format A `cross2` object with genotype information for all 703 MAGIC lines.
"kover2009"


