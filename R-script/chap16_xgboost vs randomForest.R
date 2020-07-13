
# xgboost vs randomForest
# - xgboost : boosting 방식 
# - randomForest : bagging 방식 

# 1. package install
install.packages("xgboost")
library(xgboost)
#library(help="xgboost")

# 2. dataset load/search
data(agaricus.train)
data(agaricus.test)

train <- agaricus.train
test <- agaricus.test

str(train) # $ key, @객체에서 호출가능한 memeber
train$data@Dim #6 slots
# class-> object
# java,python:object.member 
# R :object@member 
# 6slots =memeber (@ i .@ p@ Dim@ Dimnames@ x,@ factors
# $ data : x변수 : [6513,126] 2차원의 매트릭스
# $ label :독성구분 y변수, num [1:6513] 1차원의 벡터구조

str(test)

#$data :x변수 [1611:126] 2차원
#$label : y변수 num [1:1611] 1차원

train$data
train$label
table(train$label)
# 0    1    (분류정확도 : 0,1의 비율이 비슷)
# 3373 3140 

# 3. xgboost matrix 생성 : 객체 정보 확인  
# xgb.DMatrix(data = x, train$data, label =y)
dtrain <- xgb.DMatrix(data = train$data, label = train$label) # x:data, y:label
dtrain dim: 6513 x 126  

?xgboost
#We will train decision tree model using the following parameters:
# •objective = "binary:logistic": we will train a binary classification model ;
# "binary:logistic" : y변수 이항 
# •max_depth = 2: the trees won't be deep, because our case is very simple ;
# tree 구조가 간단한 경우 : 2
# •nthread = 2: the number of cpu threads we are going to use;
# cpu 사용 수 : 2
# •nrounds = 2: there will be two passes on the data, the second one will enhance the model by further reducing the difference between ground truth and prediction.
# 실제값과 예측값의 차이를 줄이기 위한 반복학습 횟수 
# •eta = 1 : eta control the learning rate 
# 학습률을 제어하는 변수(Default: 0.3) 
# 숫자가 낮을 수록 모델의 복잡도가 높아지고, 컴퓨팅 파워가 더많이 소요
# 부스팅 과정을보다 일반화하여 오버 피팅을 방지하는 데 사용
# •verbose = 0 : no message
# 0이면 no message, 1이면 성능에 대한 정보 인쇄, 2이면 몇 가지 추가 정보 인쇄

# 4. model 생성 : xgboost matrix 객체 이용  
xgb_model <- xgboost(data = dtrain, max_depth = 2, eta = 1, nthread = 2, nrounds = 2, objective = "binary:logistic", verbose = 0)

# 5.  학습된 model의 변수(feature) 중요도/영향력 보기 
import <- xgb.importance(colnames(train$data), model = xgb_model)
import
#           Feature영향력 순    Gain     Cover Frequency Importance
# 1:               odor=none 0.67615471 0.4978746       0.4 0.67615471
# 2:         stalk-root=club 0.17135375 0.1920543       0.2 0.17135375
# 3:       stalk-root=rooted 0.12317236 0.1638750       0.2 0.12317236
# 4: spore-print-color=green 0.02931918 0.1461960       0.2 0.02931918
colnames(train$data)
xgb.plot.importance(importance_matrix = import)

#6.예측치
pred <-predict(xgb_model,test$data)
range(pred) # 0.01072847 0.92392391

y_pred <- ifelse(pred>=0.5, 1, 0)
y_true <-test$label

table(y_true)

tab<-table(y_true,y_pred)
tab
# 
#       y_pred
# y_true   0   1
# 0       813  22
# 1        13 763


#7. model평가 

#1)분류정확도
acc<-tab[1,1]+tab[2,2]/length(y_true)
cat('분류정확도=',acc) #분류정확도= 813.4736
range(acc)

#2)평균 오차 
#T/F ->숫자형 변환(1,0)
mean_err<- mean(as.numeric(pred>=0.5) !=y_true)
cat('평균오차=', mean_err)
#평균오차= 0.02172564


#8. model save& load 

setwd("c:/ITWILL/w_Rwork/output")
xgb.save(xgb_model, 'xgboost.model') #[1] TRUE

rm(list=ls())

#2)model load(memory loading)
xbg_model2<-xbg.load('xgboost.model')

pred2 <- predict(xgb_model2, test$data)
range(pred2)


################################
## iris dataset : y이항분류
################################
iris_df <-iris #복제론

#1. y변수 -> binary
iris_df$species<-ifelse()
str(iris_df)
table(iris_df$species)

2. dataset 생성 
idx<-sample(nrow(iris_df),nrow(iris_df)*0.7)
train<- iris_df[idx,]
test <- iris_df[-idx,]

#x: matrix, y: vector
train_x<-train[,-5]
train_y<-train$Species
str(train_y)

#3.DMmatrix 생성
DMmatrix
dtain <-xgb.DMmatrix(data=train_x, label=train_y)

#4.  xgboost생성
xgb_iris_model <-  xgboost(data=dtrain,max_depth=2,)
xgb_iris_model
#5.학습된model의 변수(feature)중요도/영향력
import <- xgb.importance(colnames(train_x), model = xgb_model)
import #petal.Length

#6. 예측치 
predict(import, test)
test_x<-as.matrix(teset[,-5])
test_y<-test$Species

pred,-predict(xgb_iris_model,test_x)
range(pred)

y_pred<- ifelse(pred>= 0.5,1,0)

tabel(test_y,y_pred)

tab<-table(test_y,y_pred)
tab[1,1]+tab[2,2]/length(test_y)
cat('분류정확도=',acc*100,'%')










