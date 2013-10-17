complete <- function(directory, id = 1:332) {
	setwd("E:/Coursera/CFDA")
	setwd(directory) 
	completeCases <- data.frame(id,0)
	colnames(completeCases) <- c("id","nobs")
	j = 1
	for(i in id){
		i = as.character(formatC(i,flag=0,width=3))
		monitor <- read.csv(paste0(i,".csv"),header=T)
		nob <- sum(complete.cases(monitor))
		completeCases[j,2] = nob
		j = j + 1
	}
	setwd("E:/Coursera/CFDA")
	completeCases	
}