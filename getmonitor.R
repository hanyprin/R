
getmonitor <- function(id, directory, summarize = FALSE) {
	setwd("E:/Coursera/CFDA")       
	setwd(directory)
	id = as.character(formatC(id,flag=0,width=3))
	monitor <- read.csv(paste0(id,".csv"),header=T)
	if(summarize) print(summary(monitor))
	setwd("E:/Coursera/CFDA") 
	monitor
}
