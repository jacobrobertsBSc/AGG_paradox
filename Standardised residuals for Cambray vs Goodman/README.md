# Standardised residuals – From correlation between the Sub-sampled Cambray and Goodman data sets

This folder contains the necessary data, scripts, and output files to compute the standardised residuals for each codon and derive those that are significant outliers (>1.96)

## Contents

- `Cambray_Subsampled_logodds.csv`  
  - Log odds ratios for the sub-sampled Cambray dataset. Produced in folder 'Figure_3A'

- `log_odds_results_Transs.csv`  
  - Log odds ratios using the Trans metric from Goodman et al (2013). Produced in folder 'Figure_2A'

- `Standardised residuals.r`  
  - R script that calculates the standardised residuals and prints those that are outliers
    
---

## Output 

Standardises rediduals >1.96
 > ATA - 2.567095 / 
 > AGG - 3.227881

---

## To regenerate the plot

To re-calculate the standardised residuals, run the R script:

    ```r
    source("XY_Correlation_Sub_sampled_Cambray_Goodman.r")
    ```
