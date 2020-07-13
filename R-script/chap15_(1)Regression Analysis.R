######################################################
# 회귀분석(Regression Analysis)
######################################################
# - 특정 변수(독립변수:설명변수)가 다른 변수(종속변수:반응변수)에 어떠한 영향을 미치는가 분석

###################################
## 1. 단순회귀분석 
###################################
# - 독립변수와 종속변수가 1개인 경우

# 단순선형회귀 모델 생성  
# 형식) lm(formula= y ~ x 변수, data) 

###################################################################################################################
### 【단순 회귀분석 가설】
### 음료수 제품의 당도와 가격수준을 결정하는 제품적절성(독립변수)은 제품만족도(종속변수)에 정(+)의 영향을 미칠 것이다.
###################################################################################################################
setwd("C:/ITWILL/2_Rwork/Part-iv")
product <- read.csv("product.csv", header=TRUE)
head(product) # 친밀도 적절성 만족도(등간척도 - 5점 척도)

str(product) # 'data.frame':  264 obs. of  3 variables:
y = product$'제품_만족도' # 종속변수
x = product$'제품_적절성' # 독립변수
df <- data.frame(x, y)

# 회귀모델 생성 리니어 모델 
#lm(formula=y~X,data)

result.lm <- lm(formula=y ~ x, data=df)
result.lm # 회귀계수 

# Coefficients(회귀계수):
#   (Intercept)            x  
# 0.7789(y절편)               0.7393 (x에 대한 기울기)

#회귀 방정식 (y)=a.x+b(a: 기울기, b= y절편) y=0.7393x+0.7789
head(df)
#   x y
# 1 4 3
# 2 3 2
# 3 4 4
# 4 2 2
# 5 2 2
# 6 3 3

X <-4 #입력변수 
Y <-3 #모델에 의해 만들어진 정답
a <-0.7393
b <-0.7789
y <-a*x+b

cat('y예측지=',y)

err <- y-Y

cat('model error =', err)  #mode error = 0.7361 오차가 작다는 것은 좋은 모델 


names(result.lm)
# [1] "coefficients" : 회귀 계수  "residuals" : 오차(잔차)          "effects"      
# [4] "rank"                      "fitted.values": 적합치 (예측치) "assign"       
# [7] "qr"                        "df.residual"                    "xlevels"      
# [10] "call"                     "terms"                            "model

result.lm$coefficients
# 
# (Intercept)           x 
# 0.7788583         0.7392762 
result.lm$residuals #첫번째 관측치의 오차만 본다.    -0.73596305 
result.lm$fitted.values #첫번째 관측치의 오차만 본다. 3.735963 회귀 방정식으로 나온 값과 같다. 


# 회귀모델 예측 
# y <- predict(model,x) 제품의 적절성 =x
predict(result.lm, data.frame(x=5) )
#4.475239 반환된 함수의 의미  

# (2) 선형회귀 분석 결과 보기 (가장 중요: 영향을 미치는지, 미친다면 영향력은 얼마나, 회귀 모델결과)
summary(result.lm) #요약통계+적합한 예측치를 보여준다. x->y

# <<해석 순서>>
#1. F-statistic: p-value <0.05 (유의하다)
#2. Adjusted R-squared: 0.5865 (예측력: 모델의 설명력) (%와 같다, 1에 가까울수록 좋다/ 해석 : 58%의 예측력)
#3. x의 유의성 검정 : t value (-1.96~+1.96사이 채택), p-value <0.05 
# 2번의 R-squared는 상관분석 피어슨의 제곱

cor(df) #0.7668527


#      x         y
# x 1.0000000 0.7668527
# y 0.7668527 1.0000000
r <- 0.7668527
r_squared <-r**2
r_squared  #0.5880631 #Adjusted R-squared

# Residuals:
#   Min       1Q     Median       3Q      Max 
# -1.99669 -0.25741  0.00331  0.26404  1.26404 
# 
# Coefficients:
#              Estimate Std. Error(표준오차) t value                                Pr(>|t|)    
# (Intercept)  0.77886    0.12416             6.273 (-1.96~1.96사이 채택)           1.45e-09 ***  
#   x         0.73928    0.03823              19.340                                < 2e-16 *** 0이 16개 0에 가까움. 
#   ---
#   Signif. codes:  
#   0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
# 
# Residual standard error: 0.5329 on 262 degrees of freedom
# Multiple R-squared:  0.5881,	Adjusted R-squared:  0.5865 
# F-statistic:   374 on 1 and 262 DF,  p-value: < 2.2e-16

# <<해석 순서>> F-statistic:   374 on 1 and 262 DF,  p-value: < 2.2e-16


# (3) 단순선형회귀 시각화
# x,y 산점도 그리기 
plot(formula=y ~ x, data=df, xlim=c(0.5), ylim=c(0.5))

# 회귀분석

result.lm <- lm(formula=y ~ x, data=df)

# 회귀선 (y절편 0.7789)
abline(result.lm, col='red')

result.lm$coefficients
# (Intercept)           x 
# 0.7788583         0.7392762 

y <-product$'제품_만족도'
x <-product$'제품_적절성'


# x 기울기 =Covxy / sxx
Covxy= mean((x-mean(x)) *(y-mean(y))) #x편차에 따른 제곱
sxx= mean((X-mean(x))**2)
a=Covxy/sxx
a #0.7392762 coefficients을 근거로 구해짐


#y절편 
b<- mean(y)-(a*mean(x))#절편, 기울기가 나와야 절편 
b #0.7788583



