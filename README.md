# Resolving the 'AGG paradox'

# Understanding the association of AGG codons with highly expressed transgenes, an artifact or an enigma? 

Here, we investigate the biological relevance of a paradoxical association observed between the arginine codon **AGG** and high gene expression. This result was originally observed in [Goodman et al., 2013] and contradicts a widely supported theory suggesting that codons which promote stable mRNA secondary structures (G/C rich), suppress protein expression by hinderingg translation initiation (Allert, Cox, & Hellinga, 2010; Bentele et al., 2013; Cambray, Guimaraes & Arkin, 2018; Osterman et al., 2020; Nieuwkoop et al., 2023).

This project begins by analysing the **Goodman et al. (2013)** data set and then moves onto investigate if this paradox is observed in larger transgene data sets produced by **Cambray et al. (2018)** and **Osterman et al. (2020)**. We ask what sequence features predict translation efficiency and assess whether differences in **sampling size**, **experimental design**, or **culture conditions** may account for an artifactual association of the AGG codons with high transgene expression.

## Repository structure 

This repository contains:   
- Transgene datasets used from published studies  
- Custom scripts used for processing these data sets, statistical analyses, and producing figures

## Figure folders 

There is a folder for each figure containing:
- The input data
- The scripts
- Output files (ggplots)

| Figure | Description | 
|--------|-------------|
| Figure_1  | Prot.FCC log odds analysis using data from Goodman et al (2013) |
| Figure_2A | Trans log odds analysis using data from Goodman et al (2013) |
| Figure_2B | Trans.FCC log odds analysis using data from Goodman et al (2013) |
| Figure_2C-E | Correlations between the three metrics from Goodman et al (2013)|
| Figure_3A | Trans log odds analysis using data from Cambray et al (2018) |
| Figure_3B | Correlation between trans metrics from Goodman et al (2013) and Cambray et al. (2018) |
| Figure_3C | Correlation between sub-sampled trans metric from Cambray et al. (2018) and Goodman et al (2013) |
| Figure_4A | Translation efficiency fraction (TEF) log odds analysis using data from Osterman et al (2020) |
| Figure_4B | Correlation between the log odds values derived from high and low nutrient experiments by Osterman et al (2020) |
| Figure_5  | Correlation between translation efficiency and 5' stability, 3' stability, and CAI using data from Cambray et al (2018)| 
## To download the repository...

```bash
git clone https://github.com/yourusername/AGG_paradox.git
cd AGG_paradox
```
## Dependencies
**Python version 3.12.8**
- Pandas (version 2.2.3)
- Scipy (version 1.15.2)

**R version 4.4.2**
- ggplot2
- ggrepel
- gridExtra
- Tidyverse

## **Acknowledgements **

This project was carried out as part of my final year project at The University of Bath. I would like to thank my supervisor Dr Laurence Hurst for his support throughout this work.

Goodman, D.B., Church, G.M. and Kosuri, S., 2013. Causes and Effects of N-Terminal Codon Bias in Bacterial Genes. Science, 342(6157), pp. 475-479.

Cambray, G., Guimaraes, J.C. and Arkin, A.P., 2018. Evaluation of 244,000 synthetic sequences reveals design principles to optimize translation in Escherichia coli. Nature Biotechnology, 36(10), pp. 1005-1015.

Osterman, I.A., Chervontseva, Z.S., Evfratov, S.A., Sorokina, A.V., Rodin, V.A., Rubtsova, M.P., Komarova, E.S., Zatsepin, T.S., Kabilov, M.R., Bogdanov, A.A., Gelfand, M.S., Dontsova, O.A. and Sergiev, P.V., 2020. Translation at first sight: the influence of leading codons. Nucleic Acids Research, 48(12), pp. 6931-6942.
