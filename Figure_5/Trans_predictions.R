library(ggplot2)
library(ggrepel)
library(gridExtra)
library(tidyverse)
library(dplyr)

Cambray <- read.csv("Cambray_trans+properties.csv")

#Extracting the relevant variables from the CSV
trans <- Cambray %>% pull(trans)
fivep <- Cambray %>% pull(gs.utrCdsStructureMFE)
threep <- Cambray %>% pull(gs.threepCdsStructureMFE)
CAI <- Cambray %>% pull(gs.cdsCAI)

#Ranking the trans values based on the X variable, 
Ranked_trans1 <- trans[order(fivep)]
#Rank ordering the X values 
Ranked_x1 <- fivep[order(fivep)]
#Combining these into a data frame
Ranked_df1 <- data.frame(x= Ranked_x1, y= Ranked_trans1)
#Binning the 244,000 constructs into groups based on the X variable
Ranked_df1$bin <- cut_number(Ranked_df1$x, n=10)
#Getting the mean and standard error for each bin
Binned_data1 <- Ranked_df1 %>%
	group_by(bin) %>%
	summarise(
    x_mean = mean(x),
    y_mean = mean(y)
  )
#Repeated for the 3' stability measure and CAI of each construct
Ranked_trans2 <- trans[order(threep)]
Ranked_x2 <- threep[order(threep)]
Ranked_df2 <- data.frame(x= Ranked_x2, y= Ranked_trans2)
Ranked_df2$bin <- cut_number(Ranked_df2$x, n=10)
Binned_data2 <- Ranked_df2 %>%
	group_by(bin) %>%
	summarise(
    x_mean = mean(x),
    y_mean = mean(y)
  )
  
Ranked_trans3 <- trans[order(CAI)]
Ranked_x3 <- CAI[order(CAI)]
Ranked_df3 <- data.frame(x= Ranked_x3, y= Ranked_trans3)
Ranked_df3$bin <- cut_number(Ranked_df3$x, n=10)
Binned_data3 <- Ranked_df3 %>%
	group_by(bin) %>%
	summarise(
    x_mean = mean(x),
    y_mean = mean(y)
  )
#Performing a pearson correlation test between the three metrics
cor_test1 <- cor.test(trans, fivep, method = "pearson")
cor_test2 <- cor.test(trans, threep, method = "pearson")
cor_test3 <- cor.test(trans, CAI, method = "pearson")

#Pulling out the R-values and P-values to a variable
r1_value <- round(cor_test1$estimate, digits = 3)
p1_value <- signif(cor_test1$p.value, digits = 4)
r2_value <- round(cor_test2$estimate, digits = 3)
p2_value <- signif(cor_test2$p.value, digits = 4)
r3_value <- round(cor_test3$estimate, digits = 3)
p3_value <- signif(cor_test3$p.value, digits = 4)

#Box plot for each prediction
 p1 <- ggplot(Ranked_df1, aes(x = bin, y = y)) +
  geom_boxplot(color="red", fill="red", alpha=0.2,outlier.shape = NA)+ #Using outlier.shape = NA to hide outliers 
  labs(x = "5 prime stability", y = "Translation efficiency", title = "Boxplot: 5′ MFE Bins") +
  annotate("text", x = 1, y = 0.085,
             label = paste0("R = ", r1_value, "\np = ", p1_value),
             hjust = 0, size = 4) +
  scale_x_discrete(guide = guide_axis(angle = -90)) + #Rotating x-axis labels 
  coord_cartesian(ylim = c(0, 0.10))+ #Using cartesian coordinates to zoom the plot on the Y axis rather than removing outliers to zoom 
  theme(
  	aspect.ratio=1,
  	axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1)
  ) +
  theme_bw()
  
 p2 <- ggplot(Ranked_df2, aes(x = bin, y = y)) +
  geom_boxplot(color="orange", fill="orange", alpha=0.2,outlier.shape = NA)+
  labs(x = "3 prime stability", y = "Translation efficiency", title = "Boxplot: 3′ MFE Bins") +
  annotate("text", x = 1, y = 0.085,
             label = paste0("R = ", r2_value, "\np = ", p2_value),
             hjust = 0, size = 4) +
  scale_x_discrete(guide = guide_axis(angle = -90)) +  
  coord_cartesian(ylim = c(0, 0.10))+
  theme(
  	aspect.ratio=1,
  	axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1)
  ) +
  theme_bw()
  
  p3 <- ggplot(Ranked_df3, aes(x = bin, y = y)) +
  geom_boxplot(color="blue", fill="blue", alpha=0.2,outlier.shape = NA)+
  labs(x = "CAI index", y = "Translation efficiency", title = "Boxplot: CAI bins") +
  annotate("text", x = 1, y = 0.085,
             label = paste0("R = ", r3_value, "\np = ", p3_value),
             hjust = 0, size = 4) +
  scale_x_discrete(guide = guide_axis(angle = -90)) + 
  coord_cartesian(ylim = c(0, 0.10))+
 theme(
  	aspect.ratio=1,
  	axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1)
  ) +
  theme_bw() 

pdf("Figure_5.pdf", height=5, width=15)
grid.arrange(p1, p2, p3, nrow = 1)

dev.off()
 






























