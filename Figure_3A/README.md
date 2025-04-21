# Figure 3A – Trans log odds analysis from Cambray et al (2018) data set

This folder contains the necessary data, scripts output files to recreate Figure 3A. This investigates whether the AGG paradox is observed in a large-scale synthetic transgene dataset published by Cambray et al. (2018).

In this analysis, translation efficiency for each construct was calculated using Cambray’s protein and RNA level metrics. Log odds ratios were then computed for codons enriched in the 5′-ends of constructs associated with the highest translation efficiencies compared to those with the lowest, relative to their synonymous codons.

---
##  Contents

- `Cambray.csv`  
  - Input data with RNA and protein counts for 244,000 transgenes (includes `clean.lin.prot.mean` and `ss.rna.dna.mean` columns)
  - As this file is too large, `Cambray.csv` is available via https://static-content.springer.com/esm/art%3A10.1038%2Fnbt.4238/MediaObjects/41587_2018_BFnbt4238_MOESM58_ESM.zip
  - Please rename this file to 'Cambray.csv' for the scripts to work
    
- `Cambray_Log_odds.py`  
  - Python script used to calculate the log odds ratios and standard errors from the Goodman Prot.FCC dataset.

- `log_odds_results_Cambray.csv`  
  - Output from the above script containing log odds and standard errors for each codon

- `Fig3A.R`  
  - R script that uses the above CSV file to generate the ggplot bar plot 

- `figure3A.pdf`  
  - Final output showing codon log odds ratios with bars coded by the 3rd nucleotide and standard error bars

---

## Plot

Unlike in Goodman et al. (2013), AGG shows a negative log odds ratio, suggesting a suppressive effect on expression. 

---

## To regenerate the figure

1. To compute log odds (if you want to recreate 'log_odds_results_Cambray.csv' ):
   ```bash
   python Cambray_Log_odds.py

2. To generate the plot, run the R script: 
    ```r
    source("Fig3A.R")
    ```
