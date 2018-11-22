library("arules", lib.loc="/Library/Frameworks/R.framework/Versions/3.5/Resources/library")
library("arulesViz", lib.loc="/Library/Frameworks/R.framework/Versions/3.5/Resources/library")
library("tidyverse", lib.loc="/Library/Frameworks/R.framework/Versions/3.5/Resources/library")
a <- read.csv("/Users/punchh_shubham/Downloads/processed_receipts_data.csv")
View(a)
a1<-a[,c(1,2,3,7,10)]
library(plyr)
a2 <- a1[a1$price>=1,]
out<-ddply(a2, c("storenumber", "date","checknumber"), function(df1)paste(df1$item,collapse = ","))
View(out)
out$storenumber<-NULL
out$date<-NULL
out$checknumber<-NULL
write.csv(out,"/Users/punchh_shubham/Downloads/Murphy_MBA.csv" , quote = FALSE, row.names = TRUE)
Murphy_MBA<-read.transactions('/Users/punchh_shubham/Downloads/Murphy_MBA.csv', format = 'basket', sep = ',')
summary(Murphy_MBA)
library("RColorBrewer", lib.loc="/Library/Frameworks/R.framework/Versions/3.5/Resources/library")
association_rules<-apriori(Murphy_MBA,parameter = list(supp=0.001,conf=0.3,maxlen=12))
plot(association_rules, method = "two-key plot")
as(association_rules,"data.frame")
write.csv(association_rules,"/Users/punchh_shubham/Downloads/Murphys_Aso_Rule.csv" , quote = FALSE, row.names = TRUE)
rule_all<-as(association_rules, "data.frame")
write.csv(rule_all ,"/Users/punchh_shubham/Downloads/Murphy_Asso_Rules.csv", sep=",")
sub_association_rules_c<-head(association_rules, n=20, by="confidence")
sub_rule_c<-as(sub_association_rules_c, "data.frame")
write.csv(sub_rule_c ,"/Users/punchh_shubham/Downloads/Murphy_Top20_Rules_by_Confi.csv", sep=",")
plot(sub_association_rules_c, method = "paracoord")
