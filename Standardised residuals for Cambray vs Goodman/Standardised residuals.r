library(ggplot2)
library(ggrepel)
library(gridExtra)

#Reading in the Cambray and Goodman data sets
Cambray <- read.csv("Cambray_Subsampled_logodds.csv")
Goodman <- read.csv("log_odds_results_Transs.csv")

#Renaming the columns of the log_odds in each
names(Cambray)[names(Cambray) == "Mean_Log_Odds"] <- "Subsampled_Cambray.logodds"
names(Goodman)[names(Goodman) == "Log_Odds"] <- "Goodman.logodds"

#Renaming the columns of the std errors in each 
names(Cambray)[names(Cambray) == "SEM_Log_Odds"] <- "Subsampled_Cambray.Std"
names(Goodman)[names(Goodman) == "Std_Error"] <- "Goodman.Std"

#Merging the data frames within merged_list using the base reduce function --> this is not the most efficient for large data sets
#Consider using the reduce() function from tidyverse as it can be more efficient
merged_list <- list(Cambray, Goodman)

merged_df <- Reduce(function(x,y) merge(x,y, by = c("Amino_acid","Codon"), all=TRUE), merged_list)

#Removing doublet columns, for example, Amino acid and codon columns not removed in the merge
merged_df <- merged_df[, c("Amino_acid", "Codon",  
                           "Subsampled_Cambray.logodds", "Subsampled_Cambray.Std", 
                           "Goodman.logodds", "Goodman.Std",  
                           "Last_base.x")]

#Extracting the log odds columns from each df
Sampled_Cambray_logodds <- unlist(merged_df$Subsampled_Cambray.logodds)
Goodman_logodds <- unlist(merged_df$Goodman.logodds)
#Performing a pearson correlation test between the three metrics
cor_test1 <- cor.test(Sampled_Cambray_logodds, Goodman_logodds, method = "pearson")

#Pulling out the R-values and P-values to a variable
r1_value <- round(cor_test1$estimate, digits = 4)
p1_value <- signif(cor_test1$p.value, digits = 4)

#Performing linear regression where x (predictor) is the Cambray log odds whilst y (the response) is the log odds of the Goodman trans metric.
standardised_residual <- lm(Goodman.logodds ~ Subsampled_Cambray.logodds, data = merged_df)

#Using the rstandard() function to calculate the standardized residuals 
std_resid <- rstandard(standardised_residual)

#Adding the standardized residual values to merged_df to assign them to their codons
merged_df$std_resid <- std_resid

#Extracting codon rows from merged_df  that have a standard residual value over 1.96
high_outliers <- subset(merged_df, std_resid > 1.96)

#Leaving out any codons that aren’t of need in the data frame 
high_outliers <- high_outliers[, c("Codon", "Goodman.logodds", "Subsampled_Cambray.logodds", "std_resid")]


