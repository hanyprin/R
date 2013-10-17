corr <- function(directory, threshold = 0) {
	setwd("E:/Coursera/CFDA")
	setwd(directory)
	files<-(Sys.glob("*"))
	correlations <- vector()
	for (i in files){
		monitor <- read.csv(i, header=T)
		monitor <- monitor[complete.cases(monitor),]
		if(nrow(monitor) > threshold)
			correlations<-append(correlations,cor(monitor$sulfate,monitor$nitrate))
	}
	setwd("E:/Coursera/CFDA")
	correlations
}