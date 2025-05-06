import pandas as pd
import math
import string
from collections import Counter
import os
import scipy.stats as stats

path= os.getcwd()

df = pd.read_csv("Cambray.csv")

df["trans"] = df["clean.lin.prot.mean"] / df["ss.rna.dna.mean"]

df = df[["gs.cdsCAI", "gs.utrCdsStructureMFE", "gs.threepCdsStructureMFE", "trans","gs.sequence"]]

df.to_csv("Cambray_trans+properties.csv", index=False)





































