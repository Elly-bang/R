# chap09_1_Formal(2_Maria_DB)

# Maria DB 정형 데이터 처리

# 패키지 설치
# - RJDBC 패키지를 사용하기 위해서는 우선 java를 설치해야 한다.
#install.packages("rJava")
#install.packages("DBI")
#install.packages("RJDBC") # JDBC()함수 제공 

# 패키지 로딩
library(DBI)
Sys.setenv(JAVA_HOME='C:\\Program Files\\Java\\jre1.8.0_151')
library(rJava)
library(RJDBC) # rJava에 의존적이다.

################ MariaDB or MySql ###############
drv <- JDBC(driverClass="com.mysql.jdbc.Driver", 
            classPath="C:/ITWILL/2_Rwork/tools(R)/MariaDB/mysql-connector-java-5.1.46/mysql-connector-java-5.1.46/mysql-connector-java-5.1.46-bin.jar")


# driver가 완전히 로드된 후 db를 연결한다.
conn <- dbConnect(drv, "jdbc:mysql://127.0.0.1:3306/work", "scott", "tiger") #127.0.0.1 :내 컴퓨터 

#################################################           


# DB 연결 확인 :  테이블의 컬럼 보기 
dbListFields(conn, "goods") # conn, table name

query <-"show tables"
dbGetQuery(conn, query)

#Tables_in_work
#goods

#레코드 조회 
dbGetQuery(conn,"select*from goods")

#DB구조 변경
#1. 레코드 추가 
query <- "insert into goods values(5,'전화기',4,450000)"
dbSendUpdate(conn, query)
dbGetQuery(conn,"select*from goods")

#2. 레코드 수정 :'전화기'-> 'phone'
query <- "update goods set name ='phone' where name='전화기'"
dbSendUpdate(conn, query)
dbGetQuery(conn,"select*from goods")

#3. 레코드 삭제 :code=5삭제하기 
dbSendUpdate (conn, "delete from goods where name='phone'")

#R변수 저장 
goods <- dbGetQuery(conn,"select*from goods")
goods
str(goods)

price <-goods$su*goods$dan
goods$price <- price
goods

#table -> 처리-> file save 
write.csv(goods, "goods.csv", quote= T , row.names=F)
getwd() # "C:/ITWILL/2_Rwork"


#table -> 처리 -> table save 

#[단계1] table 생성 
query <- "create table goods_manager(code int, name varchar(50), su int , dan int , price int)"
dbSendUpdate(conn, query)
dbGetQuery(conn,"show tables")

dbGetQuery(conn,"select*from goods_manager")
# [1] code  name  su    dan   price
# <0 행> <또는 row.names의 길이가 0입니다>

dbSendUpdate(conn,"drop table goods_manager")

#R object-> table save 
dbWriteTable(conn,name="goods_manager",goods_df)
dbGetQuery(conn,"show tables")
dbGetQuery(conn,"select*from goods_manager")
dbDisconnect(conn)


##################################
library(help = DBI)
library(help=dplyr)
??RJDBC
######################################
























