setwd("c:/ITWILL/2_Rwork")
medi<-read.csv('2차_분석용.csv')
str(medi)

names(medi)
medi$CODE_DESCRIPTION <- as.character(medi$CODE_DESCRIPTION)
str(medi)
unique(medi$CODE_DESCRIPTION)

#y변수를 수치형으로변경하기 

table(medi$CODE_DESCRIPTION)
unique(medi$CODE_DESCRIPTION)
length(medi$CODE_DESCRIPTION) #3702

medi$CODE_DESCRIPTION[medi$CODE_DESCRIPTION=='Asthma'] <-0
medi$CODE_DESCRIPTION[medi$CODE_DESCRIPTION=='Bronchitis'] <-1
medi$CODE_DESCRIPTION[medi$CODE_DESCRIPTION=='Hyperlipidaemia'] <-2
medi$CODE_DESCRIPTION[medi$CODE_DESCRIPTION=='Hypertension'] <-3
medi$CODE_DESCRIPTION[medi$CODE_DESCRIPTION=='Immunisation, Influenza'] <-4
medi$CODE_DESCRIPTION[medi$CODE_DESCRIPTION=='Otitis media']  <-5
medi$CODE_DESCRIPTION[medi$CODE_DESCRIPTION=='Tonsillitis']  <-6
medi$CODE_DESCRIPTION[medi$CODE_DESCRIPTION=='URTI']  <-7
medi$CODE_DESCRIPTION[medi$CODE_DESCRIPTION=='UTI']  <-8
medi$CODE_DESCRIPTION[medi$CODE_DESCRIPTION=='Viral illness']  <-9


# copus
medi_corpus2 = Corpus(VectorSource(medi$NOTES))
medi_corpus2 = tm_map(medi_corpus2, tolower)
medi_corpus2 = tm_map(medi_corpus2, removeNumbers)
medi_corpus2 = tm_map(medi_corpus2, removePunctuation)
medi_corpus2 = tm_map(medi_corpus2, removeWords, stopwords("SMART"))
medi_corpus2 = tm_map(medi_corpus2, removeWords,c("ago","alert","certif"))
medi_corpus2 = tm_map(medi_corpus2, stripWhitespace)
medi_corpus2 = tm_map(medi_corpus2, stemDocument)
medi_corpus2 = tm_map(medi_corpus2, stripWhitespace)

medi_dtm = DocumentTermMatrix(medi_corpus2, control = list(weighting = weightTfIdf))
medi_dtm 
# <<DocumentTermMatrix (documents: 3702, terms: 5605)>>
# Non-/sparse entries: 154321/20595389
# Sparsity           : 99%
# Maximal term length: 49
# Weighting          : term frequency - inverse document frequency (normalized) (tf-i

str(medi_dtm)
dim(medi_dtm) #3702 5605

medi_mat<-as.matrix(medi_dtm)
dim(medi_mat)#3702 5605

medi_df<-data.frame(medi$CODE_DESCRIPTION,medi_mat)
str(medi_df) #data.frame':	3702 obs. of  5606 variables

idx<-sample(1:nrow(medi_df),0.7*nrow(medi_df))
train<-medi_df[idx,]
test<-medi_df[-idx,]

str(test) #'data.frame':	1111 obs. of  5606 variables

#xgb DMatrix
train_x <-as.matrix(train[-1])
dim(train_x) #2591 5605
# factor -> numeric
train_y <- as.numeric(train$medi.CODE_DESCRIPTION)
class(train_y)
table(train_y)

library(xgboost)
dmtrix<-xgb.DMatrix(data=train_x,label=train_y)

str(dmtrix)

#install.packages("xgboost")
#library(help="xgboost")

xgb_model <- xgboost(data = dmtrix, 
                     max_depth = 2, 
                     eta = 0.5, 
                     nthread = 2, 
                     nrounds = 2, 
                     objective = "multi:softmax",
                     num_class = 10,
                     verbose = 0)
xgb_model
# evaluation_log:
# iter train_merror
# 1        0.094
# 2        0.078

import <- xgb.importance(colnames(train_x), model = xgb_model)
import
# 
# Feature    Gain  Cover Frequency
# 1:           bronchiti 0.15317 0.0606     0.069
# 2:               media 0.14057 0.0624     0.069
# 3:                urti 0.13920 0.0611     0.052
# 4:              tonsil 0.09510 0.0762     0.052
# 5:               viral 0.08887 0.0487     0.034
# 6:                 uti 0.08349 0.0485     0.034
# 7:     hyperlipidaemia 0.06900 0.0451     0.052
# 8:              asthma 0.06693 0.0929     0.086
# 9:              vaccin 0.05823 0.0290     0.017
# 10:           hypertens 0.05330 0.0507     0.052
# 11:             immunis 0.00756 0.0270     0.017
# 12:     hyperlipaedemia 0.00733 0.0270     0.017
# 13:                vacc 0.00559 0.0155     0.017
# 14:                test 0.00557 0.0203     0.017
# 15:           influenza 0.00508 0.0204     0.017
# 16:                 ill 0.00466 0.0024     0.017
# 17:             abraham 0.00391 0.0390     0.052
# 18:              nitrit 0.00287 0.0404     0.034
# 19:                 bib 0.00177 0.0497     0.034
# 20:                file 0.00136 0.0268     0.017
# 21:             micardi 0.00133 0.0139     0.017
# 22:              tympan 0.00105 0.0398     0.034
# 23:                high 0.00085 0.0064     0.017
# 24:               manag 0.00059 0.0129     0.017
# 25: viewkinducdltrlangf 0.00058 0.0126     0.017
# 26:              visitb 0.00052 0.0134     0.017
# 27:                obes 0.00042 0.0058     0.017
# 28:        examinationb 0.00028 0.0056     0.017
# 29:      panadolnurofen 0.00022 0.0124     0.017
# 30:             crestor 0.00018 0.0124     0.017
# 31:                 red 0.00018 0.0049     0.017
# 32:            flixotid 0.00014 0.0097     0.017
# 33:              throat 0.00012 0.0060     0.017
# Feature    Gain  Cover Frequency

test_x=as.matrix(test[-1])
test_y=test$medi.CODE_DESCRIPTION

str(test_x)
str(test_y)

pred<-predict(xgb_model,test_x)
pred

tab<-table(test_y,pred)
tab

#분류정확도
acc<-tab[1,1]+tab[2,2]+tab[3,3]+tab[4,4]+tab[5,5]+tab[6,6]+tab[7,7]+tab[8,8]+tab[9,9]+tab[10,10]/length(test_y)
cat('분류정확도=',acc) #분류정확도= 918
range(acc) #[1] 918 918

mean_err<- mean(as.numeric(pred>=0.5) !=test_y)
cat('평균오차=', mean_err) #평균오차= 0.87

re=(pred==test$medi.CODE_DESCRIPTION)
table(re)
# FALSE  TRUE 
# 1093    18 

prop.table(table(re))
# FALSE  TRUE 
# 0.984 0.016 

