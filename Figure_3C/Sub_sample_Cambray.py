import pandas as pd
import math
import string
from collections import Counter
import os


path= os.getcwd()

#Declaring which columns to take from Goodman's CSV file
columns = ["gs.sequence", "clean.lin.prot.mean", "ss.rna.dna.mean"]
#Creating a dataframe with these columns using the pandas function and then creating the translation efficiency values with protein/RNA
df = pd.read_csv("Cambray.csv", usecols = columns)
df["Trans"] = df["clean.lin.prot.mean"]/df["ss.rna.dna.mean"]

#Creating an empty list for the log odds of all subsamples
Subsample_logodds = []

#Repeating the log odds calculations 1000 times from subsamples containing 14,000 random subsamples
for i in range(0,1000):
    df_sub = df.sample(n=14000)
    
#Extracting the top and bottom 25% of data points based by Trans
#Finding the Trans value that defines the top 25% - this is q75:
    q75 = df_sub["Trans"].quantile(q = 0.75)

    high = df_sub[df_sub["Trans"].ge(q75)]

#Repeating for the lower quantile, now asking for less than or equal to (le):
    q25 = df_sub["Trans"].quantile(q = 0.25)

    low = df_sub[df_sub["Trans"].le(q25)]

#Creating empty lists for high and low expressed codons
    codons_low_list = []

    codons_high_list = []

#Extracting sequences for the bottom 25% of data points, turning them into a list, converting into codons and adding to codons_low_list. Repeated for the bottom 25%
    sequences_low = low["gs.sequence"].to_list()
 
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

#Counting occurrences of each codon in the high and low expression groups
    high_codon_counts = Counter(codons_high_list)
    low_codon_counts = Counter(codons_low_list)

#Creating a dictionary of amino acids and their synonymous codons
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

#For loop to run through each codon in the codon dictionary and calculate the log odds of it appearing in the high expression group vs the low group relative to the 
#frequency of its synonymous codons in the high and low groups.Divisions by zero are avoided by substituting values below 1 for 1.
    log_odds_results = []

    for aa, codons in codons_dict.items():
        for codon in codons:
            c_high = high_codon_counts.get(codon, 1)
            c_low = low_codon_counts.get(codon, 1)
            not_c_high = sum(high_codon_counts.get(c, 1) for c in codons if c != codon)
            not_c_low = sum(low_codon_counts.get(c, 1) for c in codons if c != codon)

        # Computing odds ratio
            odds_ratio = (c_high / max(c_low, 1)) / (not_c_high / max(not_c_low, 1))
            log_odds = round(math.log(odds_ratio), 3) if odds_ratio > 0 else None

        # Computing standard error
            standard_error = math.sqrt(
                (1/max(c_high, 1)) + (1/max(c_low, 1)) + (1/max(not_c_high, 1)) + (1/max(not_c_low, 1))
            )
        
            codon_lastb = codon[2] # Getting the third base of the codon
            log_odds_results.append((aa, codon, log_odds, standard_error, codon_lastb)) 
            
#Creating a data frame where each subsample log odds list is converted into a column with a unique header name
    df_logodds= pd.DataFrame(log_odds_results, columns=["Amino_acid", "Codon", f"Log_Odds_{i}", f"Std_Error_{i}", "Last_base"])
#Merging the data frame to Subsample_logodds = [] but if Subsample_logodds it uses df_logodds to create the contents of Subsample_logodds
    if len(Subsample_logodds) == 0:
        Subsample_logodds = df_logodds
    else:
        Subsample_logodds = Subsample_logodds.merge(df_logodds, on=["Amino_acid", "Codon", "Last_base"], how="outer")
    
    print(f"Subsample {i} done.")

#Creating a list of the column names containing each of the 1000 subsample log odds
log_cols = [col for col in Subsample_logodds if col.startswith("Log_Odds_")]
#Extracting the data from Subsample_logodds (using the log_cols) to then calculate the means and SEM
Subsample_logodds["Mean_Log_Odds"] = Subsample_logodds[log_cols].mean(axis=1)
Subsample_logodds["SEM_Log_Odds"] = Subsample_logodds[log_cols].sem(axis=1)

#Saving the final merged data set with means and standard error means to a CSV
Subsample_logodds.to_csv("Cambray_Subsampled_logodds.csv", index=False)

print("Completed")





