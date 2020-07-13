#chap09_3_newsCrawling 뉴스 분석 

#https://media.daum.net
#<a href="url"> 기사 내용 </a>

# <a :태그 이름 
# href :속성

# 1.패키지 설치 
install.packages("httr") #원격 url 요청
library(httr)
install.packages("XML") #tag안의 문서를 html형식으로 파싱
library(XML)

#2.url요청 
url <- "https://media.daum.net"
web <- GET(url)             #마우스 오른쪽 페이지 소스 정보 
web #Status: 200 -> 정상으로 성공적으로 넘겨줌. 

#3. html 파싱(text -> html) : <a와 같은 태그 정리해서 보기위함. 
help("htmlTreeParse")
html <- htmlTreeParse(web, useInternalNodes = T, 
              trim = T,  encoding = "UTF-8")  

root_node <- xmlRoot(html)

#4.tag 자료수집 "//tag[@속성='값']"
news <- xpathSApply(root_node,"//a[@class='link_txt']", xmlValue)

news2 <- news[1:59]

#5. news전처리 

news_sent = gsub('[\n\r\t]','', news2) #이스케이프 문자 
news_sent = gsub('[[:punct:]]', '', news_sent) #문장부호 제거
news_sent = gsub('[[:cntrl:]]', '', news_sent) #특수문자 제거
news_sent = gsub('[A-Z]','', news2) #영문제거 
news_sent = gsub('[a-z]','', news2) #영문제거
news_sent = gsub('\\s+',' ', news2) #2개 이상 공백 제거 

news_sent 
         
#6. file save
setwd("c://ITWILL/2_Rwork/output")

#행번호 텍스트 저장 
write.csv(news_sent,'news_sent.csv', row.names = T, quote=F)

#불러오기 
news_data <-read.csv('news_sent.csv')
head(news_data)                  
     
colnames(news_data) <-  c('no','news_text')
head(news_data)             
                  
news_text <- news_data$news_text
news_text


#7. 토픽분석 -> 단어 구름 시각화 (1day)

library(KoNLP)
library(tm)
library(wordcloud)

#신규단어 
user_dic =data.frame(term=c("펜데믹","코로나19","타다"), tag='ncn')

buildDictionary(ext_dic = 'sejong', user_dic = user_dic)
#370964 words dictionary was built.

exNouns <- function(x) { 
  paste(extractNoun(as.character(x)), collapse=" ")
}


news_nouns <- sapply(news_text, exNouns)  #facebook_data 76개의 문장 
news_nouns
# (3) 단어 추출 결과
str(news_nouns) 


## 5. 데이터 전처리   
# (1) 말뭉치(코퍼스:Corpus) 생성 : 텍스트를 처리할 수 있는 자료의 집합 
myCorpus <- Corpus(VectorSource(news_nouns))  # 벡터 소스 생성 -> 코퍼스 생성 
myCorpus 

myCorpusPrepro_term <- TermDocumentMatrix(myCorpusPrepro, 
                                          control=list(wordLengths=c(4,16)))
myCorpusPrepro_term
# <<TermDocumentMatrix (terms: 51, documents: 12)>>
#   Non-/sparse entries: 54/558
# Sparsity           : 91%
# Maximal term length: 5
# Weighting          : term frequency (tf)


# (2) 불용어 제거 : 의미없는 단어 제거 
# [단계1] 데이터 전처리 : 말뭉치 대상 전처리 
#tm_map(x,FUN) : 이전의 것 제거
myCorpusPrepro <- tm_map(myCorpus, removePunctuation) # 문장부호 제거
myCorpusPrepro <- tm_map(myCorpusPrepro, removeNumbers) # 수치 제거
myCorpusPrepro <- tm_map(myCorpusPrepro, tolower) # 소문자 변경
myCorpusPrepro <-tm_map(myCorpusPrepro, removeWords, c(stopwords('english','사용','하기'))) # 불용어제거
stopwords('english') 

#[단계2]단어 문서 행렬 생성 
myCorpusPrepro_term <-TermDocumentMatrix(myCorpusPrepro, 
                                         control=list(wordLengths=c(4,16)))


#[단계3] 말뭉치 -> 평서문
myTerm_df <-as.data.frame(as.matrix(myCorpusPrepro_term)) 

#[단계4]내림정렬
wordResult<- sort(rowSums(myTerm_df), decreasing=TRUE) 
wordResult


## 8. 단어구름에 디자인 적용(빈도수, 색상, 랜덤, 회전 등)
# (1) 단어 이름 생성 -> 빈도수의 이름
myName <- names(wordResult)  #단어이름 추출 

# (2) 단어이름과 빈도수로 data.frame 생성
word.df <- data.frame(word=myName, freq=wordResult) 
head(word.df)
str(word.df) # word, freq 변수

# (3) 단어 색상과 글꼴 지정
pal <- brewer.pal(12,"Paired") # 12가지 색상 pal <- brewer.pal(9,"Set1") # Set1~ Set3
# 폰트 설정세팅 : "맑은 고딕", "서울남산체 B"
windowsFonts(malgun=windowsFont("맑은 고딕"))  #windows

# (4) 단어 구름 시각화 - 별도의 창에 색상, 빈도수, 글꼴, 회전 등의 속성을 적용하여 
wordcloud(word.df$word, word.df$freq, 
          scale=c(5,1), min.freq=2, random.order=F, 
          rot.per=.1, colors=pal, family="malgun")

# min.freq=2 최소 출현빈도수 




