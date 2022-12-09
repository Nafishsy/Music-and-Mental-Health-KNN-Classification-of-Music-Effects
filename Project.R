install.packages('dplyr')
install.packages('caret')
install.packages('class')
library(class)
library(caret)
library(dplyr)

data <- read.csv("mxmh_survey_results.csv",header = TRUE)
str(data)

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



set.seed(200)

# KNN 1st method

  dat.d <- sample(1:nrow(data.normalized),size=nrow(data.normalized)*0.7,replace = FALSE)
  
  train.data <- data.subset[dat.d,]
  test.data <- data.subset[-dat.d,]
  
  train.data_labels <- data.subset[dat.d,8]
  test.data_labels <-data.subset[-dat.d,8]
  
  optimal_K =NROW(train.data_labels)
  sqrt(optimal_K)
  
  knn.20 <- knn(train=train.data, test=test.data, cl=train.data_labels, k=15)
  ACC.20 <- 100 * sum(test.data_labels == knn.20)/NROW(test.data_labels)
  
  ConfusionMAT <- confusionMatrix(table(knn.20 ,test.data_labels))
  
  knn.20 <- factor(knn.20,levels = c(1,2,3),labels = c("Improve","Worsen","No effect"))
  knn.20

  num =nrow(data.subset)
  
  num =round(num/10)
  
  K10FOLD.ACC= 0
  
  for (i in 1:num-1) {
    j=i*10
    k=i*10-10
    
    test.data <- data.subset[k:j,]
    train.data <- data.subset[-(k:j),]
    
    test.data_labels <- data.subset[k:j,8]
    train.data_labels <-data.subset[-(k:j),8]
    
    k.fold.10 <- knn(train=train.data, test=test.data, cl=train.data_labels, k=10)
    ACC.k.fold <- 100 * sum(test.data_labels == k.fold.10)/NROW(test.data_labels)
  
    K10FOLD.ACC= K10FOLD.ACC + ACC.k.fold
  }
  print(K10FOLD.ACC/num)
  
  
  num =nrow(data.subset)
  
  N.FOLD.ACC= 0
  j=0
  for (i in 1:num-1) {
    j=j+1

    test.data <- data.subset[j,]
    train.data <- data.subset[-j,]
    
    test.data_labels <- data.subset[j,8]
    train.data_labels <-data.subset[-j,8]
    
    n.fold <- knn(train=train.data, test=test.data, cl=train.data_labels, k=1)
    ACC.n.fold <- 100 * sum(test.data_labels == n.fold)/NROW(test.data_labels)

    N.FOLD.ACC= N.FOLD.ACC + ACC.n.fold
  }
  print(N.FOLD.ACC/num)
  

