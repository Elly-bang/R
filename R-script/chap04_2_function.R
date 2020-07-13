#chap04_2_function

#1. 사용자 정의 함수

#형식
#함수명 <- function ([인수]){
# 실행문
# 실행문
# [return값]
# }

#매개변수없는 함수
f1 =function(){
  cat('f1함수')
}

cat(f1())

f1()#함수호출

#2)매개변수 있는 함수 
f2=function(x){
  x2=x^2
  cat('x2 =',x2)
}


=> 제곱 ^


f2(10)

#3)리턴있는 함수 
f3 =function(x,y){
  add=x+y
  return(add) 
}

#함수호출 -> 반환값

add_re <-f3(10,5)
add_re

num=1:10

tot<-function(x){
  tot=sum(x)
  return(tot)
}

tot_re =tot_func(num)

avg = tot_re/length(num)
avg

# 
# #문)calc함수를 정의하기 
# 100+20=120
# 100-20=80
# 100*2=2000
# 100/20=5


x=100
y=20

calc=function(x,y){
  add=x+y
  sub=x-y
  mul=x*y
  div=x/y
  cat(x,"+",y,"=",add, '\n') 
  cat(x,"-",y,"=",sub, '\n')
  cat(x,"*",y,"=",mul, '\n')
  cat(x,"/",y,"=",div, '\n')
  calc_df<-data.frame(add, sub, mul,div)
  return(calc_df)
  }

#함수호출
df = calc(100,20)
df

#구구단의 단을 인수로 받아서 구구단 출력하는 함수 
gugu=function(dan){
  cat('***',dan,'단***\n')
  for(i in 1:9){
    cat(dan, '*',i,'=',dan*i, '\n')
  }
}
gugu(2)
gugu(5)


state = function(fname, data){
  switch(fname,
          SUM=sum(data),
          AVG=mean(data),
          VAR=var(data),
          SD=sd(data),
          MAX=max(data))
}



data =1:10
state("SUM", data)
state("AVG", data)
state("VAR", data)
state("SD", data)
state("MAX",data)

#결측치(NA)처리 함수 
na=function(x){
# #1.NA제거 
  x1=na.omit(x)
  cat('x1=', x1,'\n')
  cat('x1=', mean(x1),'\n')
  
  
#   2.NA 평균
x2= ifelse(is.na(x),mean(x,na.rm = T),x)
cat('x2=', x2,'\n')
cat('x2=',mean(x2),'\n')

  
  # 3.NA=0
x3=ifelse(is.na(x),0,x)
cat('x3=',x3,'\n')
cat('x3=',mean(x3),'\n')

}

x=c(10,5,NA,4,2,6.3,NA,7.3,8)
x
length(x)
mean(x,na.rm = T) 

#함수호출
na(x)


###################################
### 몬테카를로 시뮬레이션 
###################################
# 현실적으로 불가능한 문제의 해답을 얻기 위해서 난수의 확률분포를 이용하여 
# 모의시험으로 근사적 해를 구하는 기법

# 동전 앞/뒤 난수 확률분포 함수 
coin <- function(n){
  r <- runif(n, min=0, max=1)
  #print(r) # n번 시행 
  
  result <- numeric()
  for (i in 1:n){
    if (r[i] <= 0.5)
      result[i] <- 0 # 앞면 
    else 
      result[i] <- 1 # 뒷면
  }
  return(result)
}


# 몬테카를로 시뮬레이션 
montaCoin <- function(n){
  cnt <- 0
  for(i in 1:n){
    cnt <- cnt + coin(1) # 동전 함수 호출 
  }
  result <- cnt / n
  return(result)
}

montaCoin(1000) #[1] 0.502 

#중심극한의 정리 :데이터가 많을 수록 평균에 가까워짐

# 1) 기술통계함수 

vec <- 1:10          
min(vec)                   # 최소값
max(vec)                   # 최대값
range(vec)                  # 범위
mean(vec)                   # 평균
median(vec)                # 중위수
sum(vec)                   # 합계
prod(vec)                  # 데이터의 곱
1*2*3*4*5*6*7*8*9*10
summary(vec)    

# 요약통계량 
norm(10)
datasd(rnorm(10))      # 표준편차 구하기
factorial(5) # 팩토리얼=120

sqrt(49) # 루트

install.packages('RSADBE')
library(RSADBE)

library(help="RSADBE")
data("Bug_Metrics_Software")
str(Bug_Metrics_Software)
Bug_Metrics_Software


#소프트웨어 발표전 버그 수 
Bug_Metrics_software[,,1] #before
Bug_Metrics_software[,,2] #after


bug = Bug_Metrics_Software #복제
bug =array(bug, dim=c(5,5,3))

dim(bug.new)

bug[,,3]=bug[,,1]-bug[,,2]
bug

# 소프트웨어 발표후 버그 수 
Bug_Metrics_software[,,2] #after

#행단위 합계(->)
rowSums(Bug_Metrics_Software[,,1],na.rm = T)

#열단위 합계 : 버그별 합계
colSums(Bug_Metrics_Software[,,1],na.rm = T)

# 2) 반올림 관련 함수 
x <- c(1.5, 2.5, -1.3, 2.5)
round(mean(x)) # 1.3 -> 1
ceiling(mean(x)) # x보다 큰 정수 
floor(mean(x)) # x보다 작은 정수 

#3)난수 생성과 확률분포
#(1) 정규분포를 따르는 난수 -연속확률분포(실수형)
#형식)rnorm(n,mean=0,sd=1)
n=1000
r=rnorm(n,mean=0,sd=1) #표준정규분포
r
mean(r)
sd(r)
hist(r) #대칭성

#(2)균등분포를 따르는 난수 연속활률분포 실수형
#형식)runif(n,min=0,max=1)

r2=runif(n,min=0,max=1)
r2
hist(r2)

#(3)이항분포를 따르는 난수 이산확률분포 (정수형)
set.seed(123) #seed값이 같으면 동일난수 

n=10
r3=rbinom(n,size=1,prob =0.5)#1/2로 줄어든 확률
r3

r3=rbinom(n,size=1,prob =0.25) #1/4로 줄어든 확률
r3

# 홀드아웃방식

#(4)smaple
sample(10:20,5)
#1/4로 줄어든 확률
sample(c(10:20,50:100),10)

#train(70%) /test(30%) 데이터 셋 
dim(iris)

idx = sample(nrow(iris),nrow(iris)*0.7)
range(idx) 
length(idx)

train=iris[idx,] #학습용
test=iris[-idx,] #검정용 
dim(train)
dim(test)
\

#4)

x=matrix(1:9,nrow=3,byrow=T,)

dim(x) # 3 3

y=matrix(1:3, nrow=3)

dim(y) 
   
   # 3 1 

x;y
z=x%%Y

#행렬곱의 전제조건
1.x,y 모두 행렬
2. x(열)=y(행) 일치: 수일치 

Bug_Metrics_Software
