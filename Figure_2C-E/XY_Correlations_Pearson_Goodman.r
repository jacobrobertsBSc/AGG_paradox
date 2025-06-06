library(ggplot2)
library(ggrepel)
library(gridExtra)

prot_FCC <- read.csv("Prot_FCC_log_odds.csv")
trans_FCC <- read.csv("Trans_FCC_log_odds.csv")
trans <- read.csv("Trans_log_odds.csv")

#Rename columns of the log_odds in each 
names(prot_FCC)[names(prot_FCC) == "Log_Odds"] <- "Prot.FCC.odds"
names(trans_FCC)[names(trans_FCC) == "Log_Odds"] <- "Trans.FCC.odds"
names(trans)[names(trans) == "Log_Odds"] <- "Trans.odds"
#Renaming the columns of the std errors in each 
names(prot_FCC)[names(prot_FCC) == "Std_Error"] <- "Prot.FCC.Std"
names(trans_FCC)[names(trans_FCC) == "Std_Error"] <- "Trans.FCC.Std"
names(trans)[names(trans) == "Std_Error"] <- "Trans.Std"

merged_list <- list(prot_FCC, trans_FCC, trans)
#Merging the data frames within merged_list using the base reduce function -- this is not the most efficient for large data sets -
#Consider using the reduce() function from tidyverse as it is more fast/efficient
merged_df <- Reduce(function(x,y) merge(x,y, by = c("Amino_acid","Codon"), all=TRUE), merged_list)

merged_df <- merged_df[, c("Amino_acid", "Codon",  
                           "Prot.FCC.odds", "Prot.FCC.Std", 
                           "Trans.FCC.odds", "Trans.FCC.Std",  
                           "Trans.odds", "Trans.Std", 
                           "Last_base")]
                    
#Extracting the log odds columns from each df
Prot_FCC <- unlist(merged_df$Prot.FCC.odds)
Trans_FCC <- unlist(merged_df$Trans.FCC.odds)
Trans <- unlist(merged_df$Trans.odds)
#Performing a pearson correlation test between the three metrics
cor_test1 <- cor.test(Prot_FCC, Trans_FCC, method = "pearson")
cor_test2 <- cor.test(Prot_FCC, Trans, method = "pearson")
cor_test3 <- cor.test(Trans, Trans_FCC, method = "pearson")
#Pulling out the R-values and P-values to a variable
r1_value <- round(cor_test1$estimate, digits = 4)
p1_value <- signif(cor_test1$p.value, digits = 4)
r2_value <- round(cor_test2$estimate, digits = 4)
p2_value <- signif(cor_test2$p.value, digits = 4)
r3_value <- round(cor_test3$estimate, digits = 4)
p3_value <- signif(cor_test3$p.value, digits = 4)

#Creating a scatter plot for the log odds from prot.FCC and Trans.FCC
                    
  p1 <- ggplot(merged_df, aes(x = merged_df$Prot.FCC.odds, y = merged_df$Trans.FCC.odds)) +
    geom_point(color = "red") +  # Scatter points to represent each codon
    geom_smooth(method = "lm", color = "blue", se = FALSE) +  # Regression line without 95% confidence intervals --> se = FALSE
    geom_text_repel(aes(label = Codon), size = 2, max.overlaps = Inf) +  #Adding codon labels and using ggrepel to avoid overlaps
    labs(x = "Prot.FCC log odds", y = "Trans.FCC log odds", title = "A") + #Labelling axis and adding plot title 
    annotate("text", x = min(merged_df$Prot.FCC.odds), y = 1.05, #adding the results of the pearson's correlation to the figure
             label = paste0("R = ", r1_value, "\np = ", p1_value),
             hjust = 0, size = 4) +
    theme(aspect.ratio=1) + #making the graph square 
    theme_bw()

  #Plots repeated for prot.FCC vs Trans and Trans.FCC vs Trans               
  p2 <- ggplot(merged_df, aes(x = merged_df$Prot.FCC.odds, y = merged_df$Trans.odds)) +
    geom_point(color = "red") +  
    geom_smooth(method = "lm", color = "blue", se = FALSE) +  
    geom_text_repel(aes(label = Codon), size = 2, max.overlaps = Inf) +  
    labs(x = "Prot.FCC log odds", y = "Trans log odds", title = "B") +
    annotate("text", x = min(merged_df$Prot.FCC.odds), y = 0.6,
             label = paste0("R = ", r2_value, "\np = ", p2_value),
             hjust = 0, size = 4) +
    theme(aspect.ratio=1) +
    theme_bw()

p3 <- ggplot(merged_df, aes(x = merged_df$Trans.FCC.odds, y = merged_df$Trans.odds)) +
    geom_point(color = "red") +  
    geom_smooth(method = "lm", color = "blue", se = FALSE) +  
    geom_text_repel(aes(label = Codon), size = 2, max.overlaps = Inf) +  
    labs(x = "Trans.FCC log odds", y = "Trans log odd", title = "C") +
    annotate("text", x = min(merged_df$Trans.FCC.odds), y = 0.57,
             label = paste0("R = ", r3_value, "\np = ", p3_value),
             hjust = 0, size = 4) +
    theme(aspect.ratio=1) +
    theme_bw()
pdf("Figure_2C-E.pdf", height=5, width=15)
grid.arrange(p1, p2, p3, nrow = 1)

dev.off()



 
