# Figure 1 – Prot.FCC log odds analysis (Goodman et al., 2013)

This folder contains the necessary data, scripts and output files to recreate Figure 1. This shows the log odds ratios for each codon being enriched in the 5'end of mRNA constructs associated with the highest protein levels (prot.FCC) compared to those with the lowest, relative to its synonyms. This uses data from Goodman et al (2013)

---
##  Contents

- `1241934tables1.csv`  
  > Input dataset from Goodman et al. (2013), containing Prot.FCC, Trans.FCC and Trans expression metrics.
  > This can be sourced from the supplementary resourcs at https://www.science.org/doi/10.1126/science.1241934#supplementary-materials

- `ProtFCC_Log_odds.py`  
  > Python script used to calculate the log odds ratios and standard errors from the Goodman Prot.FCC dataset.

- `ProtFCC_log_odds_results.csv`  
  > Output from the above script containing log odds and standard errors for each codon

- `Fig1.R`  
  > R script that uses the above CSV file to generate the ggplot bar plot 

- `figure1.pdf`  
  > Final output showing codon log odds ratios with bars coded by the 3rd nucleotide and standard error bars

---

## Plot

![Figure 1](figure1.png)

AGG still appears positively associated with high protein levels — replicating the paradox observed when displaying the prot.FCC as log2 fold change as in Goodman et al (2013).

---

## To regenerate the figure

1. To compute log odds (if you want to recreate 'ProtFCC_log_odds_results.csv'), run the python script:
   ```bash
   python ProtFCC_Log_odds.py

2. To generate the plot, run the R script: 
    ```r
    source("Fig1.R")
    ```

