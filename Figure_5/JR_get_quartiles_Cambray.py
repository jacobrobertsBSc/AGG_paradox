import pandas as pd
import math
import string
from collections import Counter
import os


path= os.getcwd()

#define which columns of data i want from the source csv file (pandas feature)
columns = ["gs.sequence", "clean.lin.prot.mean", "ss.rna.dna.mean"]

#create new dataframe using only these columns using the pandas pd.read_csv function:
df = pd.read_csv("Cambray.csv", usecols = columns)
df["Trans"] = df["clean.lin.prot.mean"]/df["ss.rna.dna.mean"]
#extract top and bottom 25% of data points based on Prot.FCC
#first find the prot fcc value that defines the top 25% - this value will be q75:
q75 = df["Trans"].quantile(q = 0.75)

high = df[df["Trans"].ge(q75)]

#repeat for the lower quantile, now asking for less than or equal to (le):
q25 = df["Trans"].quantile(q = 0.25)

low = df[df["Trans"].le(q25)]

#At this point you have two “data frames”, called low and high, with the name, cds and prot.fcc value for the most expressed and least expressed
#Now extract the codons in both lists:
#declare empty lists for high and low expressed codons

codons_low_list = []

codons_high_list = []

#extract sequences for bottom 25% of data points, turn into list, convert into codons and add to codons_low_list
#more pandas...

sequences_low = low["gs.sequence"].to_list()

#extract sequences for top 25% of data points, turn into list, convert into codons and add to codons_high_list 
for seq in sequences_low:
	seq=seq.upper()
	n = 3
	codons_low = [seq[i:i+n] for i in range(0, 30, n)]
	codons_low_list = codons_low_list + codons_low

sequences_high = high["gs.sequence"].to_list()

for seq in sequences_high:
	seq=seq.upper()
	n = 3
	codons_high = [seq[i:i+n] for i in range(0, 30, n)]
	codons_high_list = codons_high_list + codons_high

#This used pandas to make two lists of codons.  Now you can return to good old fashion python to process those lists to get count of each codon for each amino acid.
# Count occurrences of each codon in the high and low expression groups
high_codon_counts = Counter(codons_high_list)
low_codon_counts = Counter(codons_low_list)

amino_acids = ["A", "C", "D", "E", "F", "G", "H", "I", "K", "L", "N", "P", "Q", "R", "S", "T", "V", "Y"]

codons_dict = {
"A": ["GCT", "GCC", "GCA", "GCG"],
"C": ["TGT", "TGC"],
"D": ["GAT", "GAC"],
"E": ["GAA", "GAG"],
"F": ["TTT", "TTC"],
"G": ["GGT", "GGC", "GGA", "GGG"],
"H": ["CAT", "CAC"],
"I": ["ATA", "ATT", "ATC"],
"K": ["AAA", "AAG"],
"L": ["TTA", "TTG", "CTT", "CTC", "CTA", "CTG"],
"N": ["AAT", "AAC"],
"P": ["CCT", "CCC", "CCA", "CCG"],
"Q": ["CAA", "CAG"],
"R": ["CGT", "CGC", "CGA", "CGG", "AGA", "AGG"],
"S": ["TCT", "TCC", "TCA", "TCG", "AGT", "AGC"],
"T": ["ACT", "ACC", "ACA", "ACG"],
"V": ["GTT", "GTC", "GTA", "GTG"],
"Y": ["TAT", "TAC"]
}



#You will need the math function to get the log odds.  If the count of the focal codon is c_high in the high set, is c_low in the low set and not_c_high is the count of the synonymous codons in the high set and not_c_low is the count in the low set. Then 

log_odds_results = []

for aa, codons in codons_dict.items():
    for codon in codons:
        c_high = high_codon_counts.get(codon, 1)
        c_low = low_codon_counts.get(codon, 1)
        not_c_high = sum(high_codon_counts.get(c, 1) for c in codons if c != codon)
        not_c_low = sum(low_codon_counts.get(c, 1) for c in codons if c != codon)

        # Compute odds ratio
        odds_ratio = (c_high / max(c_low, 1)) / (not_c_high / max(not_c_low, 1))
        log_odds = round(math.log(odds_ratio), 3) if odds_ratio > 0 else None

        # Compute standard error
        standard_error = math.sqrt(
        	(1/max(c_high, 1)) + (1/max(c_low, 1)) + (1/max(not_c_high, 1)) + (1/max(not_c_low, 1))
        )
        codon_lastb = codon[2]
        log_odds_results.append((aa, codon, log_odds, standard_error, codon_lastb))

# 9️⃣ Save results
log_odds_df = pd.DataFrame(log_odds_results, columns=["Amino_acid", "Codon", "Log_Odds", "Std_Error", "Last_base"])
log_odds_df.to_csv("log_odds_results_Cambray.csv", index=False)
