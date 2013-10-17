setwd("E:/machine/R")

tm<-read.csv("IF0013.csv",header=T)
nm<-read.csv("IF0014.csv",header=T)

j=0
for (i in 1:nrow(tm))
{
	if (nrow(nm)<i-j) 
	{
		tm[i,]=NA
	}
	else if (tm$trade_date[i]<nm$trade_date[i-j] || 
		 (tm$trade_date[i]==nm$trade_date[i-j] && tm$trade_time[i]<nm$trade_time[i-j]))
	{
		j=j+1
		tm[i,]=NA
	}
	else if (tm$trade_date[i]>nm$trade_date[i-j] || 
				(tm$trade_date[i]==nm$trade_date[i-j] && tm$trade_time[i]>nm$trade_time[i-j]))
	{
		while(tm$trade_date[i]>nm$trade_date[i-j] || 
				(tm$trade_date[i]==nm$trade_date[i-j] && tm$trade_time[i]>nm$trade_time[i-j]))
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
tm=tm[complete.cases(tm),]
nm=nm[complete.cases(nm),]

newdata<-cbind(tm,nm)
newdata<-newdata[-c(2,10,12,20)]
newdata$trade_time=as.character(formatC(newdata$trade_time,flag=0,width=6))
newdata$trade_time.1=as.character(formatC(newdata$trade_time.1,flag=0,width=6))
newdata$trade_time=paste(newdata[,2],newdata[,3])
newdata$trade_time.1=paste(newdata[,10],newdata[,11])
newdata=newdata[-c(2,10)]
newdata$trade_time=as.character(strptime(newdata[,2],format='%Y%m%d %H%M%S'))
newdata$trade_time.1=as.character(strptime(newdata[,9],format='%Y%m%d %H%M%S'))


write.csv(newdata, file="IFclean_3.csv",row.names=F)



