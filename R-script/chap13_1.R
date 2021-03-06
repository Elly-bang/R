#############################################
# 추론통계분석 - 1-1. 단일집단 비율차이 검정
#############################################
# - 단일 집단의 비율이 어떤 특정한 값과 같은지를 검증

# 1. 실습데이터 가져오기
setwd("C:/SUNMOON/2_Rwork/Part-III")
data <- read.csv("one_sample.csv", header=TRUE)
head(data)
x <- data$survey


# 2. 빈도수와 비율 계산
summary(x) # 결측치 확인
length(x) # 150개
table(x) # 0:불만족(14), 1: 만족(136) 
prop.table(table(x))
# 0          1 
# 0.09333333 0.90666667

# 3. 가설검정 

# 형식) binom.test(성공횟수, 시행횟수, p = 확률)

# 1) 불만족율 기준 검정
# 양측검정
binom.test(14, 150, p=0.2) # 기존 20% 불만족율 기준 검증 실시
binom.test(14, 150, p=0.2, alternative="two.sided", conf.level=0.95)
#p-value = 0.0006735 #판단 <0.05 : 차이가 없다. 

#기각일때 =>방향성이 있는 대립가설 단측 검정을 확인한다. 

# 방향성이 있는 대립가설 단측 검정 : new > old 
binom.test(14, 150, p=0.2, alternative="greater", conf.level=0.95)
#p-value = 0.9999   >0.05    (기각)

# [실습]방향성이 있는 대립가설 검정 new < old 
binom.test(14, 150, p=0.2, alternative="less", conf.level=0.95)
# p-value = 0.0003179 <0.05  (채택)

#############################################
# 추론통계분석 - 1-2. 단일집단 평균차이 검정
#############################################
# - 단일 집단의 평균이 어떤 특정한 값과 차이가 있는지를 검증
# t분포 용도: 정규분포를 따르는 집단의 평균에 대한 가설검정

# 1. 실습파일 가져오기
data <- read.csv("one_sample.csv", header=TRUE)
str(data) # 150
head(data)
x <- data$time
head(x)

# 2. 기술통계량 평균 계산
summary(x) # NA-41개
mean(x) # NA
mean(x, na.rm=T) # NA 제외 평균(방법1)

x1 <- na.omit(x) # NA 제외 평균(방법2)
mean(x1) #5.556881

# 3. 정규분포 검정
# 정규분포(바른 분포) : 평균에 대한 검정 
# 정규분포 검정 귀무가설 : 정규분포와 차이가 없다.
# shapiro.test() : 정규분포 검정 함수

shapiro.test(x1) # 정규분포 검정 함수(p-value = 0.7242) 
# p-value = 0.7242 >=0.05 

# 4. 가설검정 - 모수/비모수
# 정규분포(모수검정) -> t.test()
# 비정규분포(비모수검정) -> wilcox.test(x1, mu=5.2)

# 1) 양측검정 - 정제 데이터와 5.2시간 비교
t.test(x1, mu=5.2) #new vs old 
t.test(x1, mu=5.2, alter="two.side", conf.level=0.95) # p-value = 0.0001417
# t = 3.9461, df = 108, 
# t,z,F검정 통계량(채택역:-1.96~+1.96) 이므로 t=3.9461으로 채택역의 오른쪽에 위치 기각.

# p-value = 0.0001417 <0.05 :기각 

# 해설 : 평균 사용시간 5.2시간과 차이가 있다.

# 2) 방향성이 있는 연구가설 검정 : 

#new >old p-value = 7.083e-05 (-> 0.0000708) (채택)
 t.test(x1, mu=5.2, alter="greater", conf.level=0.95) 

 #new <old p-value = 0.9999 (기각)
t.test(x1, mu=5.2, alter="less", conf.level=0.95) 





