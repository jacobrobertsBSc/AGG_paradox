library(ggplot2)
library(ggrepel)
library(gridExtra)

#Reading in the LB and M9 treatment data sets
LB <- read.csv("Osterman_log_odds.csv")
M9 <- read.csv("Osterman_log_odds_M9.csv")

#Renaming the columns of the log_odds in each
names(LB)[names(LB) == "Log_Odds"] <- "LB_logodds"
names(M9)[names(M9) == "Log_Odds"] <- "M9_logodds"

#Renaming the columns of the std errors in each
names(LB)[names(LB) == "Std_Error"] <- "LB_Std"
names(M9)[names(M9) == "Std_Error"] <- "M9_Std"

#Merging the data frames within merged_list using the base reduce function --> this is not the most efficient for large data sets
#Consider using the reduce() function from tidyverse as it can be more efficient
merged_list <- list(LB, M9)

merged_df <- Reduce(function(x,y) merge(x,y, by = c("Amino_acid","Codon"), all=TRUE), merged_list)

#Removing doublet columns, for example, Amino acid and codon columns not removed in the merge
merged_df <- merged_df[, c("Amino_acid", "Codon",  
                           "LB_logodds", "LB_Std", 
                           "M9_logodds", "M9_Std",  
                           "Last_base.x")]

#Extracting the log odds columns from each df
LB_logodds <- unlist(merged_df$LB_logodds)
M9_logodds <- unlist(merged_df$M9_logodds)
#Performing a pearson correlation test between the three metrics
cor_test1 <- cor.test(LB_logodds, M9_logodds, method = "pearson")

#Pulling out the R-values and P-values to a variable
r1_value <- round(cor_test1$estimate, digits = 4)
p1_value <- signif(cor_test1$p.value, digits = 4)

pdf("Figure_4B_LB_vs_M9_Osterman.pdf", width = 10, height = 5) #Creating a blank PDF file

#Creating a scatter plot for the log odds from LB and M9 treatment groups
GGplot1 = ggplot(merged_df, aes(x = LB_logodds, y = M9_logodds)) +
  geom_point(color = "red") +  # Scatter points to represent each codon
  geom_smooth(method = "lm", color = "blue", se = FALSE) +  # Regression line without 95% confidence intervals --> se = FALSE
  geom_text_repel(aes(label = Codon), size = 2, max.overlaps = Inf) +  # Adding Codon labels and using ggrepel to avoid overlaps of labels
  labs(x = "LB log odds", y = "M9 log odds", title = "High (LB) vs low (M9) nutrients") + #Labelling axis and adding plot title
  annotate("text", x = min(merged_df$LB_logodds), y = 0.60, #Adding the results of the pearson's correlation to the figure
           label = paste0("R = ", r1_value, "\np = ", p1_value),
           hjust = 0, size = 4) +
	theme(aspect.ratio=1) + #Making the graph square
    theme_bw()
  
print(GGplot1)

dev.off()