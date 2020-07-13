

mpg <- as.data.frame(ggplot2::mpg)
mpg <- left_join(mpg, fuel, by=f1)


mpg %>%  
  select(model, fa, price_f1) %>% 
  head()

ANSI

#결측치 찾기 

df <- data.frame(sex=c("M", "F", NA, "M", "F"),
                 score=c(5,4,3,4,NA))
df

is.na(df) #is로 시작하는 함수들은 해당 변수가 특정 속성을 지니고 있는지 확인한 후 
#T, F로 반호나하는 기능 

table(is.na(df)) 

table(is.na(df$score))

#결측치가 포함되면 함수가 적용되지 않으므로, 결측치 제거 합니다. 
mean(df$score)

#결측치 제거하기

library(dplyr)
#score에 결측치인 행만 출력
df %>% filter(is.na(score))
#score에 결측치 아닌 행만 출력 
df %>% filter(!is.na(score))

df_nomiss <- df %>% filter(!is.na(score))
mean(df_nomiss$score)
sum(df_nomiss$score)

#결측치가 없는 조건으로 출력
df_nomiss <- df %>% filter(!is.na(score)& !is.na(sex))
df_nomiss


mean(df_nomiss$score)

mean(df_nomiss)


#한글 에러 메시지-> 영문 변환
Sys.setenv("language"="en")


#결측치가 하나라도 있으면 제거하기 : 한번에 제거 

df_nomiss <-filter(!is.na(score)&!is.na(sex)) #일일히 작성
df_nomiss <- na.omit(df) #한번에 결측치 제거
df_nomiss

mean(df_nomiss$score)

#단점  : 결측치가 있는 모든 행이 소실 , 따라서 filter를 사용할 때가 많다. 

#mean()와 같은 수치 연산 함수들은 결측치 제외하고연산 =>  na.rm 
#na.rm=T 로 설정하면 한번에 결측치 제외가능. 

#1. na.rm 

mean(df$score, na.rm=T)
sum(df$score, na.rm = T)

2. summarise()

exam <- read.csv("csv_exam.csv")
exam[c(3,8,15), "math"]
exam





