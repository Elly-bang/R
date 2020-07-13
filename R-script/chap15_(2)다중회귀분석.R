###################################
## 2. 다중회귀분석
###################################
# - 여러 개의 독립변수 -> 종속변수에 미치는 영향 분석
# 가설 : 음료수 제품의 적절성(x1)과 친밀도(x2)는 제품 만족도(y)에 정의 영향을 미친다.
#######################################################################################
#【다중 회귀분석 가설】
#음료수 제품의 적절성과 친밀도가 높을 수록 제품 만족도(종속변수)도 높아질 것이다.
#######################################################################################


product <- read.csv("product.csv", header=TRUE)
head(product) # 친밀도 적절성 만족도(등간척도 - 5점 척도)


#(1) 변수 선택 : 적절성 + 친밀도 -> 만족도  
y = product$'제품_만족도' # 종속변수
x1 = product$'제품_친밀도' # 독립변수1
x2 = product$'제품_적절성' # 독립변수2

df <- data.frame(x1, x2, y)

result.lm <- lm(formula=y ~ x1 + x2, data=df)
#result.lm <- lm(formula=y ~ ., data=df)                  #.,이란? y를 제외한 나머지를 x로 사용

# 계수 확인 
result.lm



#Coefficients:
#(Intercept)           x1           x2  
#0.66731               0.09593      0.68522 

b <-0.66731 
a1 <-0.09593  
a2 <-0.68522 


head(df)

x1 <-3
x2 <-4

#다중 회귀 방정식 
y=(a1*x1+a2*x2)+b
y #3.6958
Y=3
err =Y-y
abs(err) #절대값  3

#분석 결과 확인
summary(result.lm)

#해석
#1.  F-statistic: p-value: < 2.2e-16 <0.05 유의성 있다
#2. Adjusted R-squared:  0.5945 
#3. x 유의성 검정 
# x1            2.478   0.0138 *    > 친밀도 
# x2            15.684  < 2e-16 *** > 적절성

#친밀도 보다는 적절성이 더 유의미하다. 


# Coefficients:
#   Estimate                     Std.     Error        t value       Pr(>|t|)    
# (Intercept)                 0.66731    0.13094         5.096     6.65e-07 ***
#   x1                        0.09593    0.03871         2.478     0.0138 *  
#   x2                        0.68522    0.04369       15.684    < 2e-16 ***
#   ---
#   Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1


install.packages('car') #다중공선성 문제 확인 
library(car)
Prestige #직업군에 대한 평판 102개 
str(Prestige)
# 'data.frame':	102 obs. of  6 variables:
# $ education교육수준(x1): num  13.1 12.3 12.8 11.4 14.6 ...
# $ income   수입(y): int  12351 25879 9271 8865 8403 11030 8258 14163 11377 11023 ...
# $ women    여성 비율(x2): num  11.16 4.02 15.7 9.11 11.68 ...
# $ prestige 평판(x3): num  68.8 69.1 63.4 56.8 73.5 77.6 72.6 78.1 73.1 68.8 ...
# $ census   직업수 : int  1113 1130 1171 1175 2111 2113 2133 2141 2143 2153 ...
# $ type     : Factor w/ 3 levels "bc","prof","wc": 2 2 2 2 2 2 2 2 2 2 ...

row.names(Prestige)
df <- Prestige[,c(1:4)] #4개의 칼럼을 뽑아 데이터 프레임 
str(df)
lm(formula=income~.,data=df)

model <- lm(formula=income~.,data=df)
model 

summary(model)

# Coefficients:
# Estimate      Std.      Error     t value Pr(>|t|)    
# (Intercept)  -253.850   1086.157  -0.234    0.816    
# education     177.199    187.632   0.944    0.347     # 0.944 채택(-1.96~+1.96사이 채택), 유의미 하지 않다 (상관없음)
# women         -50.896      8.556  -5.948 4.19e-08 ***유의미 수준에서 영향을 미친다.(음의 상관)
# prestige     141.435     29.910   4.729 7.58e-06 *** 유의미 수준에서 영향을 미친다.(양의 상관)

res<- model$residuals #잔차(오차)=정답- 예측치
length(res) #102

mean(res) #1.704083e-14 (0에 수렴)

#MSE : 표준화 전
mse <- mean(res**2) #평균제곱 오차 
cat('MSE=',mse) #표준화 전 #6369159

#잔차 표준화 
res scale <- scale #sd=1 mean=()


#MSE : 표준화 : 잔차를 평균치 오차에적용하여 알아봄
mse <- mean(res**2) #0에 가까울수록 좋다 #평균제곱 오차 
cat('MSE=',mse) #6369159
#MSE=0.9901961 :표준화 후 

#제곱 : 부호 절대값 패널티
#평균 : 전체 오차에 대한 평균


#################################
##3. x 변수 선택 
#################################
# $ education
# $ income  
# $ women    
# $ prestige 
# $ census   
# $ type  

#변수 선택과 예측력
new_data <- Prestige [,c(1:5)]
dim(new_data) #102   5
library(MASS)
stepAIC(model2)

model2=lm(income~., data=new_data)

step <- stepAIC(model2,direction = 'both') #최적의 변수 선택을 알려준다

########################################
# step <- stepAIC(model2,direction = 'both')
# Start:  AIC=1607.93 지수가 낮으면 좋다고 본다
# income ~ education + women + prestige + census
# 
# Df Sum of Sq       RSS    AIC
# - census     1    639658 649654265 1606.0
# - education  1   5558323 654572930 1606.8
# <none>                   649014607 1607.9
# - prestige   1 143207106 792221712 1626.3
# - women      1 212639294 861653901 1634.8
# 
# Step:  AIC=1606.03
# income ~ education + women + prestige
# 
# Df Sum of Sq       RSS    AIC
# - education  1   5912400 655566665 1605.0
# <none>                   649654265 1606.0
# + census     1    639658 649014607 1607.9
# - prestige   1 148234959 797889223 1625.0
# - women      1 234562232 884216497 1635.5
# 
# Step:  AIC=1604.96 지수가 가장 낮다. 선정 
# income ~ women + prestige
# 
# Df Sum of Sq        RSS    AIC
# <none>                    655566665 1605.0
# + education  1   5912400  649654265 1606.0
# + census     1    993735  654572930 1606.8
# - women      1 234647032  890213697 1634.2
# - prestige   1 811037947 1466604612 1685.1
# > 

model3<-lm(income~women + prestige , data=new_data)
model3
summary(model3)


#Adjusted R-squared:  0.6327 
#변수의 선택 stepAIC 참조한다
#0.6327 vs 0.6327 


