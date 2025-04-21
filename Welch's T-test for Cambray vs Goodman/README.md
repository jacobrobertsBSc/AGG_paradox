# Welch’s t-test – Investigating systemic differences in translation efficiency distribution between the Goodman vs Cambray data sets

This folder contains the data and script used to perform an unpaired Welch’s t-test comparing the translation efficiency values from Goodman et al (2013) and Cambray et al (2018) datasets.

This test shows if the Goodman values are on average higher than those from the Cambray data set, this may give insight into the unusual AGG codon behavior seen in Goodman et al (2013)

---

## Contents

- `1241934tables1.csv`  
  - Input dataset from Goodman et al. (2013), containing Prot.FCC, Trans.FCC and Trans expression metrics.

- `Cambray.csv`  
  - Input data with RNA and protein counts for 244,000 transgenes (includes `clean.lin.prot.mean` and `ss.rna.dna.mean` columns)

- `Unpaired_Ttest.py`  
  - Python script that performs the unpaired T-test

---

## Output

TtestResult(statistic=np.float64(-109.69496460711792), pvalue=np.float64(0.0), df=np.float64(14136.000000001017))

This significant result indicates that the Goodman dataset has systematically higher translation efficiency values than Cambray’s. This difference may contribute to observed discrepancies in codon behavior, particularly for rare codons like AGG.

---

## To run the unpaired t-test

Run the python script:

```bash
python Unpaired_Ttest.py
