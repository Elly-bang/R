z= c(1:3)
is.na(z)

c(1,1,1,2) ==2

??ddply

install.packages("plyr")
library(plyr)

a<- c("Tom", "Yoon", "Kim")
mode(a)

a <- c(pi,"pi",3.14)
mode(a)

a <- c(3.14, pi, TRUE)
a
mode(a)

a<-c("A", "B", "A", "A", "B")
a
mode(a)

b<-c(1,10)
b

d<- seq(10,100,10)/10
d
c<- 1:10
c

a<- seq(1,10,1)
a

c(2,4,6,8) + C(1,3,5,7,9)
c

#input vector
vec <-c(1,2,3,4,5,6,7,8,9,10,11,12)
vec


matrix_a <- matrix(vec, byrow =F, ncol=3)
matrix_a

#matrix를 as.vector 함수에 입력 

vectorization <- as.vector(matrix_a)
vectorization  #1  2  3  4  5  6  7  8  9 10 11 12


vectorization1 <- as.vector(t(matrix_a))
vectorization1 # 1  5  9  2  6 10  3  7 11  4  8 12


x <- c(1,2,3,4,5,6,7,8,9,10,11,12)
mean(x, na.rm =T)

y <- c(1,2,3,4,5,6,7,NA,9,NA,11,12)
is.na(y) 

'''
[1] FALSE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE
[9] FALSE  TRUE FALSE FALSE
 '''
mean(y, na.rm =T) #6


install.packages("reshape")
library(reshape)

titanic = read.csv("https://vincentarelbundock.github.io/Rdatasets/csv/COUNT/titanic.csv")

head(titanic)

titanic_head = head(titanic)
titanic_head

melt_titanic= melt(titanic_head, id="X")
melt_titanic

"+"(2,3)
y=c(1,2,3,NA) *3
y

s<-c("Moday", "Tuesday", "Wednesday")
substr(s,1,2)

merge(x,y,by='', all=False)#inner join
merge(x,y,by='', all=True) #outer join



df4 <- data.frame(name=c('yoon','seo','bang','kim'),
                  age =c(30, 25, 29, 34))
df4
'''
  name age
1 yoon  30
2  seo  25
3 bang  29
4  kim  34
'''

df5 <- data.frame(name=c('bang', 'kim','gu', 'park'),
                  gender=c('f','m','f','m'),
                  city=c('seoul', 'gwangju', 'daegu', 'busan'))
df5
'''
 name gender    city
1 bang      f   seoul
2  kim      m gwangju
3   gu      f   daegu
4 park      m   busan
'''

merge(df4, df5, by='name', all=FALSE ) #inner join
#   name age gender    city
# 1 bang  29      f   seoul
# 2  kim  34      m gwangju

merge(df4, df5, by='name', all.x = TRUE ) #left outer join
#    name age gender    city
# 1 bang  29      f   seoul
# 2  kim  34      m gwangju
# 3  seo  25   <NA>    <NA>
# 4 yoon  30   <NA>    <NA>

merge(df4, df5, by='name', all.y = TRUE ) #right outer join
#    name age gender    city
# 1 bang  29      f   seoul
# 2  kim  34      m gwangju
# 3   gu  NA      f   daegu
# 4 park  NA      m   busan

profile= merge(df4, df5, by='name', all= TRUE) #outer join
#   name age gender    city
# 1 bang  29      f   seoul
# 2  kim  34      m gwangju
# 3  seo  25    <NA>    <NA>
# 4 yoon  30    <NA>    <NA>
# 5   gu  NA      f   daegu
# 6 park  NA      m   busan

학과 = c("경영학과", "경영학과","영양학과", "통계학과", "국문학과", "수학학과")


test = cbind(학과, profile)


subset(test,subset=(학과=="경영학과"))


calculate <- function(a){
  y=1
  for (i in 1:a) {
    y=y*i
  }
  print(y)
}

calculate(4)

x<-c(1:5)
y<-seq(10,50,10)
xy<-rbind(x,y)

x
y
xy[,1]

dim(b) <- c(4,5) 

x <- c(82.5, 79.2, 89.5, 85.6, 80.9)
y <- c(89.9, 88.2, 81.5, 91.5, 87.2)
z <- c(81.9, 70.3, 89.2, 83.2, 78.9)
q <- c(88.2, 83.5, 79.8, 87.5, 82.5)

b <-rbind(x,y,z,q)
b

apply(b, 1, sum) #행으로 더한값 4행 각각의 합 

apply(b, 2, sum) #열로 더한값 5열 각각의 합 

lapply(b,sum)

sapply(b, sum) 

x<-1:100
x
sum(x>50)
sum(x>50)

y<-c(1,2,3)
sum(y>2) #1

x<-c(1,2,3,NA)
mean(x)
