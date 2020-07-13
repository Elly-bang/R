#7.장 연습문제 

#01.본문에서 생성된 dataset2의 직급(position)칼럼을 대상으로 역코딩 하여 
#positon2칼럼에 추가 하시오 


dataset2

#3)역코딩 :1->5, 5->1로 변경 
table(dataset2$position)

survey <-dataset2$position
cpo <-  6-position #역코딩
dataset2$position <-cpo
table(dataset2$position)

dataset2$position2[dataset2$position==1]

range(dataset2$position) 
dataset2$position[dataset2$position ==1] <-"1급"
dataset2$position[dataset2$position ==1] <-"2급"
dataset2$position[dataset2$position ==1] <-"3급"
dataset2$position[dataset2$position ==1] <-"4급"
dataset2$position[dataset2$position ==1] <-"5급"

head(dataset2[c(position1,position2)])


#02.dataset2의 resident칼럼을 대상으로 NA값을 제거한 후 dataset3변수에 저장하시오 

dim(dataset2)

dataset3 <- subset(dataset2,!is.na(resident))

dim(dataset3)


#03.dataset3의 gender를 대상으로 남자 1, 여자 2를 칼럼에 추가하고, 파이 차트 생성

dataset3

dataset3$gender[dataset3$gender==1] <-"남자"
dataset3$gender[dataset3$gender==2] <-"여자"

pie(table(dataset3$gender))

