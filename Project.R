data <- read.csv("mxmh_survey_results.csv",header = TRUE)
str(data)

library(dplyr)

data<-na_if(data,'')
data<-na.omit(data)

name<-names(data)

mainData <- subset(data, select = -c(Timestamp,Age,Primary.streaming.service,Permissions))
  
  # data$Primary.streaming.service <- unclass(factor(data$Primary.streaming.service))
  # data$While.working <- unclass(factor(data$While.working))
  # data$Music.effects <- unclass(factor(data$Music.effects))
  # data$Frequency..Video.game.music. <- unclass(factor(data$Frequency..Video.game.music.))
  # data$Frequency..R.B.  <- unclass(factor(data$Frequency..R.B. ))
  # data$Frequency..Pop.  <- unclass(factor(data$Frequency..Pop. ))
  # data$Frequency..Metal.  <- unclass(factor(data$Frequency..Metal. ))
  # data$Frequency..Metal.  <- unclass(factor(data$Latin ))
  # 
  
  for (i in name)
  {
    if(typeof(data[,i])=="character")
    {
      data[,i]  <- unclass(factor(data[,i]))
    }
  }

data2<-scale(mainData)
