## load the files


X_train <- read.table("C:/Users/USER/Downloads/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt", quote="\"")
X_test <- read.table("C:/Users/USER/Downloads/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt", quote="\"")
features <- read.table("C:/Users/USER/Downloads/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/features.txt", quote="\"")
subject_train <- read.table("C:/USER/ddehaas/Downloads/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt", quote="\"")
subject_test <- read.table("C:/USER/ddehaas/Downloads/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt", quote="\"")

colnames(X_test)<-features[,2]
test<-cbind(subject_test,X_test)

colnames(X_train)<-features[,2]
train<-cbind(subject_train,X_train)

combi<-rbind(train,test)
colnames(combi)[1]<-"Subject"

SELECT<-which(grepl("subject|-mean\\()|-std\\()", colnames(combi), ignore.case = T))
TIDY<-combi[,SELECT]

require(reshape2)
TIDYreshapred<-melt(TIDY,id.vars="Subject",variable.name="MEASURE",value.name="VALUE")

require(data.table)
DT<-as.data.table(TIDYreshapred)
RESULT<-as.data.frame(DT[,mean(VALUE),by=list(Subject,MEASURE)])

dcast(RESULT,Subject~MEASURE, value.var="V1")
