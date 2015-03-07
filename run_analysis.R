

run_analysis <- function() {
  
  # Load data
  features = read.table("froga/features.txt");
  labels = read.table("froga/activity_labels.txt");
  xtest = read.table("froga/X_test.txt");
  ytest = read.table("froga/y_test.txt");
  stest = read.table("froga/subject_test.txt");
  xtrain = read.table("froga/X_train.txt");
  ytrain = read.table("froga/y_train.txt");
  strain = read.table("froga/subject_train.txt");
  
  #Asign column names
  colnames(xtest)<-features[,"V2"];
  colnames(stest)<-"Subject";
  colnames(xtrain)<-features[,"V2"];
  colnames(strain)<-"Subject";
  
  #Extract the measurement of the mean and standard deviation
  # Any column containing mean or std on the name will be included
  meanCols<-grepl( "*mean\\(\\)$", as.character(features$V2));
  stdCols<-grepl( "*std\\(\\)$", as.character(features$V2));
  selectCols<-meanCols|stdCols;
  xtrain<-xtrain[selectCols];
  xtest<-xtest[selectCols];
  # Give descriptive names
  labellist<-labels[,2];
  ytest<- data.matrix(ytest);
  ytest<-labellist[ytest];
  ytrain<- data.matrix(ytrain);
  ytrain<-labellist[ytrain];
  
  # Combine data files
  test<-cbind(stest,ytest,xtest);
  colnames(test)[2]<-"Label";
  train<-cbind(strain,ytrain,xtrain);
  colnames(train)[2]<-"Label";
  
  #Merge data sets
  dataset<-rbind(test,train);
  
  # Create a tidy data set
  options(dplyr.width = Inf);
  retdt <- dataset %>% group_by(Label,Subject) %>% summarise_each(funs(mean));
  write.table(retdt,file="froga/result.txt", row.names=FALSE)
}