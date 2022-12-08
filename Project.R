data <- read.csv("mxmh_survey_results.csv",header = TRUE)
str(data)

library(dplyr)

data<-na_if(data,'')
data<-na.omit(data)

name<-names(data)


data$Music.effects <- factor(data$Music.effects,
                     levels = c("Improve","Worsen","No effect"),
                     labels = c(1,2,3),
)

data.subset <- data[c('Age','Hours.per.day','BPM','Anxiety','Depression','Insomnia','OCD','Music.effects')]

head(data.subset)
normalize <- function(x) {
  return ((x - min(x)) / (max(x) - min(x))) 
}

data.normalized <- as.data.frame(lapply(data.subset[,1:7], normalize))

set.seed(123)
dat.d <- sample(1:nrow(data.normalized),size=nrow(data.normalized)*0.7,replace = FALSE)

train.data <- data.subset[dat.d,]
test.data <- data.subset[-dat.d,]

train.data_labels <- data.subset[dat.d,8]
test.data_labels <-data.subset[-dat.d,8]

install.packages('class')
library(class)

optimal_K =NROW(train.data_labels)
sqrt(optimal_K)


knn.20 <- knn(train=train.data, test=test.data, cl=train.data_labels, k=20)

ACC.20 <- 100 * sum(test.data_labels == knn.20)/NROW(test.data_labels)


install.packages('caret')
library(caret)
confusionMatrix(table(knn.20 ,test.data_labels))


