# Figure 2C–E – Correlation of codon enrichment between the three different Goodman et al (2013) metrics

This folder contains the data, scripts, and output files to recreate Figure 2C–E, this compares codon-level log odds results across the three expression metrics from Goodman et al. (2013). Each plot shows a Pearson correlation between two of these metrics:

These are:
- Prot.FCC - protein level (by flourescence), relative to the mean of the 13 transgene codon variants
- Trans.FCC - translation efficency (protein/RNA), relativee to to the mean of the 13 trangene codon variants 
- Trans - translation efficiency (protein/RNA)
---

## Contents

- `Prot_FCC_log_odds.csv`  
  - Log odds calculated from Prot.FCC values.

- `Trans_FCC_log_odds.csv`  
  - Log odds calculated from Trans.FCC values.

- `Trans_log_odds.csv`  
  - Log odds Trans values.

- `XY_Correlations_Pearson_Goodman.r`  
  - R script generates the three-panel correlation plot.

- `Figure_2C-E.pdf`  
  - Final output showing three scatter plots:
    - Prot.FCC vs Trans.FCC
    - Prot.FCC vs Trans
    - Trans.FCC vs Trans

---

## Plots

All three correlations are strong, indicating high predictiveness between the different expression metrics and suggesting the AGG paradox is not an artifact of the use of prot.FCC in Goodman et al (2013)

---

## To regenerate the figure

Run the R script:

```r
source("XY_Correlations_Pearson_Goodman.r")
