
install.packages("xlsx")
library(xlsx)
setwd("c:/itwill/2_Rwork/Part-ii")
medi= read.xlsx("medi_data.xlsx", sheetIndex = 1)
str(medi)
#data.frame':	397 obs. of  3 variables:
#$ CODE_NUMBER     : num  1 1 1 1 1 1 1 1 1 1 ...
#$ CODE_DESCRIPTION: Factor w/ 25 levels "Achilles tendinitis",..: 3 3 3 3 3 3 3 3 3 3 ...
#$ DIAGNOSIS       : Factor w/ 397 leve

#medi_data는 3개의 칼럼으로 되어있다. 
#CODE_NUMBER,CODE_DESCRIPTION,DIAGNOSIS가 y변수 ??


#install.packages('tm')
install.packages('slam') # tm 패키지 의존 관계 
library(slam) 
library(tm)  
install.packages('SnowballC') # 어근 처리 함수
library(SnowballC) 

remove(medi_corpus) 

DIAGNOSIS<-as.character(medi$DIAGNOSIS)

medi_corpus=Corpus(VectorSource(medi$DIAGNOSIS))
medi_corpus #documents: 397

medi_corpus = tm_map(medi_corpus, tolower) 
medi_corpus = tm_map(medi_corpus, removeNumbers) 
medi_corpus = tm_map(medi_corpus, removePunctuation)
medi_corpus = tm_map(medi_corpus, removeWords, stopwords("SMART"))   
medi_corpus = tm_map(medi_corpus, stripWhitespace)    
medi_corpus = tm_map(medi_corpus, stemDocument) 
medi_corpus = tm_map(medi_corpuss, stripWhitespace) 

medi_dtm = DocumentTermMatrix(medi_corpus, control = list(weighting = weightTfIdf)) 
medi_dtm 

# Non-/sparse entries: 14019/1049941
# Sparsity           : 99%
# Maximal term length: 34
# Weighting          : term frequency - inverse document frequency (normalized) (tf-idf)

inspect(medi_dtm)
dim(medi_dtm) # 397 2680

medi_mat <- as.matrix(t(medi_dtm))
medi_mat
dim(medi_mat) # 397 2680

medi_mat[c(1:17),]

head(medi_mat,2)


medi_dtm1 = as.data.frame(as.matrix(medi_dtm))
medi_dtm1

medi_data2 <- cbind(medi, medi_dtm1)


write.csv(medi_data2,'c:/ITwill/2_Rwork/Part-ii/medi_data2.csv')

str(medi_data2)

medi_data3 <- medi_data2[-c(1,3,4)]
str(medi_data3)
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
mat<- medi_da?? 
  
mat[c(1:10),]

#####################################################################################################
medi_dtm = DocumentTermMatrix(medi_corpus)
medi_dtm

# <<DocumentTermMatrix (documents: 397, terms: 2900)>>
#   Non-/sparse entries: 17005/1134295
# Sparsity           : 99%
# Maximal term length: 34
# Weighting          : term frequency (tf)

#실제 개발시에는 고려할 사항: 콤마, (체온37.4도-> 374도) 14행 : kirkukli for 721/723-> kirkukli for 721723 ,
#의학용어 축약어(또는 she or he처럼 지칭도 있음. 진행),수치: 혈압 또는 경과를 보므로 삭제x

library(wordcloud) #단어구름시각화
pal <- brewer.pal(12,"Paired")#색상 적용

#DTM-> TDM-> 평서문 변환 
medi_mt <- as.matrix(t(medi_dtm)) # 행렬 변경 
medi_mt 





#############################################################################################
# 행 단위(단어수) 합계 -> 내림차순 정렬    
rsum <- sort(rowSums(medi_mt), decreasing=TRUE) 
#출현빈도수rowSums(sms_mt)
rsum[1:10]
##############################################################################################
#단어수 조정- 단어 길이, 가중치 적용 
##############################################################################################
#질병 관계에 따라 가중치 적용, 관련범위가 넓을 수록 가중치는 낮다
#여러 질병에서 보이면 낮고, 단일 질병 출현하면 가중치 


# 2. 가중치 : 단어출현빈도로 가중치(비율) 적용 
# - 출현빈도수 -> 비율 가중치 조정 control 
medi_dtm1 = DocumentTermMatrix(medi_corpus,
                              control = list(wordLengths= c(1,8)??,  weighting = weightTfIdf))
medi_dtm1 #??


#가중치 적용 방법
#1.TF :단어 출현빈도수
#2.TfIdf =TF*(1/DF)








