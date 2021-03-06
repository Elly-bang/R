#################################
## <제18장 연습문제>
################################# 

# 01. iris 데이터 셋의 1~4번째 변수를 대상으로 유클리드 거리 매트릭스를 구하여 
# idist에 저장한 후 계층적 클러스터링을 적용하여 결과를 시각화 하시오.

iris[1:4] # 4개변수 전체


#단계1. 유클리드 거리 계산
distance <-dist(iris[1:4] )

#단계2. 계층형 군집분석(클러스터링)
hc<-hclust(distance)

#단계3. 분류결과를 대상으로 음수값을 제거하여 덴드로그램 시각화
plot(hc,hang=-1)

#단계4. 그룹수를 4개로 지정하고 그룹별로 테두리 표시
rect.hclust(hc,k=4,border = 'red')

ghc #150개 그룹을 
  
# 02. 다음과 같은 조건을 이용하여 각 단계별로 비계층적 군집분석을 수행하시오.

# 조건1) 대상 파일 : product_sales.csv
# 조건2) 변수 설명 : tot_price : 총구매액, buy_count : 구매횟수, 
#                    visit_count : 매장방문횟수, avg_price : 평균구매액

setwd("c:/ITWILL/2_Rwork/Part-IV")
sales <- read.csv("product_sales.csv", header=TRUE)
head(sales) 


# 단계1: 비계층적 군집분석 : 3개 군집으로 군집화

result<-kmeans(sales,3)
result

# 단계2: 원형데이터에 군집수 추가

sales$cluster<-result$cluster
head(sales)
table(sales$cluster)
# 단계3 : tot_price 변수와 가장 상관계수가 높은 변수와 군집분석 시각화
cor(sales[,-5]) #0.9627571
plot(sales$tot_price,sales$avg_price,col=sales$cluster,main="상품구매 군집 분석")

# 단계4. 군집의 중심점 표시

points(result$centers[,c("visit_count","avg_price")], col=c(3,1,2), pch=8, cex=5)
points














