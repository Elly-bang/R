# CHAP01_BASIC

# 수업내용
# 1. PACKAGE, SESSOIN
# 2. 패키지 사용법
# 3. 변수와 자료형
# 4. 기본함수와 작업공간

# 1. PACKAGE, SESSOIN
available.packages()
DIM(available.packages())
# [1]15297(패키지 수)    17개의 정보로 제공
#dim함수 : data frame의 길이를 관측
getOption("max.print") #1000
  58*17 #986

#session
sessionInfo() #세션정보제공
#R환경, os환경, 다국어정보(locale)정보, 

#주요단축기
#script실행 : ctrl +enter
#save : ctrl+S
#자동완성 : ctrl + space bar // TAB키 누르기 
#여러줄 주석 : ctrl+shift+c


a<- 10
b<-20
c<-a+b
print(c)

#2. 패키지 사용법 : package = fuction +datatest

#1)패키지 설치 
#기존 버전 패키지를 현재 위치에 설치하는 방법
install.packages('https://cran.rstudio.com/bin/windows/contrib/3.2/xxx/zip',repos=null)

install.packages('stringr')

install.packages(stringr) #error

#패키지(1)+의존성 패키지 (3)

#2)패키지 설치 경로 
.libPaths() 
# 메모리에 올리는 함수 
#[1]"C:/Users/user/Documents/R/win-library/3.6" -확장 패키지
#[2]"C:/Program Files/R/R-3.6.2/library"     -30개 패키지

#3) in memory : 패키지 -> upload
library(stringr) #library('stringr') 
library(help='stringr')

#memory로딩된 캐키지 확인
search()
-> "package:stringr" 없음.

str_extract('홍길동35 이순신45','[가-힣]{3}')
#[1]"홍길동"
str_extract_all('홍길동35 이순신45','[가-힣]{3}')
#[[1]][1]"홍길동""이순신"

#4)패키지 삭제 
remove.packages('stringr') #물리적 삭제 가능
str_extract()

###############################################################
# # 패키지 설치 error해결법법
# 
# # 1. 최초 패키지 설치
#   -RStudio관리자 모드로 실행
# 
# #2. 기존 패키지 설치
#   1)remove.packages('패키지')
#   2)rebooting
#   3)install.packages('패키지')
###############################################################


# 3. 변수와 자료형
# 
# 1) 변수 : 메모리 이름
# 
# 2) 변수 작성 규칙
#  - 첫자는 영문, 두번째는 숫자, 특수문자('.','_')
#   ex- score2020,  score_soso, score.2020
#   예약어, 함수명 사용불가
#   대소문자 구분 
#   ex)num=100 ,NUM=10
#   변수 선언시 type 선언 없음
#   score =90(R) vs int score =90(c)
#   가장 최근값은로 변경됨
#   # R의 모든 변수는 객체 (object)


 var1 <- 0 # var1=0
 var1 <- 1
 var1 
 print(var1)
 
 var2 <- 10 
 var3 <- 20
 
 var1; var2; var3
 
# 색인((index) : 저장 위치 
  var3 <- c(10, 20, 30, 40, 50)
  var3 # [1] 10, 20, 30, 40, 50
  var3 [5] #50

#대소문자
NUM = 100
num = 200
print(NUM!=num) #관계식 --> T/F


#[1]false
# object.member
member.id = 'hong'
member.name ='홍길동'
member.age = 35

member.id ;member.age

# scala(0) 값이 하나 vs vector(1) 값이  여러개 
score <- 95
scores <- c(85,75,95,100) #vector
score #95
scores # [1] 85 75 95 100

score = 95
scores = c(85,75,95,100) #vector
score #95
scores 

# 3)자료형 (data type) : 숫자형, 문자형, 논리형

int <- 100
float <- 125.23
string<- "대한민국"
bool<-true #true, T, FALSE, F
char 문자 하나만 저장 

#자료형 반환 함수 
mode(int) #"numeric"
mode(float) #"numeric"
mode(string) #"character"
mode(bool) #logical 객체 'bool'를 찾을 수 없습니다

##############################################################
#is.xxxx
is.numeric(int) #TRUE
is.character(string) #TRUE
is.logical(bool) #TRUE
is.numeric(string) #FALSE

datas <- c(84,85,62,NA,45)
datas # 84 85 62 NA 45

is.na(datas) #결측치 -> true

##############################################################

#4) 자료형변환 함수 : p.20(as.xxx)

#(1)문자형 -> 숫자형 변환

x <- c (10,20,30,'40') # vector형 변수(값이 한개) : 단일 자료형
#하나가 문자면 다 문자로 취급
x
mode(x) #"numeric" -> "character"
x*2 #error

x= as.numeric(x) #홍길동 판별 못함 숫자만.
x
x*2
x**2

#################################################################


###################################################################
#(2) 요인형(factor)
#범주형 변수(집단변수)생성
#독립변수 (x변수): 더미변수 (0,1)생성

gender = c('남','여','남','여','여')  # 실제 연산 불가능하므로 숫자로 변환 :더미변수
mode (gender) #"character"
plot(gender) #Error


#문자형 -> 요인형 변환 

fgender =as.factor(gender)
mode(fgender) #"numeric"
plot(fgender) #Error

fgender
#[1] 남 여 남 여 여
#levels 남, 여 

mode vs class
str(fgender)
# Factor w/ 2 levels "남","여": 1 2 1 2 2
#더미변수 : 숫자의 의미가 없는 숫자형
#mode vs class
mode(fgender) #"numeric" --자료형 확인
class(fgender) #"factor" --자료 구조 확인


#factor형변환 고려사항

#숫자형 변수 
x =c(4,2,4,2)
mode(x)  #"numeric"


#숫자형 -> 요인형 
f = as.factor(x)
f  #Levels: 2 4

#요인형 -> 문자형
x2=as.character(f)
x2

#문자형 -> 숫자형
x2 = as.numeric(f)
x2 #2 1 2 1

#4.기본함수와 작업공간
#1)기본함수: 바로 사용하는 함수, 7개 패키지에 속한 함수
sessionInfo()
  

#패키지 도움말
library(help='stats')

#함수도움말
help(sum)
x = c(10,20,30,NA)
sum(x,na.rm=TRUE)

sum(1:5) #15
sum(1,2,3,4,5) #15
sum(10,20,30,NA,na.rm=TRUE) #60
sum(1:5) #20
sum(1,2,3,4,5) #15

#mean
mean(10,20,30,NA,na.rm=TRUE) #10
mean(x,na.rm=TRUE) #20

#2)기본 데이터 set

data() 
data(nile) 
#In data(nile) : 데이터셋 ‘nile’을 찾을 수 없습니다


data() #데이터셋  
data(nile) #in memory

Nile
length(Nile) #100
mode(Nile) #"numeric"
plot(Nile) 
hist(Nile)

#3)작업공간
getwd()"C:/ITWILL/2_Rwork"
setwd("C:/ITWILL/2_Rwork/part-i")
read
getwd()













































































































