############################################
# 추론통계분석 - 3-1. 두 집단 이상 비율차이 검정
############################################
# - 두 집단 이상 비율차이 검정

# 1. 파일가져오기 
data <- read.csv("three_sample.csv", header=TRUE)
data

# 2. 두 집단 이상 subset 작성(데이터 정제,전처리) 
method <- data$method 
survey<- data$survey
method
survey 

# 3.기술통계량(빈도분석)
table(method, useNA="ifany") # 50 50 50 -> 3그룹 모두 관찰치 50개
table(method, survey, useNA="ifany") # 그룹별 클릭수 : 1-43, 2-34, 3-37


# 4. 두 집단 이상 비율차이 검정
# prop.test(그룹별 빈도, 그룹수) -> 집단이 늘어나도 동일한 함수 사용-땡큐
prop.test(c(34,37,39), c(50,50,50)) # p-value = 0.1165 -> 귀무가설 채택
#p-value = 0.5232 >= 0.05

############################################
# 추론통계분석 - 3-2. 두 집단 이상 평균차이 검정
############################################
# 두 집단 이상 평균차이 검정 (anova)
#독립변수: 집단변수(범주형)
#종속변수: 숫자변수(연속형)

# 1. 파일 가져오기
data <- read.csv("three_sample.csv")

# 2. 데이터 정제/전처리 - NA, outline 제거
data <- subset(data, !is.na(score), c(method, score)) 
data # method, score

# (1) 차트이용 - ontlier 보기(데이터 분포 현황 분석)
plot(data$score) # 차트로 outlier 확인 : 50이상과 음수값
boxplot(data$score)$stats

#      [,1]
# [1,] 2.00
# [2,] 4.35
# [3,] 5.80
# [4,] 6.50
# [5,] 8.50


# (2) outlier 제거 - 평균(14) 이상 제거
length(data$score)#91
data2 <- subset(data, score <= 14) # 14이상 제거
length(data2$score) #88(3개 제거)

# (3) 정제된 데이터 보기 
x <- data2$score
boxplot(x)
plot(x)

# 3. 집단별 subset 작성
# method: 1:방법1, 2:방법2, 3:방법3
data2$method2[data2$method==1] <- "방법1" 
data2$method2[data2$method==2] <- "방법2"
data2$method2[data2$method==3] <- "방법3"

table(data2$method2) # 교육방법 별 빈도수 

# 4. 동질성 검정 - 정규성 검정
# bartlett.test(종속변수 ~ 독립변수) # 독립변수(세 집단)
bartlett.test(score ~ method2, data=data2) #df = 2, p-value = 0.1905 >=0.05

# 귀무가설 : 집단 간 분포의 모양이 동질적이다.
# 해설 : 유의수준 0.05보다 크기 때문에 귀무가설을 기각할 수 없다. 

# 동질한 경우 : aov() - Analysis of Variance(분산분석)
# 동질하지 않은 경우 - kruskal.test()

# 5. 분산검정(집단이 2개 이상인 경우 분산분석이라고 함)
# aov(종속변수 ~ 독립변수, data=data set)

# 귀무가설 : 집단 간 평균에 차이가 없다.
result <- aov(score ~ method2, data=data2)
result
# aov()의 결과값은 summary()함수를 사용해야 p-value 확인 

#F value F검정 통계량 중요 -> -1.96~+1.96 구간을 많이 벗어남(F value 43.58 -> P value 9.39e-14 *** 두 점수는 반비례 관계)


summary(result) 

#             Df Sum Sq  Mean Sq  F value      Pr(>F)    
#method2      2  99.37   49.68     43.58      9.39e-14 *** <-   P의 *** : value의 강도를 나타냄. 

#[해설] 매우 유의미한 수준에서 적어도 한 집단에서 평균에 차이를 보인다. 


#사후검정
TukeyHSD(result) # 분석분석의 결과로 사후검정
# 
# $method2
# 위에서 부터 가장 차이가 많음
# 세집단 모두 집단의 차이를 가진다. 모든 집단에서 유의미한 결과를 가진다. 유의미한 수준에서 집단차이를 가진다.

#                diff        lwr        upr     p adj
# 방법2-방법1  2.612903  1.9424342  3.2833723 0.0000000 <0.05
# 방법3-방법1  1.422903  0.7705979  2.0752085 0.0000040 <0.05
# 방법3-방법2 -1.190000 -1.8656509 -0.5143491 0.0001911 <0.05

plot(TukeyHSD(result))
#신뢰구간에서 0을 포함하면 집단간 차이 없음
#신뢰구간에서 0을 포함하지 않으면 집단간 차이 있음


#05.iris 데이터 셋을 이용하여 다음과 같이 분산 분석을 수행하시오.

#독립변수:Species(집단변수)
#종속변수:전제조건을 만족하는 변수 (1번 칼럼~ 4번 칼럼) 
#분산분석 해석 -> 사후 검정 해석 

str(iris)

#1)동질성 검정 : 전제조건

bartlett.test(iris$Sepal.Length,iris$Species) #p-value = 0.0003345
bartlett.test(iris$Sepal.Width,iris$Species) #p-value = 0.3515

#2. 변수 선택
x <- iris$Sepal.Width
y <- iris$Species

#3. 분산 분석
result <- aov(Sepal.Width ~ Species, data=iris)
summary(result)
#적어도 한 집단 이상에서 유의미한 차이를 가진다. 
#              Df Sum Sq Mean Sq F value Pr(>F)
# Species       2  11.35   5.672   49.16 <2e-16
# Residuals   147  16.96   0.115               
# 
# Species     ***
# Residuals 
        
#4. 사후 검정 

TukeyHSD(result)

#Tukey multiple comparisons of means
#95% family-wise confidence level

#Fit: aov(formula = Sepal.Width ~ Species, data = iris)
# 
# $Species
# diff         lwr        upr     p adj
# versicolor-setosa    -0.658 -0.81885528 -0.4971447 0.0000000
# virginica-setosa     -0.454 -0.61485528 -0.2931447 0.0000000
# virginica-versicolor  0.204  0.04314472  0.3648553 0.0087802
# 
# [해설] 95%신뢰수준에서 3집단(꽃의 종별) 모두 평균 차이 (P adj<0.05)


plot(TukeyHSD(result))



methods(plot) #시각화 가능한 그래프들 41개

# [1] plot,ANY-method     plot,color-method   plot.acf*          
#   [4] plot.data.frame*    plot.decomposed.ts* plot.default       
# [7] plot.dendrogram*    plot.density*       plot.ecdf          
# [10] plot.factor*        plot.formula*       plot.function      
# [13] plot.ggplot*        plot.gtable*        plot.hcl_palettes* 
#   [16] plot.hclust*        plot.histogram*     plot.HoltWinters*  
#   [19] plot.isoreg*        plot.lm*            plot.medpolish*    
#   [22] plot.mlm*           plot.ppr*           plot.prcomp*       
#   [25] plot.princomp*      plot.profile.nls*   plot.R6*           
#   [28] plot.raster*        plot.spec*          plot.stepfun       
# [31] plot.stl*           plot.table*         plot.trans*        
#   [34] plot.ts             plot.tskernel*      plot.TukeyHSD* 


library(dplyr) 

iris
iris$Sepal.Width = as.numeric(iris$Sepal.Width)
iris %>% group_by(Species) %>% summarise(age=mean(Sepal.Width))



#####################################################
## 2. 이원배치 분산분석
#####################################################
#종속변수 - 독립변수 1+ 독립변수2
#  - 쇼핑몰 고객의 연령대별 (20~50대), 시간대별 (오전/오후 )
#  - 독립변수 : 연령대, 시간대
#  - 종속변수 : 구매현황 

#1. dataset생성
age <- round(runif(100,min=20, max=59))
age
 #연령 20~59세까지, 100개의 원소, 반올림

time<-round(runif(100,min=0, max=1)) #오전 0 오후 1
time
 
buy <- round(runif(100,min=1, max=10)) 
#구매수량. 1개에서 최대 10개까지 구매 
buy

data <- data.frame(age, time, buy)
data

#연속형 -> 범주형 "리코딩"

data$age2 [data$age <=29] <-20
data$age2 [data$age >=30 & data$age<40] <-30
data$age2 [data$age >=40 & data$age<50] <-40
data$age2 [data$age >=50 & data$age<60] <-50

head(data)

#2. 동질성 검정

bartlett.test(buy~age2, data = data) #각각의 범주별로  종속, 독립  연령대별 구매 수량에 대한  #시간대별 
#Bartlett's K-squared = 0.66383, df = 3, p-value = 0.8817 > 0.05

bartlett.test(buy~time, data = data)

#Bartlett's K-squared = 0.081884, df = 1, p-value = 0.7748 >0.05

#3.분산분석
#귀무가설 : 집단간 차이가 없다. 
#대립가설 : 적어도 한 집단에 평균에 차이가 있다.

result<- aov(formula = buy~age2+time, data=data)
summary(result)
#              Df    Sum Sq  MeanSq    F value    Pr(>F)
# age2         1    2.4      2.361     0.359     0.550
# time         1    7.5      7.457     1.135     0.289
# Residuals   97  637.2      6.569                    

#4. 사후 검정 : 집단별 분산 차이  
TukeyHSD(result)

library(dplyr)
data %>%group_by(age)  %>%  summarise(buy_age=mean(buy))

# A tibble: 34 x 2
# age buy_age
# <dbl>   <dbl>
#   1    20    9   
# 2    21    6.5 
# 3    22    5   
# 4    23    9   
# 5    24    7.2 
# 6    25    8.17
# 7    26    6.33
# 8    27    6.6 
# 9    30    6.2 
# 10    31    5   
# # ... with 24 more rows
data %>%group_by(time)  %>%  summarise(buy_time=mean(buy))

# # A tibble: 2 x 2
# time buy_time
# <dbl>    <dbl>
#   1     0     6.16
#   2     1     6.45


