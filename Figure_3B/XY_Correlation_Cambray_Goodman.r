library(ggplot2)
library(ggrepel)
library(gridExtra)

#Reading in the Goodman and Cambray data sets
Cambray <- read.csv("log_odds_results_Cambray.csv")
Goodman <- read.csv("log_odds_results_Transs.csv")

#Renaming the columns of the log_odds in each  
names(Cambray)[names(Cambray) == "Log_Odds"] <- "Cambray.logodds"
names(Goodman)[names(Goodman) == "Log_Odds"] <- "Goodman.logodds"

#Renaming the columns of the std errors in each 
names(Cambray)[names(Cambray) == "Std_Error"] <- "Cambray.Std"
names(Goodman)[names(Goodman) == "Std_Error"] <- "Goodman.Std"

#Merging the data frames within merged_list using the base reduce function --> this is not the most efficient for large data sets
#Consider using the reduce() function from tidyverse as it can be more efficient
merged_list <- list(Cambray, Goodman)

merged_df <- Reduce(function(x,y) merge(x,y, by = c("Amino_acid","Codon"), all=TRUE), merged_list)

#Removing doublet columns, for example, Amino acid and codon columns not removed in the merge
merged_df <- merged_df[, c("Amino_acid", "Codon",  
                           "Cambray.logodds", "Cambray.Std", 
                           "Goodman.logodds", "Goodman.Std",  
                           "Last_base.x")]
                           
#Extracting the log odds columns from each df
Cambray_logodds <- unlist(merged_df$Cambray.logodds)
Goodman_logodds <- unlist(merged_df$Goodman.logodds)
#Performing a pearson correlation test between the three metrics
cor_test1 <- cor.test(Cambray_logodds, Goodman_logodds, method = "pearson")

#Pulling out the R-values and P-values to a variable
r1_value <- round(cor_test1$estimate, digits = 3)
p1_value <- signif(cor_test1$p.value, digits = 4)

pdf("Figure_3B.pdf", width = 8, height = 8)#Creating a blank PDF file

#Creating a scatter plot for the log odds from Cambray and Goodman
GGplot1 = ggplot(merged_df, aes(x = Cambray.logodds, y = Goodman.logodds)) + 
  geom_point(color = "red") +  # Scatter points to represent each codon
  geom_smooth(method = "lm", color = "blue", se = FALSE) +  # Regression line without 95% confidence intervals --> se = FALSE
  geom_text_repel(aes(label = Codon), size = 2, max.overlaps = Inf) +  # Adding Codon labels and using ggrepel to avoid overlaps of labels
  labs(x = "Cambray log odds", y = "Goodman log odds", title = "Cambray vs Goodman") + #Labelling axis and adding plot title
  annotate("text", x = min(merged_df$Cambray.logodds), y = 0.6, #Adding the results of the pearson's correlation to the figure
           label = paste0("R = ", r1_value, "\np = ", p1_value),
           hjust = 0, size = 6) +
	theme(aspect.ratio=1) + #Making the graph square 
    theme_bw()
  
print(GGplot1)

dev.off()
