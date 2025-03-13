#Change directory to fig_4 
#read in each file to a vector for each file - can run the function for each file in the directory
#or you could merge the three files... so then you dont have to do the for loop
library(ggplot2)
library(ggrepel)

prot_FCC <- read.csv("Prot_FCC_log_odds.csv")
trans_FCC <- read.csv("Trans_FCC_log_odds.csv")
trans <- read.csv("Trans_log_odds.csv")

#Rename columns of the log_odds in each 
names(prot_FCC)[names(prot_FCC) == "Log_Odds"] <- "Prot.FCC.odds"
names(trans_FCC)[names(trans_FCC) == "Log_Odds"] <- "Trans.FCC.odds"
names(trans)[names(trans) == "Log_Odds"] <- "Trans.odds"

names(prot_FCC)[names(prot_FCC) == "Std_Error"] <- "Prot.FCC.Std"
names(trans_FCC)[names(trans_FCC) == "Std_Error"] <- "Trans.FCC.Std"
names(trans)[names(trans) == "Std_Error"] <- "Trans.Std"

merged_list <- list(prot_FCC, trans_FCC, trans)

merged_df <- Reduce(function(x,y) merge(x,y, by = c("Amino_acid","Codon"), all=TRUE), merged_list)

merged_df <- merged_df[, c("Amino_acid", "Codon",  
                           "Prot.FCC.odds", "Prot.FCC.Std", 
                           "Trans.FCC.odds", "Trans.FCC.Std",  
                           "Trans.odds", "Trans.Std", 
                           "Last_base")]

Prot_FCC <- unlist(merged_df$Prot.FCC.odds)
Trans_FCC <- unlist(merged_df$Trans.FCC.odds)
Trans <- unlist(merged_df$Trans.odds)

cor_test1 <- cor.test(Prot_FCC, Trans_FCC, method = "spearman")
cor_test2 <- cor.test(Prot_FCC, Trans, method = "spearman")
cor_test3 <- cor.test(Trans, Trans_FCC, method = "spearman")

r1_value <- round(cor_test1$estimate, digits = 4)
p1_value <- signif(cor_test1$p.value, digits = 4)
r2_value <- round(cor_test2$estimate, digits = 4)
p2_value <- signif(cor_test2$p.value, digits = 4)
r3_value <- round(cor_test3$estimate, digits = 4)
p3_value <- signif(cor_test3$p.value, digits = 4)


pdf("ProtFCC vs TransFCC (spearman).pdf", width = 10, height = 5)

GGplot1 = ggplot(merged_df, aes(x = Prot.FCC.odds, y = Trans.FCC.odds)) +
  geom_point(color = "red") +  # Scatter points
  geom_smooth(method = "lm", color = "blue", se = FALSE) +  # Regression line
  geom_text_repel(aes(label = Codon), size = 2, max.overlaps = Inf) +  # Codon labels, avoiding overlap
  labs(x = "Prot FCC", y = "Trans FCC", title = "Prot FCC vs Trans FCC") +
  annotate("text", x = min(merged_df$Prot.FCC.odds), y = max(merged_df$Trans.FCC.odds),
           label = paste0("R = ", r1_value, "\n p = ", p1_value),
           hjust = 0, size = 5) + 
  theme_minimal()  # Clean theme
  
print(GGplot1)

dev.off()

pdf("ProtFCC vs Trans (spearman).pdf", width = 10, height = 5)

GGplot2 = ggplot(merged_df, aes(x = Prot.FCC.odds, y = Trans.odds)) +
  geom_point(color = "red") +  # Scatter points
  geom_smooth(method = "lm", color = "blue", se = FALSE) +  # Regression line
  geom_text_repel(aes(label = Codon), size = 2, max.overlaps = Inf) +  # Codon labels, avoiding overlap
  labs(x = "Prot FCC", y = "Trans", title = "Prot FCC vs Trans") +
  annotate("text", x = min(merged_df$Prot.FCC.odds), y = max(merged_df$Trans.odds),
           label = paste0("R = ", r2_value, "\n p = ", p2_value),
           hjust = 0, size = 5) + 
  theme_minimal()  # Clean theme
  
print(GGplot2)

dev.off()

pdf("Trans vs TransFCC (spearman).pdf", width = 10, height = 5)

GGplot3 = ggplot(merged_df, aes(x = Trans.odds, y = Trans.FCC.odds)) +
  geom_point(color = "red") +  # Scatter points
  geom_smooth(method = "lm", color = "blue", se = FALSE) +  # Regression line
  geom_text_repel(aes(label = Codon), size = 2, max.overlaps = Inf) +  # Codon labels, avoiding overlap
  labs(x = "Trans", y = "Trans FCC", title = "Trans vs Trans FCC") +
  annotate("text", x = min(merged_df$Trans.odds), y = max(merged_df$Trans.FCC.odds),
           label = paste0("R = ", r3_value, "\n p = ", p3_value),
           hjust = 0, size = 5) + 
  theme_minimal()  # Clean theme
  
print(GGplot3)

dev.off()