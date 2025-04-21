# Standardised residuals – From correlation between the Sub-sampled Cambray and Goodman data sets

This folder contains the necessary data, scripts, and output files to compute the standardised residuals for each codon and derive those that are significant outliers (>1.96)

## Contents

- `Cambray_Subsampled_logodds.csv`  
  - Log odds ratios for the sub-sampled Cambray dataset.

- `log_odds_results_Transs.csv`  
  - Log odds ratios using the Trans metric from Goodman et al (2013).

- `Standardised residuals.r`  
  - R script that calculates the standardised residuals and prints those that are outliers
    
---

## Output 

  Codon Goodman.logodds Subsampled_Cambray.logodds std_resid
19   ATA           0.706                   0.227674  2.567095
39   AGG           0.723                  -0.120362  3.227881
---

## To regenerate the plot

To re-calculate the standardised residuals, run the R script:

    ```r
    source("XY_Correlation_Sub_sampled_Cambray_Goodman.r")
    ```
