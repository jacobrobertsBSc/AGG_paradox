import pandas as pd
import math
import string
from collections import Counter
import os
import scipy.stats as stats

path= os.getcwd()

#Declaring which columns to take from the two CSV files (Goodman and Cambray)
G_columns = ["Trans"]
C_columns = ["clean.lin.prot.mean", "ss.rna.dna.mean"]

#Creating new dataframes with these columns using the pandas function
Goodman_df = pd.read_csv("1241934tables1.csv", usecols = G_columns)

df = pd.read_csv("Cambray.csv", usecols = C_columns)
df["C_Trans"] = df["clean.lin.prot.mean"]/df["ss.rna.dna.mean"]

# Dropping missing values from the data sets before the welch's ttest
Cambray_clean = df["C_Trans"].dropna()
Goodman_clean = Goodman_df["Trans"].dropna()

#Performing an unpaired welch's t-test without assuming equal variance in each data set
Unpaired_welch = stats.ttest_ind(Cambray_clean, Goodman_clean, equal_var=False, alternative="two-sided")

print(Unpaired_welch)






























