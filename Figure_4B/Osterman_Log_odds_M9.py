import pandas as pd
import math
import string
from collections import Counter
import os


path= os.getcwd()

#Declaring which columns to take from Goodman's CSV file
columns = ["sequence", "TEF"]

#Creating a dataframe with these columns using the pandas function
df = pd.read_csv("Supplementary table 4.csv", usecols = columns)

#Assigning the data to 5 bins based on the TEF annotation in the CSV. This uses df.loc from pandas
bin_1=df.loc[df["TEF"]==1]
bin_2=df.loc[df["TEF"]==2]
bin_3=df.loc[df["TEF"]==3]
bin_4=df.loc[df["TEF"]==4]
bin_5=df.loc[df["TEF"]==5]

#Taking the number of sequences in the data and assigning the number of sequences to have in each quartile --> length of dataframe/4
num_seq=len(df["sequence"])
quart=num_seq//4

#If TEF 1 and TEF2 have more than 8094 sequences, randomly pick enough sequences from TEF2 to reach 8094 sequences. If there is not enough sequences in TEF2 to get 8094, then randomlu pick from TEF3 
#The product of this uses pd.concat() to combine the subsets from the sampling
if len(bin_1) + len(bin_2)>quart: 
	low_2=bin_2.sample(n=quart-len(bin_1))
	low=pd.concat([bin_1 , low_2])
else: 
	low_3= bin_3.sample(n=quart-(len(bin_1)+len(bin_2))) 
	low= pd.concat([bin_1, bin_2, low_3])
#This is repeated for the higher quartile using TEF 5-3
if len(bin_5) + len(bin_4) >quart:
	high_4=bin_4.sample(n=quart-len(bin_5))
	high=pd.concat([bin_5, high_4])
	
else:
	high_3=bin_3.sample(n=quart-(len(bin_4)+len(bin_5)))
	high=pd.concat([bin_5, bin_4,high_3])
	
#Original attempt below, this allowed bias due to alphabetical arrangement of the transgene sequences in the Osterman data set

#Quartiles = pd.qcut(df["TEF"].rank(method="first"), q=4, labels=["Q1", "Q2", "Q3", "Q4"])

#q4 = (Quartiles == "Q4") 
#high = df[q4]  

#q1 = (Quartiles == "Q1")
#low = df[q1]

#Creating empty lists for high and low expressed codons
codons_low_list = []

codons_high_list = []

#Extracting sequences for the bottom 25% of data points, turning them into a list, converting into codons and adding to codons_low_list. Repeated for the bottom 25%
sequences_low = low["sequence"].to_list()

for seq in sequences_low:
	n = 3
	codons_low = [seq[i:i+n] for i in range(0, len(seq), n)]
	codons_low_list = codons_low_list + codons_low

sequences_high = high["sequence"].to_list()

for seq in sequences_high:
	n = 3
	codons_high = [seq[i:i+n] for i in range(0, len(seq), n)]
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
        codon_lastb = codon[2]
        log_odds_results.append((aa, codon, log_odds, standard_error, codon_lastb))

# Saving log odds results to pandas data frame and writing out to a csv file.
log_odds_df = pd.DataFrame(log_odds_results, columns=["Amino_acid", "Codon", "Log_Odds", "Std_Error", "Last_base"])
log_odds_df.to_csv("Osterman_log_odds_M9.csv", index=False)
