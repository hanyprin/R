setwd('E:/machine/R')

library(pwr)
pwr.t.test(d=.004/.0066,sig.level=0.05,
power=.8,type='two.sample',alternative='two.sided')

ccd=read.table('ccddata.txt',header=T)

attach(ccd)

sex
sex[sex=='m']='M'
table(sex)
sex=droplevels(sex)

names(ccd)<-c('sex1','age1','BMI1','diet1','fail1','HbA1c1',
'CRP1','HbA1cbaseline1','CRPbaseline1')
age1[age1==999]=NA
BMI1[BMI1==999]=NA
HbA1c1[HbA1c1==999]=NA
HbA1cbaseline1[HbA1cbaseline1==999]=NA
CRP1[CRP1==999]=NA
CRPbaseline1[CRPbaseline1==999]=NA

HbA1cdiff=HbA1c-HbA1cbaseline
CRPdiff=CRP-CRPbaseline

logCRP=log10(CRP)
logCRPbaseline=log10(CRPbaseline)
logCRPdiff=logCRP-logCRPbaseline

#t test of HbA1c differences between High GI and Low GI diet groups
t.test(HbA1cdiff[diet=='H'],HbA1cdiff[diet=='L'])
#var.equal: a logical variable indicating whether to treat the 
#two variances as being equal. If TRUE then the pooled 
#variance is used to estimate the variance otherwise 
#the Welch (or Satterthwaite) approximation to the 
#degrees of freedom is used.
t.test(HbA1cdiff[diet=='H'],HbA1cdiff[diet=='L'],var.equal=T)

t=qt(0.025,df,lower.tail=F)
#pt(t,df,lower.tail=F)

mu1=mean(HbA1cdiff[diet=='H'],na.rm=T)
mu2=mean(HbA1cdiff[diet=='L'],na.rm=T)
s1=sd(HbA1cdiff[diet=='H'],na.rm=T)
s2=sd(HbA1cdiff[diet=='L'],na.rm=T)
n1=length(HbA1cdiff[diet=='H'])
n2=length(HbA1cdiff[diet=='L'])
df=(s1^2/n1+s2^2/n2)^2/((s1^2/n1)^2/(n1-1)+(s2^2/n2)^2/(n2-1))
mu1-mu2+t*sqrt(s1^2/n1+s2^2/n2)
mu1-mu2-t*sqrt(s1^2/n1+s2^2/n2)


t.test(logCRPdiff[diet=='H'],logCRPdiff[diet=='L'])

new=ccd[complete.cases(ccd),]
