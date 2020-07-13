###################################
# 4. 다중공선성(Multicolinearity)
###################################
# - 독립변수 간의 강한 상관관계로 인해서 회귀분석의 결과를 신뢰할 수 없는 현상
# - 생년월일과 나이를 독립변수로 갖는 경우
# - 해결방안 : 강한 상관관계를 갖는 독립변수 제거

# (1) 다중공선성 문제 확인
library(car)
fit <- lm(formula=Sepal.Length ~ Sepal.Width+Petal.Length+Petal.Width, data=iris)
vif(fit)

# Sepal.Width Petal.Length  Petal.Width 
# 1.270815    15.097572    14.234335 

sqrt(vif(fit))>2 # root(VIF)가 2 이상인 것은 다중공선성 문제 의심 
# Sepal.Width Petal.Length  Petal.Width 
# FALSE         TRUE         TRUE 


# (2) iris 변수 간의 상관계수 구하기
cor(iris[,-5]) # 변수간의 상관계수 보기(Species 제외) 
# 
# Sepal.Length Sepal.Width Petal.Length Petal.Width
# Sepal.Length    1.0000000  -0.1175698    0.8717538   0.8179411
# Sepal.Width    -0.1175698   1.0000000   -0.4284401  -0.3661259
# Petal.Length    0.8717538  -0.4284401    1.0000000   0.9628654 (높은 상관관계)
# Petal.Width     0.8179411  -0.3661259    0.9628654   1.0000000


#Petal.Length+Petal.Width
 
#x변수 들끼 계수값이 높을 수도 있다. -> 해당 변수 제거(모형 수정) <- Petal.Width

# (3) 학습데이터와 검정데이터 분류 : 기계학적 측면
nrow(iris) #150
x <- sample(1:nrow(iris), 0.7*nrow(iris)) # 전체중 70%만 추출
train <- iris[x, ] # 학습데이터 추출
test <- iris[-x, ] # 검정데이터 추출
dim(train) #105   5
dim(test) # 45  5 #모델 검정

# (4) Petal.Width 변수를 제거한 후 회귀분석 
result.model<- lm(formula=Sepal.Length ~ Sepal.Width + Petal.Length, data=train)
result.model
# Call:
#   lm(formula = Sepal.Length ~ Sepal.Width + Petal.Length, data = train)
# 
# Coefficients:
#   (Intercept)   Sepal.Width  Petal.Length  
# 2.2739        0.5983        0.4622 

library(iris)
iris_model <- lm(formula = Sepal.Length~Sepal.Width+ Petal.Length, data=train )
summary(iris_model)


#(5) model예측치 : test set
y_pred <- predict(iris_model,test)
y_pred
length(y_pred) #45
y_true <- test$Sepal.Length

#(6)model평가 :MSE, cor
# MSE(표준화o)
Error <- y_true - y_pred 
mse <- mean(Error**2)
cat('MSE=',mse) #MSE=0.09154192

#상관계수 r :표준화(X)
r <- cor(y_true,y_pred)
cat('r=',r) #r=0.9317594

y_pred[1:10]

#시각화 평가 
plot(y_true, col='blue', type='l', label='y true')
points(y_pred, col='red', type='l', label='y pred')
#범례 추가 
legend("topleft", legend=c,('y true','y pred'),
      col=c('blue','red'),pch='-')
