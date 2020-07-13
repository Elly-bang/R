##########################################
# 3. ggmap 패키지
##########################################
#공간시각화
# 공간 시각화는 지도를 기반으로 하기 때문에 
# 표현방법 : 레이어 형태로 추가하여 시각화
# 영역 : 데이터에 따른 색상과 크기 표현
##########################################         


# 지도 관련 패키지 설치
install.packages("ggmap")
library(ggmap) # get_stamenmap()
library(ggplot2) # geom_point(), geom_text(), ggsave()

#ge <- geocode('seoul') # 인증 key 필요

# 서울 : 위도(left), 경도(bottom) : 126.97797  37.56654  -> google 지도에서 검색 
# 서울 중심 좌표 : 위도 중심 좌우(126.8 ~ 127.2), 경도 중심 하상(37.38~37.6) 
seoul <- c(left = 126.77, bottom = 37.40, 
           right = 127.17, top = 37.70)
map <- get_stamenmap(seoul, zoom=7,  maptype='terrain')#'toner-2011')
ggmap(map)# maptype : terrain, watercolor

# 대구 중심 남쪽 대륙 지도 좌표 : 35.829355, 128.570088
# 대구 위도와 경도 기준으로 남한 대륙 지도  
daegu <- c(left = 123.4423013, bottom = 32.8528306, 
           right = 131.601445, top = 38.8714354)
map <- get_stamenmap(daegu, zoom=7,  maptype='terrain')
ggmap(map)

#[단계1] dataset가져오기 
pop <- read.csv(file.choose()) #201901
str(pop)

library(stringr)
head(pop)
region <-pop$'지역명'
lon <-pop$LON
lat <-pop$LAT
#문자열->숫자형
tot_pop <-as.numeric(str_replace_all(pop$'총인구수',",",""))
tot_pop

df<-data.frame(region,lon,lat,tot_pop)
df

#[단계2]지도 정보 생성

map <- get_stamenmap(daegu, zoom=7,  maptype='watercolor')#'toner-2011')
ggmap(map)

#[단계3] 레이어 1 :정적 지도 시각화 
layer1 <-ggmap(map)# maptype : terrain, watercolor
layer1

#[단계4]레이어 2: 각 지역별 지명 , 포인트 추가 
layer2<-layer1 + geom_point(data=df,aes(x=lon, y=lat,color=factor(tot_pop),size=factor(tot_pop)))

layer2

#[단계5]레이어 3: 각 지역별 포인트 옆에 지명 추가 
layer3<-layer2 + geom_text(data =df, aes(x=lon+0.01,y=lat+0.08, label=region))
layer3

#지도 이미지 file save
ggsave("C:/ITWILL/2_Rwork/Part-II/pop201901.png",scale=1, width = 10.24, height=7.68)























