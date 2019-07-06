R data package with Arabidopsis MAGIC lines genotypes for use with the 
[R/qtl2 package](https://kbroman.org/qtl2/).

----

## Installation

The package depends on R/qtl2 package, which is not on CRAN yet, so it's best to 
install that first and then `atMAGIC` from this github repository:

```r
# Install qtl2
install.packages("qtl2", repos="http://rqtl.org/qtl2cran")

# Install atMAGIC
devtools::install_github("tavareshugo/atMAGIC")
```

----

## Basic usage

(this is very basic quick start, a proper vignette will hopefully follow sometime)

The package provides with a `cross2` object with MAGIC line genotypes:

```r
library(atMAGIC) # this loads qtl2 as well

# Load the data to the environment
data("kover2009")

# Look at its documentation for more details
?kover2009
```

This object only contains genotype data, with no phenotype information. 

At the moment, R/qtl2 does not seem to offer a method to add phenotypes to an 
existing `cross2` object. I've written a helper function to do this, that can 
be loaded from [this gist](https://gist.github.com/tavareshugo/b10c3dca303c28b2d161e439a6ffcac6)

```r
# load `add_pheno` function
devtools::source_gist("b10c3dca303c28b2d161e439a6ffcac6", filename = "add_pheno.R")
```

Now you can add an existing `data.frame` with phenotype data to the `kover2009`
object. For example:

```r
# Read example data
pheno <- read.table("http://mtweb.cs.ucl.ac.uk/mus/www/magic/MAGIC.phenotype.example.12102015.txt",
                    header = TRUE)
                    
# Add to kover2009
kover2009 <- add_pheno(kover2009, pheno, idcol = "SUBJECT.NAME")
```

After this you can proceed with a similar analysis as explained in the 
[R/qtl2 documentation](https://kbroman.org/qtl2/assets/vignettes/user_guide.html#qtl_analysis_in_diversity_outbred_mice) 
for the diversity outbred mice. Very briefly:

```r
# Calculate genotype probabilities
kover2009_probs <- calc_genoprob(kover2009)

# Run a QTL scan
out <- scan1(kover2009_probs, kover2009$pheno)

# Run permutations for genome-wide threshold (increase n_perm in real analysis)
kover2009_perm <- scan1perm(kover2009_probs, kover2009$pheno, n_perm = 10)
kover2009_threshold <- summary(kover2009_perm)

# Quick visualisation
plot(kover2009_scan, kover2009$pmap, lodcolumn = "days.to.bolt")
abline(h = kover2009_threshold[,"days.to.bolt"])

# Find peaks above certain threshold (should base it on permutation threshold from above)
find_peaks(kover2009_scan, kover2009$pmap, threshold = 10)
```

