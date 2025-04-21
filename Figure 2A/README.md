# Figure 2A – Trans log odds analysis (Goodman et al., 2013)

## This folder contains the necessary data, scripts output files to recreate Figure 2A, which assesses if the AGG paradox remains when using the translation efficiency metric. To do this log odds ratios were calculated for each codon being enriched in the 5'end of mRNA constructs associated with the highest translation efficiencies compared to those with the lowest, relative to its synonyms. This uses data from Goodman et al (2013)
---
##  Contents

- `1241934tables1.csv`  
  - Input dataset from Goodman et al. (2013), containing Prot.FCC, Trans.FCC and Trans expression metrics.

- `Trans_Log_odds.py`  
  - Python script used to calculate the log odds ratios and standard errors from the Goodman Trans.FCC dataset.

- `log_odds_results_transs.csv`  
  - Output from the above script containing log odds and standard errors for each codon

- `Fig2A.R`  
  - R script that uses the above CSV file to generate the ggplot bar plot 

- `figure_2A.pdf`  
  - Final output showing codon log odds ratios with bars coded by the 3rd nucleotide and standard error bars

---

## Plot

AGG appears as an outlier codon positively associated with high expression — supporting the paradox observed when using the Prot.FCC metric.

---

## To regenerate the figure

1. **Run the Python script** to compute log odds (if you want to recreate 'log_odds_results_transs.csv' ):
   ```bash
   python Trans_Log_odds.py

2. **Run the R script** to generate the plot: 
    ```r
    source("Fig2A.R")
    ```
