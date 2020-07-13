#chap03_Dataㅣ0
#1. data불러오기 
#1)키보드 입력 (키보드 입력, 파일 가져오기)
x=scan() #숫자입력
x[3]
sum(x)
mean(x)

#문자입력
string=scan(what=character())
string

#2)파일 읽기
setwd("c:/ITWILL/2_Rwork/Part-I")

#(1) read.table():칼럼구분(공백, 특수문자)


#제목없음, 구분자:공백
student=read.table("student.txt") #제목없음, 공백 구분
student

#기본제목 v1 v2 v3 v4

#제목있는 경우,칼럼 구분: 특수문자  
student2 = read.table("student2.txt", header = TRUE, sep =";")
student2

#결축치 처리하기 -,&
student3 =read.table("student3.txt", header = TRUE, na.strings = c("-","&")) #결축치를 na로 표기
student3

mean(student3$'키',na.rm=T) 

str(student3)
class(student3) #"data.frame"

#(2)read.csv() : 구분자 :콤마(,)

student4=read.csv("student4.txt", na.strings = c("-","&")) #,header = TRUE,sep =" " 생략
student4

#탐색기 이용 파일선택

excel = read.csv(file.choose()) #excel.csv
excel

#(3)xls/xlsx :패키지 설치 
install.packages("xlsx")
install.packages("rJava")
library(rJava)
library(xlsx)

Kospi = read.xlsx("sam_kospi.xlsx",sheetIndex = 1)
Kospi

#한글이 포함된 엑셀파일 읽기
st_excel=read.xlsx("studentexcel.xlsx",sheetIndex = 1,encoding='UTF-8')
st_excel

#3)인터넷 파일 읽기
# 데이터 셋 제공 사이트 
# http://www.public.iastate.edu/~hofmann/data_in_r_sortable.html - Datasets in R packages
# https://vincentarelbundock.github.io/Rdatasets/datasets.html
# https://r-dir.com/reference/datasets.html - Dataset site
# http://www.rdatamining.com/resources/data


titanic = read.csv("https://vincentarelbundock.github.io/Rdatasets/csv/COUNT/titanic.csv")
str(titanic)
dim(titanic)
head(titanic)

#생존여부
table(titanic$survived)
# no yes 
# 817 499 

#성별구분
table(titanic$sex)
# no yes 
# 817 499 

#class구분
table(titanic$class)
# 1st class 2nd class 3rd class 
# 325       285       706 


#성별에 따른 생존여부 : 교차 분할표

tab=table(titanic$survived,titanic$sex)
#      man women
# no  694   123
# yes 175   324

#막대차트
barplot(tab,col=rainbow(2))

titanic

getOption("max.print") #1000
200*5

#행 제한 풀기
options(max.print = 999999999)
titanic

#2. 데이터 저장(출력)하기
#1) 화면출력

x=20
y=30
z=x+y
cat('z=',z) #z= 50

print(z) #함수내에서 출력
z 
print(z**2) #수식 가능
print('z=',z) #Error

#2)파일저장(출력)
# read.table =write.table :구분자( 공백, 특수문자)
# read.csv= write.csv 구분자(콤마)
# read.xlsx=write.xlsx :엑셀(패키지 필요)

#(1)write.table():공백 ??

setwd("c:/ITWILL/2_Rwork/output")


write.table(titanic,"titanic.txt",row.names = FALSE)
write.table(titanic,"titanic.txt",row.names = FALSE,quote=FALSE)


#(2)write.csv(): 콤마
head(titanic)
titanic_df = titanic[-1]
titanic_df
str(titanic_df)

write.csv(titanic_df,"titanic_df.csv",row.names=F,quote=F)

#(3)write.xlsx:엑셀파일
search() #"package:xlsx"

write.xlsx(titanic,"titanic.xlsx",sheetName = "titanic",row.names = FALSE)



