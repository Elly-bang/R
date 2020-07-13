chap05_DataVisualization 

# 차트 데이터 생성
chart_data <- c(305,450, 320, 460, 330, 480, 380, 520) 
names(chart_data) <- c("2016 1분기","2017 1분기","2016 2분기","2017 2분기","2016 3분기","2017 3분기","2016 4분기","2017 4분기")
str(chart_data)
chart_data #520

# 1. 이산변수 시각화
# -정수단위로 나누어지는 수 (자녀수, 판매수)
# 
# (1) 막대차트
?barplot #속성알아보기 
#세로막대차트
barplot(chart_data,ylim=c(0,600),
       main="2016년 vs 2017년 판매현황",
       col=rainbow(8)) #막대차트 만들기
#가로막대차트
barplot(chart_data,xlim=c(0,520),
        horiz = TRUE,
        main="2016년 vs 2017년 판매현황",
        col=rainbow(8)) 

#1행 2열구조
par(mfrow=c(1,2)) 
VADeaths
str(VADeaths)

row_names=row.names(VADeaths)
row_names
row
col_names=colnames(VADeaths)
col_names

max(VADeaths) #71.1

#beside=FALSE horiz=FALSE
barplot(VADeaths,beside = FALSE,
        horiz = FALSE,
        main = "버지니아 사망비율",
        col=rainbow(4))

barplot(VADeaths,beside = TRUE,
        horiz = FALSE,
        main = "버지니아 사망비율",
        col=rainbow(4))
      
#beside=TRUE  horiz=TRUE 
barplot(VADeaths,beside = TRUE ,
        horiz = TRUE ,
        main = "버지니아 사망비율",
        col=rainbow(4))

par(mflow=c(2,2))

#범례추가legend.text = NULL
legend(x=4,y=200,legend = row_names,fill=rainbow(5))

par(mfrow=c(1,1)) #그래프 하나만 보이는 선언

#(2)점차트 
dotchart(chart_data, 
         color=c("green","red"), 
         lcolor="black",
         pch=2:2, #포인터 모양:동그라미1, 세모2
         labels=names(chart_data), 
         xlab="매출액",
         main="분기별 판매현황 점 차트 시각화", 
         cex=1.2) #레이블 확대축소 1이상 확대개념, 1이하는 축소개념

#(3)파이 차트 시각화
pie(chart_data, 
    labels = names(chart_data),
    border='blue', 
    col=rainbow(8), 
    cex=1.2)

#차트에 제목 추가 
title("2014~2015년도 분기별 매출현황")

table(iris$Species)
pie(table(iris$Species),
    col = rainbow(3),
    main = "iris꽃의 종 빈도수")

#2. 연속변수 시각화
# -시간, 길이 등의 연속성을 갖는 변수 
# 1) 상자 그래프 시각화

summary(VADeaths) #요약통계량
boxplot(VADeaths)
range(VADeaths[,1])
mean(VADeaths[,1])

#사분위수 
quantile(VADeaths[,1])

# 0%   25%  50%  75% 100% 
# 11.7 18.1 26.9 41.0 66.0 

range(iris$Sepal.width) 

# 2)히스토그램 시각화 : 대칭성확인 

par(mfrow=c(1,2))

hist(iris$Sepal.Width, xlab="iris$Sepal.Width", col="mistyrose",main="iris 꽃받침 넓이 histogram", 
     xlim=c(2.0, 4.5))
lines(density(iris$Sepal.Width),col="red")


hist(iris$Sepal.Width, xlab="iris$Sepal.Width",col="green",main="iris 꽃받침 넓이 histogram", 
     xlim=c(2.0, 4.5))

# 확률 밀도로 히스토그램 그리기 - 연속형변수의 확률
 
hist(iris$Sepal.Width, 
     xlab="iris$Sepal.Width",
     col="mistyrose",
     freq = T,
     main="iris 꽃받침 넓이 histogram", 
     xlim=c(2.0, 4.5))

lines(density(iris$Sepal.Width),col="red")

###################################################################################################

hist(iris$Sepal.Width, 
     xlab="iris$Sepal.Width",col="mistyrose",freq = F,main="iris 꽃받침 넓이 histogram", 
     xlim=c(2.0, 4.5))


par(mfrow=c(1,1))

#밀도분포 곡선
lines(density(iris$Sepal.Width),col="red")
###################################################################################################

#정규분포 
n=10000
x=rnorm(n,mean=0,sd=1)
hist(x,freq=F)
lines(density(x),col="red")

par(mfrow=c(1,2))

#3)산점도 시각화
x=runif(n=15, min=1, max=100)
#원소가 하나일때는 나머지 주소가 인덱스
plot(x) #x=>y, index=>x
y=runif(n=15, min =5, max=120)
plot(y)

#x,y
plot(x,y)
plot(x,y) #(y~x)

#col속성
par(mfrow=c(1,1))

head(iris,10)
plot(iris$Sepal.Length,iris$Petal.Length,col=iris$Species)

price<- runif(10, min=1, max=100)


par(mfrow=c(2,2)) # 2행 2열 차트 그리기
price <-rnorm(10)  

plot(price, type="l") # 유형 : 실선 
plot(price, type="o") # 유형 : 원형과 실선(원형 통과) 
plot(price, type="h") # 직선 
plot(price, type="s") # 꺾은선


# plot() 함수 속성 : pch : 연결점 문자타입-> plotting characher-번호(1~30) 

plot(price, type="o", pch=5) # 빈 사각형 
plot(price, type="o", pch=15)# 채워진 마름모 
plot(price, type="o", pch=20, col="blue") #color 지정 
plot(price, type="o", pch=20, col="orange", cex=1.5) #character expension(확대) 
plot(price, type="o", pch=20, col="green", cex=2.0, lwd=3) #lwd : line width

#만능차트
methods(plot)

#plot.ts :시계열자료 
WWWusage
plot(WWWusage) #추세선

#plot.lm"회귀모델
install.packages("UsingR")
library(UsingR)
library(help="UsingR")

data(galton)
str(galton)
#유전학자 갈톤: 회귀 용어 제안 
model=lm(child~parent,data = galton) 
plot(model)

#4)산점도 행렬: 변수 간의 비교
pairs(iris[-5])

# 꽃의 종별 산점도 행렬
table(iris$Species)
pairs(iris[iris$Species=='setosa',1:4])
pairs(iris[iris$Species=='versicolor',1:4])
pairs(iris[iris$Species=='virginica',1:4])

#5)차트 파일 저장
setwd("C:/ITWILL/2_Rwork/output") # 폴더 지정 
jpeg("iris.jpg", width=720, height=480) # 픽셀 지정 가능 
plot(iris$Sepal.Length, iris$Petal.Length, col=iris$Species) 
title(main="iris 데이터 테이블 산포도 차트") 

dev.off() # 장치 종

#########################
### 3차원 산점도 ########  
#########################
install.packages('scatterplot3d')
library(scatterplot3d)

# 꽃의 종류별 분류 
iris_setosa = iris[iris$Species == 'setosa',]
iris_versicolor = iris[iris$Species == 'versicolor',]
iris_virginica = iris[iris$Species == 'virginica',]

# scatterplot3d(밑변, 오른쪽변, 왼쪽변, type='n') # type='n' : 기본 산점도 제외 
d3 <- scatterplot3d(iris$Petal.Length, iris$Sepal.Length, iris$Sepal.Width, type='n')

d3$points3d(iris_setosa$Petal.Length, iris_setosa$Sepal.Length,
            iris_setosa$Sepal.Width, bg='orange', pch=21)

d3$points3d(iris_versicolor$Petal.Length, iris_versicolor$Sepal.Length,
            iris_versicolor$Sepal.Width, bg='blue', pch=23)

d3$points3d(iris_virginica$Petal.Length, iris_virginica$Sepal.Length,
            iris_virginica$Sepal.Width, bg='green', pch=25)
