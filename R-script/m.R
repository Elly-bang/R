
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
inspect(medi_corpus[1])

medi_corpus=Corpus(VectorSource(medi$DIAGNOSIS))
medi_corpus #documents: 397

medi_corpus = tm_map(medi_corpus, removeWords,c(stopwords "SMART"))
medi_corpus = tm_map(medi_corpus, removeWords,c(stopwords "en"))
medi_corpus = tm_map(medi_corpus, stripWhitespace) 

medi_corpus = tm_map(medi_corpus, removePunctuation)
#콤마, (체온37.4도-> 374도) 14행 : kirkukli for 721/723-> kirkukli for 721723
medi_corpus = tm_map(medi_corpus, tolower)#의학용어 축약어(또는 she or he처럼 지칭도 있음. 진행)
medi_corpus = tm_map(medi_corpus, removeNumbers)  #수치: 혈압 또는 경과를 보므로 삭제x

medi_corpus = tm_map(medi_corpus, stemDocument)
medi_corpus = tm_map(medi_corpus, stripWhitespace)   
medi_dtm = DocumentTermMatrix(medi_corpus)
medi_dtm

inspect(medi_corpus[1])

medi_corpus = tm_map(medi_corpus, removePunctuation) 

library(wordcloud) #단어구름시각화
pal <- brewer.pal(12,"Paired")#색상 적용

#DTM-> TDM-> 평서문 변환 
medi_mt <- as.matrix(t(medi_dtm)) # 행렬 변경 
medi_mt 

# 행 단위(단어수) 합계 -> 내림차순 정렬    
rsum <- sort(rowSums(medi_mt), decreasing=TRUE) 
#출현빈도수rowSums(sms_mt)
rsum[1:10]























