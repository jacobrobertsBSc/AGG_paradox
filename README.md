# The AGG_paradox

# Understanding the association of AGG codons with highly expressed genes, an artifact or an enigma? 

This project begins by using data from Goodman et al., (Causes and effects of N-terminal codon bias in bacterial genes 2013). This group took 137 endogenous E.coli genes and created over 14,000 constructs through by using two different reporters, 3 different ribosomal binding sites and 13 codon variants for the first 11 amino acids (including initiation Met) to understand how 5’ codons affect protein expression. In their data below, it is clear that the AGG codon is associated with the highest level of protein expression. However, this does not align with the avoidance of NGG codons and the preference for A&T bases within the 5' region of genes as described in ... Kudla et al. supported the concept that initiation is the limiting factor (check this is true) for the rate of protein translation, with 5' mRNA structure (-4 to +37 nucleotides from the start codon) explained 44% of the variation in flourescence levels

. mRNA Folding Near the Start Codon Strongly Influences Expression
The most important factor affecting expression was the mRNA secondary structure near the ribosome binding site (−4 to +37 nucleotides from the start codon).
mRNAs with strong secondary structure in this region had lower protein expression, likely because highly structured regions block translation initiation.
This explains 59% of the variation in fluorescence levels (protein expression).
4. Weakening 5' mRNA Secondary Structure Increases Expression
Adding a 28-codon tag with weak mRNA structure at the 5' end of the GFP genes increased expression.
This suggests that natural selection may favor weaker mRNA secondary structures near the start codon in endogenous E. coli genes.

<img width="640" alt="image" src="https://github.com/user-attachments/assets/89f121df-bf7e-4d86-be99-b4d23137524a" />


Within the paper, they presented their expression data in the form of log2 fold change which Dr Hurst finds strange. On top of this, in their CSV file they have three different metrics of how much expression occurs when measuring GFP as a reporter. I will look to use these metrics and hopefully other data to understand if the AGG paradox seen in the Goodman paper is something worth investigating. 
