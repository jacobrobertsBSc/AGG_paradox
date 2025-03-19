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

cor_test1 <- cor.test(Prot_FCC, Trans_FCC, method = "pearson")
cor_test2 <- cor.test(Prot_FCC, Trans, method = "pearson")
cor_test3 <- cor.test(Trans, Trans_FCC, method = "pearson")

r1_value <- round(cor_test1$estimate, digits = 4)
p1_value <- signif(cor_test1$p.value, digits = 4)
r2_value <- round(cor_test2$estimate, digits = 4)
p2_value <- signif(cor_test2$p.value, digits = 4)
r3_value <- round(cor_test3$estimate, digits = 4)
p3_value <- signif(cor_test3$p.value, digits = 4)

plot_pairs <- list(
  list(x = "Prot.FCC.odds", y = "Trans.FCC.odds", title = "Prot FCC vs Trans FCC", filename = "ProtFCC_vs_TransFCC_Refined.pdf", r = r1_value, p = p1_value),
  list(x = "Prot.FCC.odds", y = "Trans.odds", title = "Prot FCC vs Trans", filename = "ProtFCC_vs_Trans_Refined.pdf", r = r2_value, p = p2_value),
  list(x = "Trans.odds", y = "Trans.FCC.odds", title = "Trans vs Trans FCC", filename = "Trans_vs_TransFCC_Refined.pdf", r = r3_value, p = p3_value)
)

for (plot in plot_pairs) {
  
  pdf(plot$filename, width = 10, height = 5)
  
  ggplot_obj <- ggplot(merged_df, aes(x = .data[[plot$x]], y = .data[[plot$y]])) +
    geom_point(color = "red") +  
    geom_smooth(method = "lm", color = "blue", se = FALSE) +  
    geom_text_repel(aes(label = Codon), size = 2, max.overlaps = Inf) +  
    labs(x = plot$x, y = plot$y, title = plot$title) +
    annotate("text", x = min(merged_df[[plot$x]]), y = max(merged_df[[plot$y]]),
             label = paste0("R = ", plot$r, "\n p = ", plot$p),
             hjust = 0, size = 5) +
    theme_minimal()
  
  
  print(ggplot_obj)
  
 
  dev.off()
}


  # Generate scatter plot
    # Open PDF
    # Loop through each plot pair and generate the scatter plots
      # Print plot to PDF