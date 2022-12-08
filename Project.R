data <- read.csv("mxmh_survey_results.csv",header = TRUE)
str(data)

library(dplyr)

data<-na_if(data,'')
data<-na.omit(data)

name<-names(data)

for (i in name)
{
  
  if(typeof(data[,i])=="character")
  {
    print(i)
    data[,i]  <- NULL
  }
}

data<-na.omit(data)

hist(data$BPM)

for (i in 1:nrow(data))
{
  
  if(data[i,3] < 60 || data[i,3] >115)
  {
    print(data[i,3])
    data[i,3]<-NA
    
  }else{
    
  }

  
}

data<-na.omit(data)


hist(data$Age)


for (i in 1:nrow(data))
{
  
  if(data[i,1] > 50)
  {
    print(data[i,1])
    data[i,1]<-NA
  }else{
    
  }
  
  
}

data<-na.omit(data)


hist(data$Hours.per.day)


for (i in 1:nrow(data))
{
  
  if(data[i,2] > 14)
  {
    print(data[i,1])
    data[i,2]<-NA
  }else{
    
  }
  
}

data<-na.omit(data)


hist(data$OCD)
for (i in 1:nrow(data))
{
  
  if(data[i,7] > 5.5)
  {
    print(data[i,7])
    data[i,7]<-NA
  }else{
    
  }
  
}
data<-na.omit(data)


hist(data$Insomnia)
# for (i in 1:nrow(data))
# {
#   
#   if(data[i,7] > 5.5)
#   {
#     print(data[i,7])
#     data[i,7]<-NA
#   }else{
#     
#   }
#   
# }
data<-na.omit(data)




name=names(data)
for (i in name)
{
  cat(range(data[,i]),'For ',i,'\n')
  
}

data2<-scale(data)

library('factoextra')
fviz_nbclust(data2,kmeans,method= 'wss')

km<- kmeans(data2,centers = 2,nstart = 25)
km

df_member <-cbind(data2,cluster = km$cluster)
fviz_cluster(km,data = data2)

arrg<-aggregate(data, by=list(cluster=km$cluster),mean)
arrg




