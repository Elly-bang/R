#################################
## <제5장 연습문제>
################################# 

# 01. 다음 Bug_Metrics_Software 데이터셋을 이용하여 시각화하시오. 
library(RSADBE) # 패키지 로드  
data(Bug_Metrics_Software) # 데이터셋 로드 
str(Bug_Metrics_Software) # 데이터셋 구조보기 

?Bug_Metrics_Software

# 단계1) 소프트웨어 발표 전 버그 수를 대상으로 각 소프트웨어별 버그를
# beside형 세로막대 차트로 시각화하기(각 막대별 색상적용) 

barplot(Bug_Metrics_Software[,,1],beside =T, main = "sw발표전 버그수 대상 소프트웨어별 버그", col=rainbow(5))

# " beside =T " 출력방식 : 오른쪽으로 나른히 정렬

#범례추가 
bug=Bug_Metrics_Software[,,1]
row_names=rownames(bug)
#벡터형태로 저장 :row_names
#str(row_names)로 확인가능 

legend(x=20 ,y=14000,legend=row_names,fill=rainbow(5))

par(mfrow=c(1,5))

# 단계2) 소프트웨어 발표 후 버그 수를 대상으로 각 소프트웨어별 버그를
# 누적형 가로막대 차트로 시각화하기(각 막대별 색상적용) 
barplot(Bug_Metrics_Software[,,2],beside =F, horizon=T,col=rainbow(5))

# 02. quakes 데이터 셋을 대상으로 다음 조건에 맞게 시각화 하시오.
data(quakes) # 데이터셋 로드  
str(quakes) # 데이터셋 구조보기 

'data.frame':	1000 obs. of  5 variables:
  $ lat     : num  -20.4 -20.6 -26 -18 -20.4 ...
$ long    : num  182 181 184 182 182 ...
$ depth   : int  562 650 42 626 649 195 82 194 211 622 ...
$ mag     : num  4.8 4.2 5.4 4.1 4 4 4.8 4.4 4.7 4.3 ...
$ stations: int  41 15 43 19 11 12 43 15 35 19 ...

# 조건1) 1번 칼럼 : y축, 2번 컬럼 : x축 으로 산점도 시각화
plot(x,y)

# 조건2) 5번 컬럼으로 색상 지정
  
col=rainbow(5)


# 조건3) "지진의 진앙지 산점도 차트" 제목 추가  

title(main="지진의 진앙지 산점도 차트")
dev.off()


# 조건4) "quakes.jpg" 파일명으로 차트 저장하기
# 작업 경로 : "C:/Rwork/output"
# 파일명 : quakes.jpg
#픽셀 : 폭(720픽셀), 높이(480 픽셀)

setwd("C:/Rwork/output")
jpeg("quakes.jpg",width=720,height=480)
plot(quakes$lat,quakes$long,quakes$depth,quakes$mag,quakes$stations)
title(main="지진의 진앙지 산점도 차트")


# 03. iris3 데이터 셋을 대상으로 다음 조건에 맞게 산점도를 그리시오.

# 조건1) iris3 데이터 셋의 자료구조 확인 : 힌트) str() 
str(iris3)

# 조건2) Setosa 꽃의 종을 대상으로 x축은 "Sepal W." 칼럼, 
#        y축은 "Sepal L." 칼럼으로 산점도 그리기 

par(mfrow=c(1,1))

head(iris,10)
plot(iris$Sepal.W,iris$Sepal.L,col=iris$Species)



# 조건3) "Versicolor" 꽃의 종을 대상으로 "산점도 행렬" 시각화하기  

pairs(iris3[,,2])

table(iris$Species)
pairs(iris[iris$Species=='versicolor',1:4])
