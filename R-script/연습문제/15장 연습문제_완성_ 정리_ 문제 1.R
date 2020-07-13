#15장 연습문제 정리 문제 1번 

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
