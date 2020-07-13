1. 조건문

#1) if(조건식)-조건식: 산술,관계,논리연산자
x=10
y=5
z=x*y
z
if(z>=20)
  cat('z는 20보다 크다.') #실행문

z=10

#형식)if(조건식){참}else{거짓}
if(z>=20){
  cat('z는 20보다 크다.')
}else{
  cat('z는 20보다 작다.')
}

#형식2) if(조건식1){참}else if(조건식2){참}else{거짓}
score = scan() #0~100
score

#score=grade(A,B,C,D,F)
grade =""
if(score>=90)
  grade="A"
}else if (score >=80){
  grade="B"
}else if (score >=70){
  grade="c"
}else if (score >=60){ 
  grade="D"
}else {
  grade="F"
}  
cat('점수는',score,'이고,등급은',grade,'입니다')

#문)키보드로 임의숫자를 입력받아서 짝수/홀수 판별
num=scan() #임의숫자 입력

10%%2 #나머지가 0=짝수, 

7%%2 #1

if(num%%2==0){
  cat('짝수이다.')
}else{
    cat('홀수이다')
}


#문)주민번호를 이용하여 성별 판별하기 
library(stringr)
jumin = "123546-4234567"

#성별추출하기 : str_sub(8,8)
gender =str_sub(jumin,8,8)
gender

#1 or 3 :남자 
#2 or 4 :여자 
#other :주민번호 양식 틀림

if(gender==1 | gender==3){cat('성별은 남자')}
else if (gender==2 | gender==4){
  cat('성별은 여자')
}else {
  cat("올바른 주민번호가 아닙니다")
}

#2)ifelse :if+else
#형식 ) ifelse(조건식, 참, 거짓) =3항 연산자
#vector입력=>처리=>vector출력

score = c(78,85,95,45,65)
grade=ifelse(score>=60,"합격","실패")
grade


excel=read.csv(file.choose())
str(excel)
q5 =excel$q5
length(q5)
table(q5)
# 1   2   3   4   5 (5점 척도)
# 8  81 107 160  46

#5점 척도 -> 범주형 변수 
q5_re = ifelse(q5>=3,"큰값","작은값")
table(q5_re)
# 작은값   큰값 
# 89    313

#NA-> 평균대체
x<-c(75,85,42,NA,85)
x_na=ifelse(is.na(x), mean(x,na.rm = T),x)
x_na # 75.00 85.00 42.00 71.75 85.00

#NA-> 0대체
x_na2=ifelse(is.na(x), 0,x)
x_na

#3)switch()함수 
#형식)switch(비교구문, 실행구문1,실행구문2,실행구문3)
switch("pwd",age=105,name="홍길동",id="hong",pwd="1234")
#name : "홍길동"
#pwd : "1234"

#\n 줄바꿈
#path c:\\Rwork

#4) which 문 
#조건식에 만족하는 위치 반환

name <- c("kim","lee","choi","park") 
which(name=="choi") # [1] 3

library(MASS)
data("Boston")

str(Boston)
#'data.frame':	506 obs. of  14 variables:

name = names(Boston)
name
length(name)

#x(독립변수),y(종속변수)변수 선택 
y_col <-which(name=="medv")
y_col

Y=Boston[y_col] #종속변수Y
head(Y)

x = Boston[-y_col] #종속변수x
head(x)

#문)iris 데이터셋으ㄹ대상으로 x변수(1~4칼럼), y변수(5칼럼)
name=names(iris)
name

y_col = which(name=="Species")
y_col

Y=iris[y_col]  #y(종속변수)
head(Y)

X=iris[-y_col] #x(종속변수)
head(X)

#2. 반복문

# 1)for문 (변수 in 열거형 객체){실행문}

num =1:10 #열거형 객체 
num 

for(i in num){#10회 반복
cat('i=',i,'\n') #실행문
print(i*2) #줄바꿈
}

#홀수/짝수 출력
for(i in num){#10회 반복
  if(i %% 2 == 0) #!=0
  cat('i=',i,'\n')
  }

for(i in num){#10회 반복
if(i %%2  !=0)
cat('i=',i,'\n')
}
#문_ 키보드로 5개 정수를 입력 받아서 짝수 홀수 판별

num =scan() #5개 정수 입력 

num =scan()
num

 
for(i in num){
  if(i %% 2 == 0) {
    cat("짝수\n")
  }else{
  cat("홀수\n")
}

  num = 1:100
  num
  
  # 문2)홀수의 합과 짝수 합 출력하기 
  
  even = 0 #짝수의 합
  odd #홀수의 합
  cnt #카운터 변수 
  
  for(i in num){
    if(i %% 2 == 0) {
      even =even +i #짝수 누적
    }else{
      odd = odd +i  #홀수 누적
    }
  }
  
  
cat('짝수의 합=',even, '홀수의 합=', odd)

#칼럼 = 칼럼 - 칼럼 
kospi$diff 
str(kospi)

row = nrow(kospi)
#diff 평균 이상,아니면 평균미만

diff_result ="" #변수 초기화

for(i in 1:row){ #247회 반복
  if(kospi$diff[i])>= mean(kospi$diff)){
    diff_result[i] ='평균이상'
  }else{
    diff_result[i] ='평균미만'
  }
}

#칼럼추가 
kospi$diff_result=diff_result
table(kospi$diff_result)

#이중for문 : 구구단 


for(i in 2:9){ #i :단수 
   cat('***',i,'단***\n')
  
  for( j in 1:9){ #j : 곱수
   cat(i, '*', j, '=',(i*j),'\n')
  } #inner for
  
  cat("\n")
}#outer for

#이중for문 : 구구단 file save

for(i in 2:9){ #i :단수 
  cat('***',i,'단***\n',
  file="C:/ITWILL/2_Rwork/output/gugu.txt",
  append=TRUE)
  
  for( j in 1:9){ #j : 곱수
    cat(i, '*', j, '=',(i*j),'\n',
    file="C:/ITWILL/2_Rwork/output/gugu.txt",
    append=TRUE)
  } #inner for
  
  cat("\n",
file="C:/ITWILL/2_Rwork/output/gugu.txt",
append=TRUE)
}#outer for

for(변수 in열거형){
  for(변수 in열거형){
    실행문 
  }
}


#text file read
gugu.txt=readLines("C:/ITWILL/2_Rwork/output/gugu.txt")
gugu.txt


#2)while(조건식){실행문}
i =0 #초기화
while (i<5) {
  cat('i= ', i, '\n')
  i= i+1 #카운터 
}

x=c(2,5,8,6,9)
x #각 변량 제곱
n=length(x)

i=0
while(i<n){
  i= i+1
  x[i] = x[i]^2
}



