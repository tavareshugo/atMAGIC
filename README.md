
R data package with Arabidopsis MAGIC lines genotypes for use with the
[R/qtl2 package](https://kbroman.org/qtl2/).

-----

## Installation

You can install this package directly from GitHub (copy/paste this block
of code to your console):

``` r
# install the remotes package if not installed already
if (!("remotes" %in% rownames(installed.packages()))){
  install.packages("remotes")
}

# Install atMAGIC
remotes::install_github("tavareshugo/atMAGIC")
```

-----

## Basic usage

The package provides with a `cross2` object with MAGIC line genotypes:

``` r
library(atMAGIC) # this loads qtl2 as well

# Load the data to the environment
data("kover2009")

# Look at its documentation for more details
?kover2009
```

This object only contains genotype data, with no phenotype information.

At the moment, R/qtl2 does not offer a function to add phenotypes to an
existing `cross2` object. I’ve written a helper function to do this,
which is part of the [`qtl2helper`
package](https://github.com/tavareshugo/qtl2helper) (follow link for
installation instructions).

``` r
library(qtl2helper)

# Read example data
pheno <- read.table("http://mtweb.cs.ucl.ac.uk/mus/www/magic/MAGIC.phenotype.example.12102015.txt",
                    header = TRUE)
                    
# Add to kover2009
kover2009 <- add_pheno(kover2009, pheno, idcol = "SUBJECT.NAME")
```

After this you can proceed with a similar analysis as explained in the
[R/qtl2
documentation](https://kbroman.org/qtl2/assets/vignettes/user_guide.html#qtl_analysis_in_diversity_outbred_mice)
for the diversity outbred mice. Very briefly:

``` r
# Calculate genotype probabilities
kover2009_probs <- calc_genoprob(kover2009)

# Run a QTL scan
kover2009_scan <- scan1(kover2009_probs, kover2009$pheno)

# Run permutations for genome-wide threshold (increase n_perm in real analysis)
kover2009_perm <- scan1perm(kover2009_probs, kover2009$pheno, n_perm = 10)
kover2009_threshold <- summary(kover2009_perm)

# Quick visualisation
plot(kover2009_scan, kover2009$pmap, lodcolumn = "days.to.bolt")
abline(h = kover2009_threshold[,"days.to.bolt"])
```

![](figures/README-example-1.png)<!-- -->

``` r
# Find peaks above certain threshold (should base it on permutation threshold from above)
find_peaks(kover2009_scan, kover2009$pmap, threshold = 10)
```

    ##   lodindex      lodcolumn chr      pos      lod
    ## 1        1 bolt.to.flower   4    48813 12.81461
    ## 2        1 bolt.to.flower   5  3177500 14.41196
    ## 3        2   days.to.bolt   1 19778899 12.54174
    ## 4        2   days.to.bolt   4   301329 30.22150
    ## 5        2   days.to.bolt   5  3176796 19.30336
    ## 6        3   days.to.germ   3 16163881 12.29746
