###############################################
# 15_2. 로지스틱 회귀분석(Logistic Regression) 
###############################################

# 목적 : 일반 회귀분석과 동일하게 종속변수와 독립변수 간의 관계를 나타내어 
# 향후 예측 모델을 생성하는데 있다.

# 차이점 : 종속변수가 범주형 데이터를 대상으로 하며 입력 데이터가 주어졌을 때
# 해당 데이터의결과가 특정 분류로 나눠지기 때문에 분류분석 방법으로 분류된다.
# 유형 : 이항형(종속변수가 2개 범주-Yes/No), 다항형(종속변수가 3개 이상 범주-iris 꽃 종류)
# 다항형 로지스틱 회귀분석 : nnet, rpart 패키지 이용 
# a : 0.6,  b:0.3,  c:0.1 -> a 분류 

# 분야 : 의료, 통신, 기타 데이터마이닝

# 선형회귀분석 vs 로지스틱 회귀분석 
# 1. 로지스틱 회귀분석 결과는 0과 1로 나타난다.(이항형)
# 2. 정규분포 대신에 이항분포를 따른다.
# 3. 로직스틱 모형 적용 : 변수[-무한대, +무한대] -> 변수[0,1]사이에 있도록 하는 모형 
#    -> 로짓변환 : 출력범위를 [0,1]로 조정
# 4. 종속변수가 2개 이상인 경우 더미변수(dummy variable)로 변환하여 0과 1를 갖도록한다.
#    예) 혈액형 AB인 경우 -> [1,0,0,0] AB(1) -> A,B,O(0)


# 단계1. 데이터 가져오기
weather = read.csv("C:/ITWILL/2_Rwork/Part-IV/weather.csv", stringsAsFactors = F) #factor형 아닌 문자형
dim(weather)  # 366  15
head(weather)
str(weather)

# chr 칼럼, Date, RainToday 칼럼 제거 
weather_df <- weather[, c(-1, -6, -8, -14)]
str(weather_df)

# RainTomorrow 칼럼 -> 로지스틱 회귀분석 결과(0,1)에 맞게 더미변수 생성      
weather_df$RainTomorrow[weather_df$RainTomorrow=='Yes'] <- 1
weather_df$RainTomorrow[weather_df$RainTomorrow=='No'] <- 0
weather_df$RainTomorrow <- as.numeric(weather_df$RainTomorrow)
head(weather_df)
table(weather_df$RainTomorrow)

# No Yes 
# 300  66 
prop.table(table(weather_df$RainTomorrow))

# No       Yes 
# 0.8196721 0.1803279 

#  단계2.  데이터 셈플링
idx <- sample(1:nrow(weather_df), nrow(weather_df)*0.7)
train <- weather_df[idx, ]
test <- weather_df[-idx, ]

#  단계3. 로지스틱  회귀모델 생성 : 학습데이터 
weater_model <- glm(RainTomorrow ~ ., data = train, family='binomial')
weater_model 

# Coefficients:
#   (Intercept)        MinTemp        MaxTemp       Rainfall  
# 107.37396       -0.14705        0.21508        0.01214  
# Sunshine  WindGustSpeed      WindSpeed       Humidity  
# -0.21173        0.08448       -0.07016        0.05360  
# Pressure          Cloud           Temp  
# -0.11382        0.11281       -0.02972  

summary(weater_model) 


# Call:
#   glm(formula = RainTomorrow ~ ., family = "binomial", data = train)
# 
# Deviance Residuals: 
#   Min       1Q   Median       3Q      Max  
# -1.8356  -0.4704  -0.2721  -0.1579   2.3856  
# 
# Coefficients:
#   Estimate Std. Error z value Pr(>|z|)   
# (Intercept)   107.37396   46.56185   2.306  0.02111 * 
#   MinTemp        -0.14705    0.07693  -1.912  0.05593 . 
# MaxTemp         0.21508    0.20731   1.037  0.29951   
# Rainfall        0.01214    0.04151   0.292  0.76992   
# Sunshine       -0.21173    0.11200  -1.891  0.05868 . 
# WindGustSpeed   0.08448    0.02828   2.987  0.00282 **
#   WindSpeed      -0.07016    0.04049  -1.733  0.08311 . 
# Humidity        0.05360    0.02864   1.871  0.06131 . 
# Pressure       -0.11382    0.04501  -2.529  0.01144 * 
#   Cloud           0.11281    0.11888   0.949  0.34267   
# Temp           -0.02972    0.22295  -0.133  0.89396   
# ---
#   Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
# 
# (Dispersion parameter for binomial family taken to be 1)
# 
# Null deviance: 223.48  on 250  degrees of freedom
# Residual deviance: 147.91  on 240  degrees of freedom
# (5 observations deleted due to missingness)
# AIC: 169.91
# 
# Number of Fisher Scoring iterations: 6


# 단계4. 로지스틱  회귀모델 예측치 생성 : 검정데이터 
# newdata=test : 새로운 데이터 셋, type="response" : 0~1 확률값으로 예측 
pred <- predict(weater_model, newdata=test, type="response")  #y가 나오는 확률값으로 예측
pred 
range(pred, na.rm=T) #0.002052574   0.994663959
summary(pred)
# Min.  1st Qu.   Median     Mean  3rd Qu.     Max. 
# 0.007581 0.030323 0.077119 0.206927 0.241922 0.996808 
str(pred)
# Named num [1:110] 0.9968 0.0707 0.0531 0.0235 0.3566 ...
# - attr(*, "names")= chr [1:110] "3" "8" "12" "13" ...

#cut off =0.5
cpred <- ifelse(pred>=0.5,1,0)
table(cpred)
cpred
# 0 1
# 98 10  => 108은 366개의 30%정도 

y_true <- test$RainTomorrow

#교차 분할표
table(y_true, cpred)
#cpred
# y_true 0  1    0: 오지 않음 1: 옴
#    0  83  3   86개 
#    1  15  7   22개
length(test) #11
#정분류 83+7   / length(test) 
acc<-(83,7) /nrow(test)
nrow(test) #110

acc<-90/110
acc

acc<-(83,7)/nrow(test)
cat('accuracy=', acc)
#accuracy= 0.8181818 약 82%확률

no<-83/(83+3)
no #0.9651163

yes <- 7/(15+7)
yes #0.3181818

#오분류 15+3

### ROC Curve를 이용한 모형평가(분류정확도)  ####
# Receiver Operating Characteristic

install.packages("ROCR")
library(ROCR)

# ROCR 패키지 제공 함수 : prediction() -> performance
pr <- prediction(pred, test$RainTomorrow)
prf <- performance(pr, measure = "tpr", x.measure = "fpr")
plot(prf)