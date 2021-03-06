
##################################
##  표본의 확률분포
##################################
# 모집단으로 부터 추출한 표본들의 통계량에 대한 분포 
# - z, chi^2, t, f분포


# 1. z분포(표준정규분포) 
# 모집단의 모표준편차(σ)/모분산(σ^2)이 알려진 경우 사용 
# 용도: 평균치와 표준편차를 달리하는 모든 정규분포를 µ=0, σ=1을 
# 갖는 표준정규분포로 표준화 

# 표준화공식(Z) = (X - mu) / sigma : 정규분포 -> 표준정규분포 

# 2. chi^2 분포
# 표준정규분포를 따르는 변수의 제곱합에 대한 분포
# chi^2 =  (X - mu)^2 / sigma^2 : 표준정규분포 Z를 제곱한 것
# 몇개를 합햇는냐에 따라서 카이제곱분포의 모수인 '자유도'가 결정 
# 용도: 정규분포를 따르는 변수의 분산에 대한 신뢰구간을 구할 때 이용 

# 3. t분포
# 모집단의 모표준편차(σ)/모분산(σ^2)이 알려지지 않은 경우 사용
# z분포와 유사
# 용도: 정규분포를 따르는 집단의 평균에 대한 가설검정(모평균 추정)
#  or 두 집단의 평균차이 검정을 할 경우 이용
# 표본의 표준편차(S)를 이용하여 모집단 추정 
# T =  (X - mu) / S -> 표본의 표준편차 

# 4. F분포
# 두 카이제곱분포를 각각의 자유도로 나눈 다음, 그것의 비율을 나타낸 분포 
# 서로 다른 카이제곱 분포의 비율의 형태로 표현 
# F = V1/u1 / V2/u2
# 용도: 정규분포를 따르는 두 집단의 분산에 대한 가설검정을 할 경우 이용 

#################################################################
##########표준화 vs 정규화 ######################################
#################################################################

#1. 표준화 :척도 일치 37p.정규 분포 vs 표준 정규 분포

# 평균과 표준편차를 일치 시킨다. 
# 1. 표준화 :척도 (평균=0, 표준편차=1)일치 
# -정규분포 -> 표준 정규분포

#샘플링
n <-1000
z<-rnorm(n,mean=100, sd=10) #z분포
shapiro.test(z)

# Shapiro-Wilk normality test
# 
# data:  z
# W = 0.99924, p-value = 0.9645

hist(z,freq=F)

#(z) =(x-mu)/sigma 
# 표준화공식(Z) = (X - mu)/sigma 
mu=mean(z)
z=(z-mu)/sd(z) #정규 -> 표준정규
mean(z) #1.783892
sd(z) #1

#2) 표준화 함수 
z2 <- scale(z) 
mean(z2) #1.009796e-16
sd(z2) #1 

hist(z)

#2. 정규화 :값의 범위(0~1) 일치 
# x1(-100~100),x2(-0.1~0.9), x3(-1000~1000) ->y
#-서로 다른 변수의 값을 일정한 값으로 조정
#nor= (x-min) / (max-min)

nor <- function(x){ #0~1정규화
  re=(x-min(x)) / (max(x)-min(x))
  return(re)
}

summary(iris[-5])
nor_re <- apply(iris[-5],2,nor)
summary(nor_re)














































