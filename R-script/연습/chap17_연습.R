#################################
## <제3장 연습문제>
#################################
data()
# 문1) acq 데이터 셋을 대상으로 다음과 같이 TDM 객체를 생성하시오.
# <조건1> 전체 단어의 갯수는 몇 개인가 ? 
# <조건2> 최대 단어 길이는 몇 개인가 ? 

data(acq) # corpus 객체 
str(acq)
class(acq)
head(str(acq[1]))

# 작업절차 : acq -> DATA전처리(2단계 ~ 8단계) -> DTM -> TDM -> ?
sms_corpus = tm_map(sms_corpus, tolower)  # 2) 소문자 변경 : hope you are having a good week. just checking in
sms_corpus = tm_map(sms_corpus, removeNumbers) # 3) 숫자 제거 : complimentary  star ibiza holiday or 짙, cash needs your urgent collection.  now from landline not to lose out! boxskwpppm+
sms_corpus = tm_map(sms_corpus, removePunctuation) # 4) 문장부호(콤마 등) 제거 : complimentary  star ibiza holiday or 짙 cash needs your urgent collection  now from landline not to lose out boxskwpppm
sms_corpus = tm_map(sms_corpus, removeWords, c(stopwords "SMART","짙")) # 5) stopwords(the, of, and 등) 제거  
stopwords("en") #174 불용어 제거 
stopwords("SMART") #571 complimentary  star ibiza holiday  짙 cash   urgent collection    landline   lose  boxskwpppm
sms_corpus = tm_map(sms_corpus, stripWhitespace) # 6) 여러 공백 제거(stopword 자리 공백 제거)   complimentary star ibiza holiday 짙 cash urgent collection landline lose boxskwpppm
sms_corpus = tm_map(sms_corpus, stemDocument) # 7) 유사 단어 어근 처리 hope good week checking-> hope good week check
sms_corpus = tm_map(sms_corpus, stripWhitespace) # 8) 여러 공백 제거(어근 처리 공백 제거)   
sms_dtm = DocumentTermMatrix(sms_corpus)  


# 1. DATA 전처리(2단계 ~ 8단계)
acq_corpus = tm_map(acq, tolower)  # 2) 소문자 변경
acq_corpus = tm_map(acq_corpus, PlainTextDocument) # [추가] 평서문 변경



# 2. DTM 생성(9단계)


# 3. TDM 생성(전치행렬) 


# 문2) crude 데이터 셋을 대상으로 다음과 같이 TDM 객체를 생성하시오.
# <조건1> 단어 길이 : 1 ~ 8
# <조건2> 가중치 적용 : 출현빈도수의 비율 (TFiDF)
# <조건3> 위 조건의 결과를 대상으로 단어수는 몇개인가 ?  

data(crude)

# 1. DATA전처리(3단계 ~ 8단계)
crude_corpus = tm_map(crude, tolower)  # 2) 소문자 변경
crude_corpus = tm_map(crude_corpus, PlainTextDocument) # [추가] 평서문 변경


# 2. DTM 생성 



# 3. TDM 생성 
