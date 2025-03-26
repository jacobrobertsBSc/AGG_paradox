
library(ggplot2)

#read in VedIO

data = read.csv("log_odds_results_Cambray.csv", h = TRUE)

pdf("figure5.pdf", width = 10, height = 5)
fig5 = ggplot(data, aes(x = Codon, y = Log_Odds)) + 
	geom_col(aes(fill = Last_base)) +
	scale_fill_manual(values = c("#EFE350FF", "#593D9CFF", "#B8627DFF", "#F68F46FF")) + 
	geom_errorbar(aes(ymin = Log_Odds - Std_Error, ymax = Log_Odds + Std_Error, width = 0.4), colour = "black") + 
	facet_grid(~Amino_acid, scales = "free_x", space = "free_x") + 
	scale_x_discrete(guide = guide_axis(angle = -90)) + 
	labs(x = "Codon", y = "log odds ratio", fill = "3rd Position \nNucleotide") + 
	theme(strip.text.x = element_text(face = "bold"), strip.background = element_rect(color = "black")) 
print(fig5)
dev.off()


#plot VedIO by codon, coloured based on 3rd position nucleotide