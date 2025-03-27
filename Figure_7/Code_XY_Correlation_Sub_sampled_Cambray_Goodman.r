library(ggplot2)
library(ggrepel)
library(gridExtra)

Cambray <- read.csv("Cambray_Subsampled_logodds.csv")
Goodman <- read.csv("log_odds_results_Transs.csv")

#Rename columns of the log_odds in each 
names(Cambray)[names(Cambray) == "Mean_Log_Odds"] <- "Subsampled_Cambray.logodds"
names(Goodman)[names(Goodman) == "Log_Odds"] <- "Goodman.logodds"

#Renaming the columns of the std errors in each 
names(Cambray)[names(Cambray) == "SEM_Log_Odds"] <- "Subsampled_Cambray.Std"
names(Goodman)[names(Goodman) == "Std_Error"] <- "Goodman.Std"

merged_list <- list(Cambray, Goodman)
#Merging the data frames within merged_list using the base reduce function -- this is not the most efficient for large data sets -
#I will consider using the reduce() function from tidyverse as it is more fast/efficient
merged_df <- Reduce(function(x,y) merge(x,y, by = c("Amino_acid","Codon"), all=TRUE), merged_list)

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

#Creating a list of unique information regarding each XY plot - this will be iterated through when creating each ggplot - this is a list of lists
#plot_pairs <- list(
 # list(x = "Prot.FCC.odds", y = "Trans.FCC.odds", title = "Prot FCC vs Trans FCC", filename = "ProtFCC_vs_TransFCC_Refined.pdf", r = r1_value, p = p1_value),
#  list(x = "Prot.FCC.odds", y = "Trans.odds", title = "Prot FCC vs Trans", filename = "ProtFCC_vs_Trans_Refined.pdf", r = r2_value, p = p2_value),
 # list(x = "Trans.odds", y = "Trans.FCC.odds", title = "Trans vs Trans FCC", filename = "Trans_vs_TransFCC_Refined.pdf", r = r3_value, p = p3_value)
#)

#For loop for ggplots of XY plots -- this plot produces 3 plots by taking the information that is unique to each from each index(list) in plot_pairs list 
#.data[[plot$x]] makes sure it reads from the merged_df and takes the data that matches the character string. E.g. "Prot.FCC.odds"


pdf("Fig7_Goodman_vs_Sub_sampled_Cambray.pdf", width = 10, height = 5)

GGplot1 = ggplot(merged_df, aes(x = Subsampled_Cambray.logodds, y = Goodman.logodds)) +
  geom_point(color = "red") +  # Scatter points
  geom_smooth(method = "lm", color = "blue", se = FALSE) +  # Regression line
  geom_text_repel(aes(label = Codon), size = 2, max.overlaps = Inf) +  # Codon labels, avoiding overlap
  labs(x = "Sample Cambray log odds", y = "Goodman log odds", title = "Cambray vs Goodman") +
  annotate("text", x = min(merged_df$Subsampled_Cambray.logodds), y = 0.60,
           label = paste0("R = ", r1_value, "\np = ", p1_value),
           hjust = 0, size = 4) +
	theme(aspect.ratio=1) +
    theme_bw()
  
print(GGplot1)

dev.off()

t_test = t.test(Sampled_Cambray_logodds, Goodman_logodds, paired = TRUE)

print (t_test)



  # Generate scatter plot
    # Open PDF
    # Loop through each plot pair and generate the scatter plots
      # Print plot to PDF