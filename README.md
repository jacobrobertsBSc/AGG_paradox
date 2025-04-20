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

Figure	  Description	Script Path
Fig 1   	Prot.FCC log odds analysis using data from Goodman et al (2013).	figures/fig1_goodman/
Fig 2A/B	Trans and Trans.FCC log odds analysis using data from Goodman et al (2013).	figures/fig2A/ or figures/fig2B/
Fig 3A	  Trans log odds analysis using data from Cambray et al (2018). figures/fig3A/
Fig 3B    Correlation between trans metric data sets from Goodman et al (2013) and Cambray et al (2018). figures/fig3B/
Fig 3C    Correlation between sub-sampled trans metric from Cambray et al (2018) and Goodman et al (2013). figures/fig3C/
Fig 4A    Translation efficiency fraction (TEF) log odds analysis using data from Osterman et al (2020). figures/fig4C/
Fig 4B    Correlation between the log odds values derived from high and low nutrients experiments performed by Osterman et al (2020). figures/fig4C/
  
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

## Figures and Scripts
