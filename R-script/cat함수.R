setwd("C:/ITWILL/2_Rwork/Part-I")
read.csv(file="student4.txt",sep=",",header = FALSE, na.strings = "-")

install.packages("XML")
library(XML)


info.url ="http://www.infoplease.com/ipa/A0104652.html”

cat() 함수
x <- 10
y <- 20
z <- x * y
cat("x*y의 결과는 ", z ," 입니다.\n")
cat("x*y = ", z)
