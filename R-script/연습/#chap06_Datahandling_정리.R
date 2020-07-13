#chap06_Datahandling

#1.dplyr패키지 

install.packages("dplyr")
library(dplyr)

library(help="dplyr")

#파이프 연산자 %>%
#형식_ df %>% function1() %>% func2()

iris %>% head() %>% filter(Sepal.Length>=5.0) #iris 6개 중에서  Sepal.Length이 5이상
iris %>% filter(Sepal.Length>=5.0) %>% head() #iris Sepal.Length이 5이상 중 6개까지

iris %>% head() %>% filter(Sepal.Length>=5.0)
#150관측치> 6관측치> 5이상 3개
iris %>% filter(Sepal.Length>=5.0) %>% head()
#150관측치> 128관측치> 5이상 6개
iris %>% filter(Sepal.Length>=5.0) #128개

head(iris)
install.packages("hflights")

# hflights데이터란?
# 2011년도 미국 휴스턴에서 출발하는 모든 비행기의 
# 이착륙기록이 수록된 것. 
# 227,496건의 이착륙기록에 대해 21개 항목으로 수집

library(hflights)
str(hflights)

#head(hflights): hflights데이터에서 앞에서 6개만 불러오기 
#tail(hflights): hflights데이터에서 뒤에서 6개만 불러오기 

#2)tbl_df()
hflights_df=hflights %>% tbl_df() #tbl_df()=tbl_df(hflights)
hflights_df

#select사용후 filter로 자세하게 추출

#3)filter():행 추출
#형식)df %>% filter(조건식)
names(iris)
#iris에서 Species중 setosa인것만 앞에서 6개까지 불러오기 
iris %>% filter(Species=="setosa") %>% head()
#iris에서 Sepal.Width중 3이상만 앞에서 6개까지 불러오기 
iris %>% filter(Sepal.Width>3.0) %>% head()

#같은 결과값에 대한 filter추출 
iris %>% filter(Sepal.Width>3) #조건을 만족하는 67행이 나열식으로-> 보기 불편

iris_df=iris %>% filter(Sepal.Width>3) #iris_df로 지정하여 구조를 보는것 
str(iris_df)


#형식 filter(df,조건식)
filter(iris,Sepal.Width>3) #67행이 나열식으로 보여짐
filter(hflights_df, Month==1 & DayofMonth==1) #1월 1일의 데이터 보여주기 
filter(hflights_df, Month==1 | Month==2) #1월과  2월의데이터 보여주기 

#4)arrange():정렬함수 
#형식) df %>% arrange (칼럼명):오름차순
iris %>% arrange(Sepal.Width) %>% head() #오름차순기본
iris %>% arrange(desc(Sepal.Width)) %>% head() # Sepal.Width를내림차순으로 6개까지 

#5)select() :열추출
#형식)df %>% select()

iris %>% select(Sepal.Length,Petal.Length,Species) %>% head()

#str(iris_df)와 str(iris)은 다릅니다. 위에서 iris_df는 Sepal.Width값이 3이상인 것으로
#filter조건식을 선언해준것으로 67행이며, iris는 150행 전체를 말합니다. 

#형식)select(df,cool1,col2...) 필요한 컬럼을 불러오는 방법
select(hflights_df,DepTime,ArrTime,TailNum,AirTime)
hflights_df

#연습문제 select후 filter사용 
v=select(hflights_df,DepTime,ArrTime, TailNum, AirTime)
v%>%filter(DepTime>1350)%>% head()

select(hflights_df,Year:DayOfWeek) #:전체 칼럼을 다 지정

#문)Month기준으로 내림차순 정렬, Year,Month,AirTime칼럼선택
#select(hflights_df,Year, Month, AirTime) #오름차순
#내림차순으로 정렬 -> 배열다시 arrange사용한다. 
#hflights_df를 내림차순으로 배열하기 
#select(arrange(hflights_df,desc(Month))
select(arrange(hflights_df,desc(Month)),Year, Month,AirTime) 

#6)mutate():파생변수생성
#형식)df %>% mutate (변수=함수 or수식)
#diff라는 컬럼생성하고 싶을때 그 수식과 함께 연결사용
iris %>% mutate(diff=Sepal.Length-Sepal.Width) %>% head()

#형식)mutate(df,변수=함수or수식)

#hflights_df에서 diff_delay컬럼을 생성하여,ArrDelay,DepDelay,diff_delay 세가지 항목을 보여주기
select(mutate(hflights_df,diff_delay=ArrDelay-DepDelay),ArrDelay,DepDelay,diff_delay)
#hflights_df에서 diff_delay컬럼을 생성하여, 보여주기 
select(mutate(hflights_df,diff_delay=ArrDelay-DepDelay),diff_delay)

#7)summarise():통계구하기
#형식)df %>% summarise(변수=통계함수()) 일시적인 변수 mutate의 변수와 뜻과 의미가 다릅니다. 

iris %>% summarise(col1_avg=mean(Sepal.Length),
                   col2_sd=sd(Sepal.Width))

#형식)summarise(df,변수=통계함수())
summarise(hflights_df,delay=mean(DepDelay,na.rm = T),
          delay_tot=sum(DepDelay,na.rm = T))

select(hflights_df,DepDelay)


#출발지연시간 평균/합계
#delay_avg/ delay_tot

# delay delay_tot
# <dbl>     <int>
#   1  9.44   2121251

#8) group_by (dataset,집단변수)
#형식)df %>% group_by(집단변수)
names(iris)
table(iris$Species)
grp <- iris %>% group_by(Species)
grp

summarise(grp,mean(Sepal.Length))
# Species    `mean(Sepal.Length)`
# <fct>                     <dbl>
#  1 setosa                 5.01
# 2 versicolor              5.94
# 3 virginica               6.59

summarise(grp,sd(Sepal.Length))

#group_by() [실습]
install.packages("ggplot2")
library(ggplot2)

data("mtcars") #자동차 연비 
head(mtcars)
str(mtcars)
table(mtcars$cyl) # 4  6  8 
table(mtcars$gear) # 3  4  5 

#group :cyl
grp=group_by(mtcars,cyl) 
grp

#각집단별 연비 평균/표준 편차
summarise(grp,mpg_avg=mean(mpg),mpg_sd=sd(mpg))
# 
# cyl mpg_avg mpg_sd
# <dbl>   <dbl>  <dbl>
# 1     4    26.7   4.51
# 2     6    19.7   1.45
# 3     8    15.1   2.56

#각 gear집단별 무게(wt)평균/표준편차 
grp=group_by(mtcars,gear)
grp

summarise(grp,wt_avg=mean(wt),wt_sd=sd(wt))
# cyl wt_avg wt_sd
# <dbl>  <dbl> <dbl>
# 1     4   2.29 0.570
# 2     6   3.12 0.356
# 3     8   4.00 0.759

#두 집단변수 -> 그룹화 

grp2=group_by(mtcars,cyl,gear) 
grp2

summarise(grp2,mpg_avg=mean(mpg),mpg_sd=sd(mpg))

#형식)group_by(dataset,집단변수)

#예제)각 항공기별 비행편수가 40편 이상이고, 
#평균 비행거리가 2000마일 이상인 경우
#평균 도착지연시간을 확인하시오.

#1)항공기별 그룹화 
str(hflights_df)
planes=group_by(hflights_df,TailNum) #항공기 일련번호 
planes # Groups:   TailNum [3,320]

#2)항공기별 요약 통계 :비행편수,평균 비행거리, 평균 도착 지연시간

planes_state=summarise(planes,count=n(),
                       Dist_avg=mean(Distance,na.rm=T),
                       delay_avg=mean(ArrDelay,na.rm = T))
planes_state

#3)항공기별 요약 통계 : 비행편수, 평균 비행거리, 
filter(planes_state,state,count>=40, Dist_avg>=2000)

#2.reshape2
install.packages("reshape2")
library(reshape2)

#1)dcast() : long-> wide  #모양을 바꿔준다

read.csv(file.choose()) #Part-II/data.csv

data =read.csv(file.choose())
data

# data 구매일자 col
# ID 고객 구분자 row
# Buy 구매수량 sum 

names(data)

#형식)dcast(dataset, row~col, func)
wide=dcast(data,Customer_ID~Date,sum)
wide
wide <- dcast(data, Customer_ID ~ Date, sum)
wide

library(ggplot2)
data(mpg)
str(mpg)

#표로 보기 
mpg
mpg_df=as.data.frame(mpg)
str(mpg_df)

mpg_df=select(mpg_df,c(cyl,drv,hwy))
head(mpg_df)

#교차셀에 hwy합계 ?? 
tab=dcast(mpg,cyl~drv,sum)
tab=dcast(mpg_df,cyl~drv,sum)
tab

#교차셀에 hwy출현건수 
tab2= dcast(mpg_df,cyl~drv,length)
tab2

#교차분할표 
#table(행집단변수, 열집단변수)
table(mpg_df$cyl~drv,mpg_df$drv)

unique(mpg_df$cyl) # 4 6 8 5
unique(mpg_df$drv) # "f" "4" "r"
library(dplyr)

#2)melt() : wide-> long
wide
long = melt(wide,id="Customer_ID")
long

#customer_ID 기준칼럼
#variable 열이름
#value 교차셀의 값

names(long)=c("user_ID","Date","Buy")
long

library(reshape2)

#example
data("smiths")
smiths

#wide->long
long=melt(smiths, id='subject')
long

long2=melt(smiths, id=1:2)
long2

#long -> wide
wide =dcast(long,subject ~...) #나머지 칼럼
wide

# 3. acast(datasete, 행~열~면)
data("airquality")
str(airquality)

table(airquality$Month)
# 5  6  7  8  9 
# 31 30 31 31 30 

table(airquality$Day)
dim(airquality)


#wide-> long()
air_melt=melt(airquality, id=c("Month","Day"),na.rm = T)
air_melt
dim(air_melt)
table(air_melt$variable)

#[일,월,variable] ->[행, 열, 면]
#acast(dataset, Day~Month~variable)
air_arr3d=acast(air_melt,Day~Month~variable)
dim(air_arr3d) #31  5  4

#오존 data
air_arr3d[,,1]

#태양열data
air_arr3d[,,2]

########추가내용##############
#4.URL만들기:http://www.naver.com?name='홍길동'

baseUrl = "http://www.sbus.or.kr/2018/lost/lost_02.htm"

#2) page query 추가 

# "http://www.sbus.or.kr/2018/lost/lost_02.htm"?page=1

no <- 1:5

library(stringr)
page = str_c('?Page=',no)
page # "?Page=1" "?Page=2" "?Page=3" "?Page=4" "?Page=5"

#페이지 쿼리 생성 : 기존 베이스와 페이지 쿼리 

#outer(x(1),Y(n),func)
page_url=outer(baseUrl,page, str_c)
page_url
dim(page_url) #1 5

#reshape : 2d -> 1d
page_url=sort(as.vector(page_url))
page_url

#3)sear query 추가 
#http://www.sbus.or.kr/2018/lost/lost_02.htm?Page=1&sear=2
no=1:3 #(1:물품선택, 2:지갑, 3:신분증)
sear=str_c("&sear=",no)
sear #"&sear=1" "&sear=2" "&sear=3" 

final_Url = outer(page_url,sear,str_c) #matrix
final_Url 

as.vector(final_Url)


