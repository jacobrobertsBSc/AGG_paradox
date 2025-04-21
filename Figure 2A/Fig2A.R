library(ggplot2)

#Reading in the Trans log odds
data = read.csv("log_odds_results_transs.csv", h = TRUE)

pdf("figure_2B.pdf", width = 10, height = 5) #Creating a blank PDF file
fig3 = ggplot(data, aes(x = Codon, y = Log_Odds)) + #Creating a ggplot with the log odds assigned to the Y axis and the codons on the X 
	geom_col(aes(fill = Last_base)) + #Adding bars that are coloured by the third base of the codon
	scale_fill_manual(values = c("#EFE350FF", "#593D9CFF", "#B8627DFF", "#F68F46FF")) + #assigning the bar colours to the 4 nucleotide
	geom_errorbar(aes(ymin = Log_Odds - Std_Error, ymax = Log_Odds + Std_Error, width = 0.4), colour = "black") + #Adding error bars
	facet_grid(~Amino_acid, scales = "free_x", space = "free_x") + #Separating the codons by their respective amino acids
	scale_x_discrete(guide = guide_axis(angle = -90)) + #Rotating x-axis labels 
	labs(x = "Codon", y = "log odds ratio", fill = "3rd Position \nNucleotide") + #Labelling axis
	theme(strip.text.x = element_text(face = "bold"), strip.background = element_rect(color = "black")) #Making the amino acid labels bold and the outline of the box label black
print(fig3)
dev.off()
