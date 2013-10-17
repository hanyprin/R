setwd("E:/machine/R")

tm<-read.csv("IF0013.csv",header=T)
nm<-read.csv("IF0014.csv",header=T)
tm<-tm[-c(2,10)]
nm<-nm[-c(2,10)]
tm$trade_time=as.character(formatC(tm$trade_time,flag=0,width=6))
nm$trade_time=as.character(formatC(nm$trade_time,flag=0,width=6))
tm$trade_time=paste(tm[,2],tm[,3])
nm$trade_time=paste(nm[,2],nm[,3])
tm=tm[,-2]
nm=nm[,-2]
tm$trade_time=strptime(tm[,2],format='%Y%m%d %H%M%S')
nm$trade_time=strptime(nm[,2],format='%Y%m%d %H%M%S')


j=0
for (i in 1:nrow(tm))
{
	if (nrow(nm)<i-j) 
	{
		tm[i,]=NA
	}
	else if (tm$trade_time[i]<nm$trade_time[i-j])
	{
		j=j+1
		tm[i,]=NA
	}
	else if (tm$trade_time[i]>nm$trade_time[i-j])
	{
		while(tm$trade_time[i]>nm$trade_time[i-j])
		{
			nm[i-j,]=NA
			j=j-1
		}
		if (tm$trade_time[i]<nm$trade_time[i-j])
		{
			j=j+1
			tm[i,]=NA
		}
	}
}
tm$trade_time=as.character(tm$trade_time)
nm$trade_time=as.character(nm$trade_time)
tm=tm[complete.cases(tm),]
nm=nm[complete.cases(nm),]

newdata<-cbind(tm,nm)
write.csv(newdata, file="ifclean.csv",row.names=F)