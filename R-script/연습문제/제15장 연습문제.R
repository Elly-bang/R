#################################
## <제15장 연습문제>
################################# 

###################################
## 선형 회귀분석 연습문제 
###################################

# 01. ggplot2패키지에서 제공하는 diamonds 데이터 셋을 대상으로 
# carat, table, depth 변수 중 다이아몬드의 가격(price)에 영향을 
# 미치는 관계를 다음과 같은 단계로 다중회귀분석을 수행하시오.

library(ggplot2)
data(diamonds)

#변수 선택  : carat, table, depth 
cols <- names(diamonds)
cols
dia_data<-diamonds[c(cols[1],cols[5:7])]

##############################################################
y=diamonds$price 
x1=diamonds$carat 
x2=diamonds$table
x3=diamonds$depth 
df<-data.frame(x1,x2,x3,y)
result.lm<-lm(formula(y~x1+x2+x3, data=df))
result.lm
################################################################
# 단계1 : 다이아몬드 가격 결정에 가장 큰 영향을 미치는 변수는?
################################################################
# Coefficients:
#   (Intercept)           x1           x2           x3  
#        13003.4       7858.8       -104.5       -151.2 
#################################################################
b <-13003.4 
a1 <-7858.8  
a2 <-104.5  
a3 <-151.2 

head(df)


#변수선택 : carat, depth, table, price
cols <-names(diamonds)
cols
dia_data <-diamonds[c(cols[1], cols[5:7])]

dia_model <- lm(price~., data=dia_data)
dia_model$coefficients




# 단계2 : 다중회귀 분석 결과를 정(+)과 부(-) 관계로 해설

x1 <-3
x2 <-4


y=(a1*x1+a2*x2)+b
y  #36997.8
Y=3
err=Y-y
err
abs(err) #절대값36994.8

summary(result.lm)

#해석
#1. F-statistic: 1.049e+05 
#2. F-statistic: 1.049e+05 
#3. 가격에 영향을 미치는 것은 carrot이 가장 유의미하다. 
# Coefficients:
#   Estimate Std. Error t value Pr(>|t|)    
# (Intercept) 13003.441    390.918   33.26   <2e-16 ***
#   x1           7858.771     14.151  555.36   <2e-16 *** #carrot
#   x2           -104.473      3.141  -33.26   <2e-16 *** #table
#   x3           -151.236      4.820  -31.38   <2e-16 *** #depth



# 02. mtcars 데이터셋을 이용하여 다음과 같은 단계로 다중회귀분석을 수행하시오.

library(datasets)
str(mtcars) # 연비 효율 data set 

y=mtcars$mpg
x1=mtcars$hp
x2=mtcars$wt

df<-data.frame(x1,x2,y)
head(df)

result.lm<-lm(formula=y~x1+x2,data=df)
result.lm


b<-37.22727 
a1<- 0.03177  
a2<- 3.87783 

head(df)

# 단계1 : 연비(mpg)는 마력(hp), 무게(wt) 변수와 어떤 상관관계를 갖는가? 
cor(df)
#hp= -0.7761684
#wt= -0.8676594
# 단계2 : 마력(hp)과 무게(wt)는 연비(mpg)에 어떤 영향을 미치는가? 

cars_model<- lm(formula=y ~ ., data=df)    
summary(cars_model)
#음의 상관관계 
#0.00000112


# 단계3 : hp = 90, wt = 2.5t일 때 회귀모델의 예측치는? hp = 90, wt = 2.5t일 때의 연비 예측은? 24.67
x_data <- data.frame(hp=90,wt2.5) 
#predict(model,x)



x1 <-3
x2 <-4
  
y=(a1*x1+a2*x2)+b
y #-0.03177 
Y=3
err=Y-y  
abs(err)   #49.8339
summary(result.lm)
#F-statistic: 69.21 on 2 and 29 DF,  p-value: 9.109e-12 <0.05
#Adjusted R-squared:  0.8148 
#1. 연비와 무게가 마력보다 유의성이 높다. 
#2. 정의 상관관계를 가진다

x1<-90
x2<-2.5
y=(a1*x1+a2*x2)+b
y #49.78114
Y=3
err=Y-y  
abs(err)   #46.78114
summary(result.lm)
#3. 결과 : 무게의 
# F-statistic: 69.21 on 2 and 29 DF,  p-value: 9.109e-12
# Coefficients:
#   Estimate Std. Error t value Pr(>|t|)    
# (Intercept) 37.22727    1.59879  23.285  < 2e-16 ***
#   x1          -0.03177    0.00903  -3.519  0.00145 **  마력 
#   x2          -3.87783    0.63273  -6.129 1.12e-06 *** 무게

################################################################################################################## 
# 03. product.csv 파일의 데이터를 이용하여 다음과 같은 단계로 다중회귀분석을 수행하시오.(다중공선성)
setwd("C:/ITWILL/2_Rwork/Part-IV")
product <- read.csv("product.csv", header=TRUE)

#  단계1 : 학습데이터(train),검정데이터(test)를 7 : 3 비율로 샘플링
nrow(product) #264
x <- sample(1*nrow(product), 0.7*nrow(product),replace=F)#한번꺼낸것은 꺼내지 않음
train <- product[x, ]
test <- product[ ,x]
dim(train) # 0 3
dim(test) # 264 0


idx <- sample(1*nrow(product), 0.7*nrow(product),replace=F)
idx
train <- product[idx, ]
test <- product[ ,idx]


#  단계2 : 학습데이터 이용 회귀모델 생성 
#        변수 모델링) y변수 : 제품_만족도, x변수 : 제품_적절성, 제품_친밀도

y<- product$"제품_만족도"
x1 <-product$"제품_적절성"
x2 <- product$"제품_친밀도" 

df<-data.frame()

df

result.lm <- lm(formula =y~x1+x2,data=train)
result.lm 



model <- lm(formula =y~x1+x2,data=train)

# Coefficients:
#   (Intercept)           x1           x2  
#         0.66731      0.68522      0.09593  


#  단계3 : 검정데이터 이용 모델 예측치 생성 


product_model <- lm(formula ="제품_만족도"~"제품_적절성"+"제품_친밀도" ,data=train )

summary(product_model)

#  단계4 : 모델 평가 : MSE, cor()함수 이용  
y_pred <- predict(model,test)
y_pred
length(y_pred)
y_true<-product$제품_친밀도
Error<- y_true - y_pred
mse <-mean(Error**2)
cat('MSE=', mse)

##########################################

y_pred <- predict(model,test)
y_true<-test$제품_친밀도

Error<- y_true - y_pred
mse <- mean(Error**2)
cat('MSE=',mse) #MSE=0.09154192

수정 !! 


###################################
## 로지스틱 회귀분석 연습문제 
###################################
# 04.  admit 객체를 대상으로 다음과 같이 로지스틱 회귀분석을 수행하시오.
# <조건1> 변수 모델링 : y변수 : admit, x변수 : gre, gpa, rank 
# <조건2> 7:3비율로 데이터셋을 구성하여 모델과 예측치 생성 
# <조건3> 분류 정확도 구하기 

# 파일 불러오기
admit <- read.csv('admit.csv')
str(admit) # 'data.frame':	400 obs. of  4 variables:
#$ admit: 입학여부 - int  0 1 1 1 0 1 1 0 1 0 ...
#$ gre  : 시험점수 - int  380 660 800 640 520 760 560 400 540 700 ...
#$ gpa  : 시험점수 - num  3.61 3.67 4 3.19 2.93 3 2.98 3.08 3.39 3.92 ...
#$ rank : 학교등급 - int  3 3 1 4 4 2 1 2 3 2 ...

# 1. data set 구성 
idx <- sample(1:nrow(admit), nrow(admit)*0.7)
train_admit <- admit[idx, ]
test_admin <- admit[-idx, ]

# 2. model 생성 

# 3. predict 생성 

# 4. 모델 평가(분류정확도) : 혼돈 matrix 이용/ROC Curve 이용
