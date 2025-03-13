#Change directory to fig_4 
#read in each file to a vector for each file - can run the function for each file in the directory
#or you could merge the three files... so then you dont have to do the for loop

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

pdf("BaselineR_attempt_Prot_TransFCC.pdf")

plot(Prot_FCC, Trans_FCC, xlab="Prot FCC", ylab = "Trans FCC", col = "blue", cex=0.5, pch=18, main = "Prot FCC vs Trans FCC")

abline(lm(Prot_FCC~Trans_FCC), col = "black")

text(Prot_FCC, Trans_FCC, labels = merged_df$Codon, cex = 0.6, pos = 2)

cor_test1 <- cor.test(Prot_FCC, Trans_FCC, method = "pearson")

mtext(paste0("R = ", round(cor_test1$estimate, digits = 4), "; p-value = ", signif(cor_test1$p.value, digits = 4)), side = 3, adj = 0.05, line = -1.3, cex = 0.8)


dev.off()

#cex gives the size of the points, pch is an option to decide the shape of the points
#this plots a black regression line

#and this adds text saying what the slope of the line is (you could add the correlation and P value if you prefer)