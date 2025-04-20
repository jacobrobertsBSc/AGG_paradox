# The AGG_paradox

# Understanding the association of AGG codons with highly expressed genes, an artifact or an enigma? 

Here, we investigate the biological relevance of a paradoxical association between the arginine codon **AGG** and high gene expression. This result was originally observed in [Goodman et al., 2013] and contradicts a widely supported theory suggesting that codons which promote stable mRNA secondary structures (G/C rich) suppress protein expression by hinderingg translation initiation (Allert, Cox, & Hellinga, 2010; Bentele et al., 2013; Cambray, Guimaraes & Arkin, 2018; Osterman et al., 2020; Nieuwkoop et al., 2023).

This project begins by analysing the **Goodman et al. (2013)** data set and then moving onto investigating if this paradox is observed in larger transgene data sets produced by **Cambray et al. (2018)** and **Osterman et al. (2020)**. We also assess whether differences in **sampling size**, **experimental design**, or **culture conditions** may account for an artifactual association of the AGG codons with high expression.

## Repository structure 

This repository contains:   
- Transgene datasets used  from published studies  
- Custom scripts used for processing these data sets, statistical analyses, and producing figures

## Figure folders 

There is a folder for each figure containing:
- The input data
- The scripts
- Output files (ggplots)

| Figure | Description | Script Path |
|--------|-------------|-------------|
| Fig 1  | Prot.FCC log odds analysis using data from Goodman et al. (2013) | `figures/fig1_goodman/` |
| Fig 2A | Trans log odds analysis using data from Goodman et al. (2013) | `figures/fig2A/` |
| Fig 2B | Trans.FCC log odds analysis using data from Goodman et al. (2013) | `figures/fig2B/` |
| Fig 3A | Trans log odds analysis using data from Cambray et al. (2018) | `figures/fig3A/` |
| Fig 3B | Correlation between trans metrics from Goodman et al. (2013) and Cambray et al. (2018) | `figures/fig3B/` |
| Fig 3C | Correlation between sub-sampled trans metric from Cambray et al. (2018) and Goodman et al. (2013) | `figures/fig3C/` |
| Fig 4A | Translation efficiency fraction (TEF) log odds analysis using data from Osterman et al. (2020) | `figures/fig4A/` |
| Fig 4B | Correlation between the log odds values derived from high and low nutrient experiments by Osterman et al. (2020) | `figures/fig4C/` |
  
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
- Tidy

## **Acknowledgements **

This project carried out as part of my final year project at The University of Bath. I would like to thank my supervisor Dr Laurence Hurst for his support throughout this work.

Goodman, D.B., Church, G.M. and Kosuri, S., 2013. Causes and Effects of N-Terminal Codon Bias in Bacterial Genes. Science, 342(6157), pp. 475-479.

Cambray, G., Guimaraes, J.C. and Arkin, A.P., 2018. Evaluation of 244,000 synthetic sequences reveals design principles to optimize translation in Escherichia coli. Nature Biotechnology, 36(10), pp. 1005-1015.

Osterman, I.A., Chervontseva, Z.S., Evfratov, S.A., Sorokina, A.V., Rodin, V.A., Rubtsova, M.P., Komarova, E.S., Zatsepin, T.S., Kabilov, M.R., Bogdanov, A.A., Gelfand, M.S., Dontsova, O.A. and Sergiev, P.V., 2020. Translation at first sight: the influence of leading codons. Nucleic Acids Research, 48(12), pp. 6931-6942.
