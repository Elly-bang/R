#chap06_Datahandling

#1.dplyr 패키지 

install.packages("dplyr")
library(dplyr)

library(help=dplyr)

#파이프 연산자 :%>%
#형식)df%>%func1()%>%func2()

iris%>%head()%>% filter(Sepal.Length>=5.0)
#150관측치> 6관측치>3관측치 

head(iris)
install.packages("hflights")
library(hflights)

str(hflights)

#head(iris) :앞에서 6개 불러오기
#tail(iris) :뒤에만 6개 불러오기

#2)tb1_df() 
hflights_df=hflights%>%tbl_df() #테이블 :tbl_df, tbl_df(hflights)
hflights_df

#select사용 후 filter로 자세하게 추출

#3)fillter():행 추출
#형식)df%>% filter(조건식)
names(iris)
iris %>% filter(Species=="setosa") %>% head()
iris %>% filter(Sepal.Width>3.0) %>% head()
iris_df = iris %>% filter(Sepal.Width>3)
str(iris_df)

#형식 filter(df,조건식)
filter(iris,Sepal.Width>3)
filter(hflights_df,Month==1 &  DayofMonth==1)
filter(hflights_df,Month==1 |  Month==2)

#4)arrange() : 정렬 함수
#형식)df %>% arrage(칼럼명) :오름차순
iris %>% arrange(Sepal.Width) %>% head() #오름차순기본 
iris %>% arrange(desc(Sepal.Width)) %>% head() #내림차순기본

#형식)arrange(df,칼럼명) : 월(1~12월까지 오름차순)>도착시간 오름차순
arrange(hflights_df,Month,ArrTime) #오름차순

arrange(hflights_df,desc(Month),ArrTime) #Month내림차순

#5)select():열 추출 
#형식)df %>% select()
names(iris)
iris %>% select(Sepal.Length,Petal.Length,Species)%>%head()

#형식)select(df,col1,col2,.......)
select(hflights_df,DepTime,ArrTime, TailNum, AirTime)
hflights_df

#연습문제 select후 filter사용 
v=select(hflights_df,DepTime,ArrTime, TailNum, AirTime)
v%>%filter(DepTime>1350)%>% head()

select(hflights_df,Year:DayOfWeek) #: -> 이어서 사용

#문)Month 기준으로 내림차순 정렬, Year, Month, AirTime 칼럼선택
select(arrange(hflights_df, desc(Month)), Year, Month, AirTime)
         
#6)mutate() :파생변수 생성
  #형식)df %>% mutate (변수=함수 or수식)
iris %>% mutate(diff=Sepal.Length-Sepal.Width) %>% head()

#형식)mutate(df,변수=함수 or 수식)
select(mutate(hflights_df,diff_delay=ArrDelay-DepDelay),ArrDelay, DepDelay, diff_delay) #출발지연-도착지연
         
#7)summarise() :통계 구하기 
#형식) df %>% summarise(변수 =통계함수())

iris %>% summarise(col1_avg=mean(Sepal.Length),
                   col2_sd=sd(Sepal.Width))

#col1_avg   col2_sd
#1 5.843333 0.4358663

#형식)summarise(df,변수=통계함수())
summarise(hflights_df,delay=mean(DepDelay,na.rm = T),
          delay_tot=sum(DepDelay,na.rm = T))

select(hflights_df,DepDelay)


#출발지연시간 평균/합계
delay_avg delay_tot

# delay delay_tot
# <dbl>     <int>
#   1  9.44   2121251

